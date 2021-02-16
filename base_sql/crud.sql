-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 16-02-2021 a las 01:23:46
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
  `idusuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `articulos`
--

INSERT INTO `articulos` (`id_articulo`, `categoria`, `marca`, `modelo`, `no_serie`, `no_inventario`, `cantidad`, `descripcion`, `localizacion`, `imagen`, `idusuario`) VALUES
(2, 'Impresora', 'IC line', 'ACa02983', 'SLRKI2984', 'ACA00189836', 5, 'Impresoras stock', 'inventario', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSCAbpl0xPQjxXJbC7Jj0xxEZj2tCBpzvyqJcPK2KiY4ZzpngT1b2YlY8m19B8vOFNzowlaPy0&usqp=CAc', 2),
(3, 'Monitor', 'HP', 'HP deks', 'LDKIE2983', 'ACA00019001', 8, 'Monitores hp para no se', 'inventario', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRwt0wUHgDQWPrucG-7OzTO6UaXYdCJNAm4mbrW3OhUySt6EIseGUKnEHWkysr9Ca0i6IrOaGtL&usqp=CAc', 1),
(4, 'Ipads', 'Apple', 'apple123', 'apple air 12', 'ACA0001000123', 3, 'ipads para recepción', 'inventario', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-Wh7r_hki8yUD0IJHxA17Pm10I4a8RjauokGrp7k1Zg0dOU_WzYAaR3uojtpmT0dnS0iiINE&usqp=CAc', 1),
(5, 'CPU', 'HP', 'Hp jauue', 'HP00945', 'ACA0010002497', 10, 'Cpus para reemplazo', 'invenatrio', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBXmd9XSrRbkH3QGxgJvhp_JZaJB2DtWRFxCcbfSzjIU0GLp5soWOq8UAdsApVCYcRgOMm3XQ&usqp=CAc', 2),
(430, 'eewe', 'ewewew', 'ewewe', 'wewewe', 'ewew', 4, 'ewwe', 'ewe', 'wewe', 1),
(431, 'dsdsd', 'dsdsd', 'dsd', 'sdsdsd', 'dsds', 5, 'dsd', 'dsds', 'dsdsd', 1),
(432, 'dssd', 'dsd', 'dsds', 'dsdsd', 'dsd66', 55, 'fdfdf', 'fdfdf', 'dfdf', 1),
(438, 'Laptos', 'Hp', 'Xxxsgs', '8758001', '79', 10, 'Laptop HP desde China ', 'Ti', '1268', 1);

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
(2, 15321289, 'pichu', '', 'jjhjhhjjh', 'uj', 'lol'),
(3, 15321289, 'pichu', 'lololj', 'jjhjhhjjh', 'uj', 'lol'),
(4, 15321100, 'lol', 'kij', 'hhhhh', 'fgfg', 'min'),
(5, 15321100, 'lol', 'kij', 'hhhhh', 'fgfg', 'min'),
(6, 15321278, 'dsdsd', 'sdsd', 'dddsd', 'dsd', 'ddsd'),
(7, 16329809, 'sdsdsdsd', 'dsdsdsd', 'dsdsd', 'dsdsdsdd', 'dsdsd'),
(8, 1543213, 'dddfdffd', 'ggfgfgf', 'fhff', 'hhgh', 'ggghghgh'),
(9, 15321259, 'sdsdsd', 'dsdsd', 'dsdsd', 'dsdsdsd', 'sdsd');

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

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `articulos`
--
ALTER TABLE `articulos`
  ADD PRIMARY KEY (`id_articulo`);

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
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `articulos`
--
ALTER TABLE `articulos`
  MODIFY `id_articulo` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=439;

--
-- AUTO_INCREMENT de la tabla `persona`
--
ALTER TABLE `persona`
  MODIFY `idpersona` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id_productos` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
