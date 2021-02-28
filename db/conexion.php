<?php
    class Conectar
    {
        public static function conexion(){
            $conexion=new mysqli("localhost", "root", "", "crud");
            $conexion->query("SET NAMES 'utf8'");
            return $conexion;
        }
    }

   $usuario='root';
   $pws='';
   $servidor='localhost';
   $bd='crud';
   $con= mysqli_connect($servidor,$usuario,$pws,$bd);

    
?>
