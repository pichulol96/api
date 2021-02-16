<?php 
require '../../db/conexion.php';
 
	  class persona_model 
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
		            $this->articulos[]=$filas;
		        }

		        return $this->articulos;
		  	}
	  }
?>

