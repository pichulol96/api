<?php 
//require '../controllers/ArticulosController.php';
header("Access-Control-Allow-Origin:*");
//header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
header("Context-type: application/json;");
require '../../models/rolesModel.php';

$roles=new roles_model ();
$datos=$roles->get_roles();
//echo json_encode($datos);
    if($datos==true)
	{
      echo json_encode($datos);
	}
	else
	{
		echo json_encode($datos);
	}





 ?>