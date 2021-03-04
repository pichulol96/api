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

		  	public function search_articulos($buscar)
		  	{
		  		$consulta=$this->conectar->query("select * from  articulos where $buscar->filtro LIKE '%$buscar->campo%'");
		  		while($filas=$consulta->fetch_assoc())
		        {
		            $this->articulos[]=$filas;
		        }

		        return $this->articulos;
		  	}
	  }
?>

