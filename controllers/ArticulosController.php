<?php 
require '../models/articulosModel.php';
$articulos=new articulos_model();
$opcion=$_SERVER["REQUEST_METHOD"];
//$jsonArticulos= json_decode(file_get_contents("php://input"));
switch ($opcion) 
{
	case 'GET':
 	$datos=$articulos->get_articulos();
	echo json_encode($datos);
	break;

	case 'POST':
	$jsonArticulos= json_decode(file_get_contents("php://input"));
	$datos=$articulos->get_articulos();
	echo json_encode($datos);
	//$datos=$articulos->insert_articulos($jsonArticulos);

	break;
	
	default:
		echo json_encode("Sin resulta");
	break;
}



 ?>