<?php 
//require '../controllers/ArticulosController.php';
//session_start();
header("Access-Control-Allow-Origin:*");
header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
header("Context-type: application/json;");
require '../../models/personaModel.php';


$resguardo=new persona_model();
 $json = file_get_contents('php://input');
 $params = json_decode($json);

	$datos=$resguardo->insert_resguardo($params);
	if($datos>0)
	{
		echo json_encode($datos);
	}
	else
	{
		echo json_encode("Hubo un error");
	}



 ?>