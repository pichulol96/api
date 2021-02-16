<?php
header("Access-Control-Allow-Origin:*");
header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
header("Access-Control-Allow-Methods: DELETE");
header("Context-type: application/json;");
require '../models/articulosModel.php';

$metodo = $_SERVER["REQUEST_METHOD"];
if ($metodo != "DELETE" && $metodo != "OPTIONS") {
    exit("Solo se permite método DELETE");
}

if (empty($_GET["id"])) {
    exit("No hay id de mascota para eliminar");
}
$id = $_GET["id"];

 $articulos=new articulos_model();
 $datos=$articulos->delete_articulos($id);
 if($datos==true)	
 {
     echo json_encode("eliminado");
 }
 else
 {
   echo json_encode("No se elimino");
 }
