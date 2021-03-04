<?php
$folio=$_REQUEST['id'];
if($folio=="")
{
  return ;
}
require('../fpdf/fpdf.php');
date_default_timezone_set('America/Mexico_City');
$time=time();               ////Fecha/////
$fecha=date("d-m-Y",$time);/////Actual///
$modo="I";
$nombre_archivo="Materiales".$fecha.".pdf";

class PDF extends FPDF
{
    // Cabecera de página

function Header()
{
    // Logo                     largo,altura
    $this->Image('../archivos/1.png',5,5,200,25);
    // Arial bold 15
    $this->SetFont('Arial','B',12);
    // Movernos a la derecha
    $this->Cell(80);

    // Título
    $this->Ln(15);
    //          largo,alto celda
    $this->Cell(191,35,'',0,0,'C',0,0);
    $this->Cell(-190,20,'ANALIZA INTEGRA TURISTICA S.A DE C.V',0,0,'C');
    $this->Cell(190,30,utf8_decode('COMPROBAMTE DE RESGUARDO'),0,0,'C');
    /*$this->Cell(-190,40,'Subdireccion Administrativa',0,0,'C');
    $this->Cell(190,50,'Cordinacion De Mantenimiento',0,0,'C');
    $this->Cell(-190,60,'Lista De Compras',0,0,'C');
    */
    
   
    

    

    // Salto de línea
    $this->Ln(20);
    //$this->Image('../../archivos/materiales.png',150,68,30,30);
    //$this->Ln(20);

}

// Pie de página
function Footer()
{
    // Posición: a 1,5 cm del final
    $this->SetY(-15);
    // Arial italic 8
    $this->SetFont('Arial','I',8);
    // Número de página
    $this->Cell(0,10,utf8_decode('Página ').$this->PageNo().'/{nb}',0,0,'C');
}
}
include_once '../db/conexion.php';

$sql2="select *from resguardos_entregados_articulos  where idresguardo=$folio";
$query2=mysqli_query($con,$sql2);
$sql="call resguardos_entregados($folio);";
$query=mysqli_query($con,$sql);





while ($resul=mysqli_fetch_array($query))
{
 $estado=$resul['estado'];
 $fecha_regreso=$resul['fecha_regreso'];
 $departamento_usuario=$resul['departamento_usuario'];
 $nombre_usuario=$resul['nombre_completo'];
 $fecha=$resul['fecha'];
 $hora=$resul['hora'];
 $correo=$resul['correo'];
 $puesto=$resul['puesto'];
 //colaborador
 $colaborador=$resul['nombre']." ".$resul['apellidos'];
 $departamento=$resul['departamento'];
 $noColaborador=$resul['no_colaborador'];

}

$pdf = new PDF();
$pdf->AliasNbPages();
$pdf->AddPage();
$pdf->SetFont('Arial','',15);
if($estado=="inactivo")
{
  $pdf->Cell(0,5,'Este resguardo ya fue regresado al departamento: '.$fecha_regreso,0,1,'C',0);
}

$pdf->SetFont('Arial','',12);
$pdf->Cell(0,5,'Departamento: '.$departamento_usuario,0,1,'',0);
$pdf->Cell(0,5,'Nombre: '.$nombre_usuario,0,1,'',0);
$pdf->Cell(0,5,'Fecha: '.$fecha." ".$hora,0,1,'',0);
$pdf->Cell(0,5,'Correo: '.$correo,0,1,'',0);
$pdf->Cell(0,5,'Puesto: '.$puesto,0,1,'',0);
$pdf->Ln(5);
$pdf->Cell(0,5,'Colaborador: '.$colaborador,0,1,'',0);
$pdf->Cell(0,5,'Departamento: '.$departamento,0,1,'',0);
$pdf->Cell(0,5,'No. colaborador: '.$noColaborador,0,1,'',0);


$pdf->SetFont('Arial','',7);


$pdf->Ln(10);
$pdf->Cell(190,10,'Datos de los Articulos',0,1,'C');
$pdf->SetFont('Arial','B',7);
$pdf->Cell(5,5,'No.',1,0,'C',0);
$pdf->Cell(20,5,'Imagen',1,0,'C',0);
$pdf->Cell(50,5,'Descripcion',1,0,'',0);
$pdf->Cell(20,5,'Categoria',1,0,'C',0);
$pdf->Cell(20,5,'Marca',1,0,'C',0);
$pdf->Cell(20,5,'Modelo',1,0,'C',0);
$pdf->Cell(15,5,'Serie',1,0,'C',0);
$pdf->Cell(20,5,'No. inventario',1,0,'C',0);
$pdf->Cell(20,5,'Localizacion',1,1,'C',0);
$pdf->SetFont('Arial','',7);
$i=0;

while ($resul2=mysqli_fetch_array($query2))
{
  $i++;
  $pdf->Cell(5,18,''.$i,1,0,'C',0);
  $pdf->Cell(20,18,$pdf->Image('../archivos/articulos/'.$resul2['imagen'], $pdf->GetX()+2, $pdf->GetY()+1, 15) ,1,0,"C",0);
  $pdf->Cell(50,18,utf8_decode($resul2['descripcion']),1,0,'',0);
  $pdf->Cell(20,18,utf8_decode($resul2['categoria']),1,0,'C',0);
   $pdf->Cell(20,18,utf8_decode($resul2['marca']),1,0,'C',0);
   $pdf->Cell(20,18,utf8_decode($resul2['modelo']),1,0,'C',0);
   $pdf->Cell(15,18,utf8_decode($resul2['no_serie']),1,0,'C',0);
   $pdf->Cell(20,18,utf8_decode($resul2['no_inventario']),1,0,'C',0);
   $pdf->Cell(20,18,utf8_decode($resul2['localizacion']),1,1,'C',0);
 

 
}

$pdf->Ln(10);
$pdf->SetFont('Arial','B',11);
//$pdf->Cell(0,0,'Responsable del area',0,1,'C');
$pdf->Cell(0,15,'____________________________________',0,1,'C');
$pdf->Ln(-2);
$pdf->Cell(0,0,'Nombre y firma de quien hizo el resguardo',0,1,'C');

$pdf->Cell(0,15,'____________________________________',0,1,'C');
$pdf->Ln(-2);
$pdf->Cell(0,0,'Nombre y firma de quien recibe el resguardo',0,1,'C');




$pdf->Output($nombre_archivo,$modo);
?>