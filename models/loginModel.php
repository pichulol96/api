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
		  		
		  		$users=array();
		  		$consulta=$this->conectar->query("select * from usuario where nombre_usuario='$data->user' and contrasena='$data->password'");
		        while($filas=$consulta->fetch_assoc())
		        {
		            $users[]=$filas;

		        }
		        
		        	/*foreach ($users as $user) {
		        		$_SESSION['user_logeado']=$user['idusuario'];
		        	}*/
		        
		       // $resul=$this->conectar->num_rows($consulta);
		       // $resul=mysqli_num_rows($consulta);
		        	//session_destroy();
		        return $users;
                

		       

		  	}


		  	
	  }
?>

