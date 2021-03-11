<?php 
require '../../db/conexion.php';
 
	  class users_model 
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

		  	public function save_user($datos)
		  	{
		  		$consulta=$this->conectar->query("insert into usuario
		  			(nombre_usuario,contrasena,correo,puesto,nombre_completo,no_colaborador,
		  			personal_externo,departamento_usuario,idrol) 
		  			values
		  			('$datos->usuario','$datos->contrasena','$datos->correo','$datos->puesto','$datos->nombre".' '."$datos->apellido_paterno".' '."$datos->apellido_materno',$datos->numeroColaborador,'$datos->personalExterno','$datos->departamento',$datos->rol)");

		  		return $consulta;
		  	}

		  	public function search_user($buscar)
		  	{
		  		$consulta=$this->conectar->query("select * from  usuarios_roles where $buscar->filtro LIKE '%$buscar->campo%'" );
		  		while($filas=$consulta->fetch_assoc())
		        {
		            $this->usuario[]=$filas;
		        }

		        return $this->usuario;
		  	}

		  	public function delete_user($id)
		  	{
		  		$consulta=$this->conectar->query("delete from usuario where idusuario=$id");
		  		return $consulta;
		  	}


		  	
	  }
?>

