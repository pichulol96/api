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

		  		$insertResguardo=$this->conectar->query("insert into resguardos
		  			(fecha,hora,observaciones,idusuario,idpersona)
		  			values
		  			('$fecha','$hoy','bueno',1,1)");

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
		  		return $consulta;
		  	}

		  	public function delete_articulos($id)
		  	{
		  		$consulta=$this->conectar->query("delete from articulos where id_articulo=$id");
		  		return $consulta;
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
	  }
?>

