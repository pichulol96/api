<?php 
require '../../db/conexion.php';
 
	  class roles_model 
	  {
		  	private $conectar;
		  	public $roles;
		  	public $resultados;

		  	function __construct()
		  	{
		  		$this->conectar=conectar::conexion();
		  		$this->personas=array();
		  		$this->usuario=array();
		  	}

		  	public function get_roles()
		  	{
		  		$roles=array();
		  		$consulta=$this->conectar->query("select * from roles");
		        while($filas=$consulta->fetch_assoc())
		        {
		            $roles[]=$filas;

		        }
		       // $resul=$this->conectar->num_rows($consulta);
		       // $resul=mysqli_num_rows($consulta);
		        return $roles;
                

		       

		  	}


		  	
	  }
?>

