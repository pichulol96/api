<?php 
//require '../controllers/ArticulosController.php';
header("Access-Control-Allow-Origin:*");
header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
header("Context-type: application/json;");
require '../../models/loginModel.php';


 $user=new login_model ();
 $json = file_get_contents('php://input');
 $params = json_decode($json);
	$datos=$user->search_usuario($params);
	if($datos==true)
	{
      echo json_encode($datos);
	}
	else
	{
		echo json_encode($datos);
	}
	





 ?>