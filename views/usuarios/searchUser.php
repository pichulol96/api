<?php 
//require '../controllers/ArticulosController.php';
header("Access-Control-Allow-Origin:*");
//header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
header("Context-type: application/json;");
require '../../models/userModel.php';


 $user=new users_model();
 $json = file_get_contents('php://input');
 $params = json_decode($json);
	$datos=$user->search_user($params);
	if($datos==true)
	{
      echo json_encode($datos);
	}
	else
	{
		echo json_encode($datos);
	}
	





 ?>