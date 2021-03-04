<?php 
require '../../db/conexion.php';
 
	  class persona_model 
	  {
		  	private $conectar;
		  	public $personas;
		  	public $resultados;

		  	function __construct()
		  	{
		  		$this->conectar=conectar::conexion();
		  		$this->personas=array();
		  		$this->resguardo=array();
		  	}

		  	public function get_articulos()
		  	{
		  		$consulta=$this->conectar->query("select * from articulos where id_articulo>=0;");
		        while($filas=$consulta->fetch_assoc())
		        {
		            $this->articulos[]=$filas;
		        }

		        return $this->articulos;

		  	}

		  	public function insert_persona($datos)
		  	{
		  		$verifica=$this->conectar->query("select no_colaborador from persona where no_colaborador=$datos->numeroColaborador");
                $rows=mysqli_num_rows($verifica);
		  		
		  		if($rows>0)
		  		{
                   return 0;
		  		}
		  		else
		  		{
		  			$consulta=$this->conectar->query("insert into persona
		  			(no_colaborador,nombre,apellidos,correo,puesto,departamento) 
		  			values
		  			($datos->numeroColaborador,'$datos->nombre','$datos->apellido','$datos->correo','$datos->puesto','$datos->departamento')  ");

		  		      return $consulta;
		  		}
		  		
		  	}

		  		public function insert_resguardo($datos)
		  	{

		  		     date_default_timezone_set('America/Mexico_City');
					 $time=time();               ////Fecha/////
					 $fecha=date("Y-m-d");/////Actual///
					 $hoy = date("H:i:s"); 
                     
                     foreach ($datos as $recorrer) 
                     { //para sacar el colaborador y las observaciones
			  			if(isset($recorrer->observaciones) &&($recorrer->colaborador))
			  			{
			  				$observaciones=$recorrer->observaciones;
			  				$colaborador=$recorrer->colaborador;
			  			}
		  			 }
		  			 if($colaborador)
		  			 {
		  			 	$person=$this->conectar->query("select idpersona from persona where no_colaborador=$colaborador  limit 1");
				  		  while($colaboradorID=mysqli_fetch_array($person))
				  		  {
		                     $id_persona=$colaboradorID['idpersona'];
				  		  }
		  			 }

		  		$insertResguardo=$this->conectar->query("insert into resguardos
		  			(fecha,hora,observaciones,idusuario,idpersona,estado)
		  			values
		  			('$fecha','$hoy','$observaciones',1,$id_persona,'altas')");

		  		if($insertResguardo==true)
		  		{
			  		  $resultado=$this->conectar->query("select id_resguardo from resguardos order by id_resguardo desc limit 1");
			  		  while($resguardoID=mysqli_fetch_array($resultado))
			  		  {
	                     $id_resguardo=$resguardoID['id_resguardo'];
			  		  }
		  		}
		  		else
		  		{
		  			return 0;
		  		}

		  		foreach ($datos as $dato) {
		  			if(isset($dato->id))
		  			{
		  				 $consulta=$this->conectar->query("insert into detalles_resguardo
			  			(idresguardo,idarticulos,cantidad) 
			  			values
			  			($id_resguardo,'$dato->id',1)");
		  			}
		  			
		  		
		  		}
                
		  		return $id_resguardo;
		  	}

		  	public function delete_resguardo($id)
		  	{
		  		$resultados=array();
		  		$consulta=$this->conectar->query("update resguardos set estado='bajas' where id_resguardo=$id");
		  		$selecionar=$this->conectar->query("select idarticulos from detalles_resguardo where idresguardo=$id");
		  		while($filas=mysqli_fetch_array($selecionar))
		        {
		           $update_articulos=$this->conectar->query("update articulos set estado='activo' where id_articulo=$filas[idarticulos]");
		        }


		  		return $update_articulos;
		  	}

		  	public function search_persona($buscar)
		  	{
		  		$consulta=$this->conectar->query("select * from persona where no_colaborador = $buscar->campo");
		  		while($filas=$consulta->fetch_assoc())
		        {
		            $this->personas[]=$filas;
		        }

		        return $this->personas;
		  	}

		  		public function search_resguardo($buscar)
		  	{
		  		$consulta=$this->conectar->query("select * from  resguardos_entregados where $buscar->filtro LIKE '%$buscar->campo%'");
		  		while($filas=$consulta->fetch_assoc())
		        {
		            $this->resguardo[]=$filas;
		        }

		        return $this->resguardo;
		  	}
	  }
?>

