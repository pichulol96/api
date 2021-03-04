<?php require '../db/conexion.php';
 
	  class articulos_model 
	  {
		  	private $conectar;
		  	public $articulos;
		  	public $resultados;

		  	function __construct()
		  	{
		  		$this->conectar=conectar::conexion();
		  		$this->articulos=array();
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

		  	public function insert_articulos($datos)
		  	{
		  		$consulta=$this->conectar->query("insert into articulos
		  			(categoria,marca,modelo,no_serie,no_inventario,cantidad,descripcion,localizacion,imagen,idusuario,estado) 
		  			values
		  			('$datos->categoria','$datos->marca','$datos->modelo','$datos->serie','$datos->inventario',$datos->cantidad,'$datos->descripcion','$datos->localizacion','$datos->imagen','1','activo')  ");

		  		return $consulta;
		  	}

		  	public function delete_articulos($id)
		  	{
		  		$consulta=$this->conectar->query("call eliminar_articulos($id);");
		  		return $consulta;
		  	}

		  	public function bajas_articulos($datos)
		  	{
		  		 date_default_timezone_set('America/Mexico_City');
					 $time=time();               ////Fecha/////
					 $fecha=date("Y-m-d");/////Actual///
					 $hoy = date("H:i:s"); 
                     
                     foreach ($datos as $recorrer) 
                     { //para sacar el colaborador y las observaciones
			  			if(isset($recorrer->observaciones))
			  			{
			  				$observaciones=$recorrer->observaciones;
			  				//$colaborador=$recorrer->colaborador;
			  			}
		  			 }
		  			 

		  		$insertResguardo=$this->conectar->query("insert into bajas_articulos
		  			(fecha,hora,idusuario,descripcion)
		  			values
		  			('$fecha','$hoy',1,'$observaciones')");

		  		if($insertResguardo==true)
		  		{
			  		  $resultado=$this->conectar->query("select id_bajas from bajas_articulos order by id_bajas desc limit 1");
			  		  while($resguardoID=mysqli_fetch_array($resultado))
			  		  {
	                     $id_resguardo=$resguardoID['id_bajas'];
			  		  }
		  		}
		  		else
		  		{
		  			return 0;
		  		}

		  		foreach ($datos as $dato) {
		  			if(isset($dato->id))
		  			{
		  				 $consulta=$this->conectar->query("insert into detalles_bajas_articulos
			  			(idbajas,idarticulos) 
			  			values
			  			($id_resguardo,'$dato->id')");
		  			}
		  			
		  		
		  		}
                
		  		return $id_resguardo;
		  	}

		  	public function search_articulos($buscar)
		  	{
		  		$consulta=$this->conectar->query("select * from  articulos where $buscar->filtro LIKE '%$buscar->campo%' and estado !='eliminado'" );
		  		while($filas=$consulta->fetch_assoc())
		        {
		            $this->articulos[]=$filas;
		        }

		        return $this->articulos;
		  	}
	  }
?>

