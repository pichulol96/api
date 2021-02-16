<?php 
//require '../controllers/ArticulosController.php';
header("Access-Control-Allow-Origin:*");
header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
header("Context-type: application/json;");
require '../models/articulosModel.php';


$articulos=new articulos_model();
 $json = file_get_contents('php://input');
 $params = json_decode($json);
  $x=1;
if($x==1)
{
	$x=2;
	$datos=$articulos->insert_articulos($params);
	echo json_encode("Articulo registador");

}
else
{
	echo json_encode("Hubo un error");
}


 ?>