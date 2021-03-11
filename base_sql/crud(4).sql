-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 12-03-2021 a las 00:27:25
-- Versión del servidor: 10.4.8-MariaDB
-- Versión de PHP: 7.3.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `crud`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_articulos` (IN `id` INT(100))  begin
declare resul int (10) ;
set resul=(select idarticulos from detalles_resguardo where idarticulos=id);
if(resul>0) then
update articulos set estado='eliminado' where id_articulo=id;
else
delete from articulos where id_articulo=id;
end if;


end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `lista_bajas_articulos` (IN `id` INT(100))  begin
select d.idbajas,d.idarticulos,
a.categoria,a.marca,a.modelo,a.no_serie,a.no_inventario,a.descripcion,a.localizacion,a.imagen
from detalles_bajas_articulos
as d inner join articulos as a on d.idarticulos=a.id_articulo

where idbajas =id;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `resguardos_entregados` (IN `id` INT(100))  begin
select  r.id_resguardo,r.fecha,r.hora,r.observaciones,r.estado,r.fecha_regreso,
u.nombre_usuario,u.correo,u.puesto,u.nombre_completo,u.personal_externo,u.departamento_usuario,
p.no_colaborador,p.nombre,p.apellidos,p.departamento from resguardos
as r inner join usuario as u on r.idusuario=u.idusuario
inner join persona as p on r.idpersona=p.idpersona
where id_resguardo =id;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `resguardos_entregados_articulos` (IN `id` INT(100))  begin
select d.idresguardo,d.cantidad,a.imagen,a.categoria,a.marca,a.modelo,a.no_serie,a.no_inventario,a.localizacion,
 a.descripcion from detalles_resguardo
as d inner join articulos as a on d.idarticulos=a.id_articulo
where idresguardo =id;

end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `articulos`
--

CREATE TABLE `articulos` (
  `id_articulo` int(15) NOT NULL,
  `categoria` varchar(50) NOT NULL,
  `marca` varchar(50) NOT NULL,
  `modelo` varchar(50) NOT NULL,
  `no_serie` varchar(50) DEFAULT NULL,
  `no_inventario` varchar(50) NOT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `localizacion` text NOT NULL,
  `imagen` text DEFAULT NULL,
  `idusuario` int(11) NOT NULL,
  `estado` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `articulos`
--

INSERT INTO `articulos` (`id_articulo`, `categoria`, `marca`, `modelo`, `no_serie`, `no_inventario`, `cantidad`, `descripcion`, `localizacion`, `imagen`, `idusuario`, `estado`) VALUES
(2, 'Impresora', 'Dell', '3323', '44490', '0904', 1, 'Impresora termica', 'inventario', '1.jpg', 2, 'inactivo'),
(3, 'Monitor', 'Samsung', 'gt658', '127890', '1000', 1, 'Monitores de 68 pulgadas', 'inventario', '2.jpg', 1, 'inactivo'),
(4, 'Tableta', 'Iphone', '5773u', 'fffdfdfdf2', '098', 1, 'Table apple', 'inventario', '3.jpg', 1, 'activo'),
(5, 'Impresora', 'Dell', '2212jk', '8899823', '224131', 1, 'Impresoras stock', 'inventario', '4.jpg', 2, 'activo'),
(439, 'Impresora', 'HP', 'NPOR', '24332', '8907', 1, 'Impresora china', 'inventario', '5.jpg', 1, 'activo'),
(481, 'fdf', 'dfdf', 'dfdfd', 'fdf', 'dfdf', 1, 'fdfdf', 'fdf', '7.jpg', 1, 'activo'),
(482, 'Mouse', 'HP', 'tecu180', '980822', '9893', 1, 'Mouse', 'Inventario', 'mause.jpg', 1, 'activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bajas_articulos`
--

