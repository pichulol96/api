<?php 
//require '../controllers/ArticulosController.php';
header("Access-Control-Allow-Origin:*");
header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
header("Context-type: application/json;");
require '../models/articulosModel.php';


 $articulos=new articulos_model();
 $json = file_get_contents('php://input');
 $params = json_decode($json);
	$datos=$articulos->edit_articulo($params);
	if($datos==true)
	{
      echo json_encode($datos);
	}
	else
	{
		echo json_encode($datos);
	}
	





 ?>