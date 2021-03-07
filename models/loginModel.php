<?php 
require '../../db/conexion.php';
 
	  class login_model 
	  {
		  	private $conectar;
		  	public $usuario;
		  	public $resultados;

		  	function __construct()
		  	{
		  		$this->conectar=conectar::conexion();
		  		$this->personas=array();
		  		$this->usuario=array();
		  	}

		  	public function search_usuario($data)
		  	{
		  		$user=array();
		  		$consulta=$this->conectar->query("select * from usuario where nombre_usuario='$data->user' and contrasena='$data->password'");
		        while($filas=$consulta->fetch_assoc())
		        {
		            $user[]=$filas;

		        }
		       // $resul=$this->conectar->num_rows($consulta);
		       // $resul=mysqli_num_rows($consulta);
		        return $user;
                

		       

		  	}


		  	
	  }
?>