CREATE TABLE `bajas_articulos` (
  `id_bajas` int(15) NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `idusuario` int(15) DEFAULT NULL,
  `descripcion` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalles_bajas_articulos`
--

CREATE TABLE `detalles_bajas_articulos` (
  `id_detalles` int(15) NOT NULL,
  `idbajas` int(15) DEFAULT NULL,
  `idarticulos` int(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Disparadores `detalles_bajas_articulos`
--
DELIMITER $$
CREATE TRIGGER `after_detalles_bajas_articulos_insert` AFTER INSERT ON `detalles_bajas_articulos` FOR EACH ROW BEGIN
    -- IF NEW.birthDate IS NULL THEN
         update articulos set estado='eliminado' where id_articulo=new.idarticulos;
        -- INSERT INTO reminders(memberId, message)
        -- VALUES(new.id,CONCAT('Hi ', NEW.name, ', please update your date of birth.'));
    -- END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalles_resguardo`
--

CREATE TABLE `detalles_resguardo` (
  `id_detalles` int(15) NOT NULL,
  `idresguardo` int(15) DEFAULT NULL,
  `idarticulos` int(15) DEFAULT NULL,
  `cantidad` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `detalles_resguardo`
--

INSERT INTO `detalles_resguardo` (`id_detalles`, `idresguardo`, `idarticulos`, `cantidad`) VALUES
(130, 52, 2, 1),
(131, 53, 2, 1),
(132, 53, 4, 1),
(133, 54, 3, 1),
(134, 55, 2, 1);

--
-- Disparadores `detalles_resguardo`
--
DELIMITER $$
CREATE TRIGGER `after_detalles_resguardo_insert` AFTER INSERT ON `detalles_resguardo` FOR EACH ROW BEGIN
    -- IF NEW.birthDate IS NULL THEN
         update articulos set estado='inactivo' where id_articulo=new.idarticulos;
        -- INSERT INTO reminders(memberId, message)
        -- VALUES(new.id,CONCAT('Hi ', NEW.name, ', please update your date of birth.'));
    -- END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `lista_bajas`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `lista_bajas` (
`id_bajas` int(15)
,`fecha` date
,`hora` time
,`descripcion` text
,`idusuario` int(15)
,`nombre_usuario` char(15)
,`correo` varchar(80)
,`puesto` varchar(100)
,`nombre_completo` char(100)
,`no_colaborador` int(11)
,`personal_externo` varchar(50)
,`departamento_usuario` varchar(60)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

CREATE TABLE `persona` (
  `idpersona` int(15) NOT NULL,
  `no_colaborador` int(11) DEFAULT NULL,
  `nombre` char(25) NOT NULL,
  `apellidos` char(50) NOT NULL,
  `correo` varchar(60) DEFAULT NULL,
  `puesto` varchar(60) DEFAULT NULL,
  `departamento` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`idpersona`, `no_colaborador`, `nombre`, `apellidos`, `correo`, `puesto`, `departamento`) VALUES
(1, 15321250, 'marco', 'lorenzo lucena', 'pichulol96', 'gerente', 'TI'),
(13, 1532125078, 'pichu', 'lolol', 'jjhh', 'ffddf', 'yyf'),
(14, 1996100, 'jorge', 'flores nava', 'prooskate@hotmail.com', 'Jefe de area', 'TI'),
(15, 1234567890, 'Adraiana', 'Rodriguez Martinez', 'sexy.bonita@gmail.com', 'Jefa de alimentos', 'Cocina');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id_productos` int(15) NOT NULL,
  `nombre_producto` varchar(60) NOT NULL,
  `descripcion` varchar(140) NOT NULL,
  `precio` float(10,2) NOT NULL,
  `stok` float(10,2) NOT NULL,
  `img` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id_productos`, `nombre_producto`, `descripcion`, `precio`, `stok`, `img`) VALUES
(2, 'platano', 'platano macho', 16.70, 160.00, 'https://elpoderdelconsumidor.org/wp-content/uploads/2017/11/platanos.jpg'),
(25, 'Papaya', 'Papaya mexican', 18.00, 9.00, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0CVkBOrBfx9mfguyfYT3gBIibgylI3mGj-Q&usqp=CAU'),
(26, 'Fresa', 'Fresa rosita', 8.00, 7.00, 'https://e00-expansion.uecdn.es/assets/multimedia/imagenes/2019/06/27/15616371314021.jpg'),
(27, 'hl', 'hhh', 10.00, 100.00, '1212'),
(28, '', 'hhh', 10.00, 100.00, '1212'),
(29, '', 'hhh', 10.00, 100.00, '1212');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `resguardos`
--

CREATE TABLE `resguardos` (
  `id_resguardo` int(15) NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `observaciones` varchar(80) DEFAULT NULL,
  `idusuario` int(15) NOT NULL,
  `idpersona` int(15) NOT NULL,
  `estado` varchar(30) NOT NULL,
  `fecha_regreso` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `resguardos`
--

INSERT INTO `resguardos` (`id_resguardo`, `fecha`, `hora`, `observaciones`, `idusuario`, `idpersona`, `estado`, `fecha_regreso`) VALUES
(52, '2021-03-04', '20:05:10', 'nmmnmnmnmn', 1, 15, 'inactivo', '2021-03-04'),
(53, '2021-03-07', '12:44:16', 'Saliendo para el area de administracion', 1, 1, 'inactivo', '2021-03-10'),
(54, '2021-03-10', '21:12:50', 'nada', 1, 1, 'activo', NULL),
(55, '2021-03-10', '21:39:32', 'para jonatan de area de ti', 1, 1, 'activo', NULL);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `resguardos_entregados`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `resguardos_entregados` (
`id_resguardo` int(15)
,`fecha` date
,`hora` time
,`observaciones` varchar(80)
,`estado` varchar(30)
,`nombre_usuario` char(15)
,`correo` varchar(80)
,`puesto` varchar(100)
,`nombre_completo` char(100)
,`personal_externo` varchar(50)
,`departamento_usuario` varchar(60)
,`no_colaborador` int(11)
,`nombre` char(25)
,`apellidos` char(50)
,`departamento` varchar(60)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `resguardos_entregados_articulos`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `resguardos_entregados_articulos` (
`idresguardo` int(15)
,`cantidad` int(10)
,`imagen` text
,`categoria` varchar(50)
,`marca` varchar(50)
,`modelo` varchar(50)
,`no_serie` varchar(50)
,`no_inventario` varchar(50)
,`localizacion` text
,`descripcion` text
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id_rol` int(15) NOT NULL,
  `rol` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id_rol`, `rol`) VALUES
(1, 'administrador'),
(2, 'sub administrador');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `idusuario` int(15) NOT NULL,
  `nombre_usuario` char(15) NOT NULL,
  `contrasena` varchar(20) NOT NULL,
  `correo` varchar(80) NOT NULL,
  `puesto` varchar(100) DEFAULT NULL,
  `nombre_completo` char(100) NOT NULL,
  `no_colaborador` int(11) DEFAULT NULL,
  `personal_externo` varchar(50) DEFAULT NULL,
  `departamento_usuario` varchar(60) DEFAULT NULL,
  `idrol` int(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`idusuario`, `nombre_usuario`, `contrasena`, `correo`, `puesto`, `nombre_completo`, `no_colaborador`, `personal_externo`, `departamento_usuario`, `idrol`) VALUES
(1, 'sasuke', '123', 'pichulol96@gmail.com', 'Jefe TI', 'Marco antonio lorenzo lucena', 1996, 'loco', 'TI', 1),
(2, 'skate', '123', 'prooskate@hotmail.com', 'Gerente TI', 'Adriana Rodriguez Martinez', 1997, 'direccion', 'TI', 1);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `usuarios_roles`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `usuarios_roles` (
`idusuario` int(15)
,`nombre_usuario` char(15)
,`correo` varchar(80)
,`puesto` varchar(100)
,`nombre_completo` char(100)
,`no_colaborador` int(11)
,`personal_externo` varchar(50)
,`departamento_usuario` varchar(60)
,`rol` varchar(50)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `lista_bajas`
--
DROP TABLE IF EXISTS `lista_bajas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `lista_bajas`  AS  select `b`.`id_bajas` AS `id_bajas`,`b`.`fecha` AS `fecha`,`b`.`hora` AS `hora`,`b`.`descripcion` AS `descripcion`,`u`.`idusuario` AS `idusuario`,`u`.`nombre_usuario` AS `nombre_usuario`,`u`.`correo` AS `correo`,`u`.`puesto` AS `puesto`,`u`.`nombre_completo` AS `nombre_completo`,`u`.`no_colaborador` AS `no_colaborador`,`u`.`personal_externo` AS `personal_externo`,`u`.`departamento_usuario` AS `departamento_usuario` from (`bajas_articulos` `b` join `usuario` `u` on(`b`.`idusuario` = `u`.`idusuario`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `resguardos_entregados`
--
DROP TABLE IF EXISTS `resguardos_entregados`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `resguardos_entregados`  AS  select `r`.`id_resguardo` AS `id_resguardo`,`r`.`fecha` AS `fecha`,`r`.`hora` AS `hora`,`r`.`observaciones` AS `observaciones`,`r`.`estado` AS `estado`,`u`.`nombre_usuario` AS `nombre_usuario`,`u`.`correo` AS `correo`,`u`.`puesto` AS `puesto`,`u`.`nombre_completo` AS `nombre_completo`,`u`.`personal_externo` AS `personal_externo`,`u`.`departamento_usuario` AS `departamento_usuario`,`p`.`no_colaborador` AS `no_colaborador`,`p`.`nombre` AS `nombre`,`p`.`apellidos` AS `apellidos`,`p`.`departamento` AS `departamento` from ((`resguardos` `r` join `usuario` `u` on(`r`.`idusuario` = `u`.`idusuario`)) join `persona` `p` on(`r`.`idpersona` = `p`.`idpersona`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `resguardos_entregados_articulos`
--
DROP TABLE IF EXISTS `resguardos_entregados_articulos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `resguardos_entregados_articulos`  AS  select `d`.`idresguardo` AS `idresguardo`,`d`.`cantidad` AS `cantidad`,`a`.`imagen` AS `imagen`,`a`.`categoria` AS `categoria`,`a`.`marca` AS `marca`,`a`.`modelo` AS `modelo`,`a`.`no_serie` AS `no_serie`,`a`.`no_inventario` AS `no_inventario`,`a`.`localizacion` AS `localizacion`,`a`.`descripcion` AS `descripcion` from (`detalles_resguardo` `d` join `articulos` `a` on(`d`.`idarticulos` = `a`.`id_articulo`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `usuarios_roles`
--
DROP TABLE IF EXISTS `usuarios_roles`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `usuarios_roles`  AS  select `u`.`idusuario` AS `idusuario`,`u`.`nombre_usuario` AS `nombre_usuario`,`u`.`correo` AS `correo`,`u`.`puesto` AS `puesto`,`u`.`nombre_completo` AS `nombre_completo`,`u`.`no_colaborador` AS `no_colaborador`,`u`.`personal_externo` AS `personal_externo`,`u`.`departamento_usuario` AS `departamento_usuario`,`r`.`rol` AS `rol` from (`usuario` `u` join `roles` `r` on(`u`.`idrol` = `r`.`id_rol`)) ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `articulos`
--
ALTER TABLE `articulos`
  ADD PRIMARY KEY (`id_articulo`);

--
-- Indices de la tabla `bajas_articulos`
--
ALTER TABLE `bajas_articulos`
  ADD PRIMARY KEY (`id_bajas`),
  ADD KEY `detalles_bajas` (`idusuario`);

--
-- Indices de la tabla `detalles_bajas_articulos`
--
ALTER TABLE `detalles_bajas_articulos`
  ADD PRIMARY KEY (`id_detalles`),
  ADD KEY `detalles_baja_id` (`idbajas`),
  ADD KEY `articulo_id` (`idarticulos`);

--
-- Indices de la tabla `detalles_resguardo`
--
ALTER TABLE `detalles_resguardo`
  ADD PRIMARY KEY (`id_detalles`),
  ADD KEY `detalles_resguardo` (`idresguardo`),
  ADD KEY `detalles_articulo` (`idarticulos`);

--
-- Indices de la tabla `persona`
--
ALTER TABLE `persona`
  ADD PRIMARY KEY (`idpersona`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id_productos`);

--
-- Indices de la tabla `resguardos`
--
ALTER TABLE `resguardos`
  ADD PRIMARY KEY (`id_resguardo`),
  ADD KEY `resguardo_persona` (`idpersona`),
  ADD KEY `resguardo_usuario` (`idusuario`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id_rol`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`idusuario`),
  ADD KEY `usuario_rol` (`idrol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `articulos`
--
ALTER TABLE `articulos`
  MODIFY `id_articulo` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=483;

--
-- AUTO_INCREMENT de la tabla `bajas_articulos`
--
ALTER TABLE `bajas_articulos`
  MODIFY `id_bajas` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `detalles_bajas_articulos`
--
ALTER TABLE `detalles_bajas_articulos`
  MODIFY `id_detalles` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT de la tabla `detalles_resguardo`
--
ALTER TABLE `detalles_resguardo`
  MODIFY `id_detalles` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=135;

--
-- AUTO_INCREMENT de la tabla `persona`
--
ALTER TABLE `persona`
  MODIFY `idpersona` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id_productos` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT de la tabla `resguardos`
--
ALTER TABLE `resguardos`
  MODIFY `id_resguardo` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id_rol` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `idusuario` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `bajas_articulos`
--
ALTER TABLE `bajas_articulos`
  ADD CONSTRAINT `detalles_bajas` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`idusuario`);

--
-- Filtros para la tabla `detalles_bajas_articulos`
--
ALTER TABLE `detalles_bajas_articulos`
  ADD CONSTRAINT `articulo_id` FOREIGN KEY (`idarticulos`) REFERENCES `articulos` (`id_articulo`),
  ADD CONSTRAINT `detalles_baja_id` FOREIGN KEY (`idbajas`) REFERENCES `bajas_articulos` (`id_bajas`);

--
-- Filtros para la tabla `detalles_resguardo`
--
ALTER TABLE `detalles_resguardo`
  ADD CONSTRAINT `detalles_articulo` FOREIGN KEY (`idarticulos`) REFERENCES `articulos` (`id_articulo`),
  ADD CONSTRAINT `detalles_resguardo` FOREIGN KEY (`idresguardo`) REFERENCES `resguardos` (`id_resguardo`);

--
-- Filtros para la tabla `resguardos`
--
ALTER TABLE `resguardos`
  ADD CONSTRAINT `resguardo_persona` FOREIGN KEY (`idpersona`) REFERENCES `persona` (`idpersona`),
  ADD CONSTRAINT `resguardo_usuario` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`idusuario`);

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_rol` FOREIGN KEY (`idrol`) REFERENCES `roles` (`id_rol`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
