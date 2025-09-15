-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 15-09-2025 a las 06:07:35
-- Versión del servidor: 10.4.11-MariaDB
-- Versión de PHP: 7.2.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `hotel_bd`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`uparcial`@`%` PROCEDURE `ActualizarTelefonoCliente` (IN `p_ID_CLIENTE` INT, IN `p_telefono` VARCHAR(20))  BEGIN
    UPDATE Cliente SET telefono = p_telefono WHERE ID_CLIENTE = p_ID_CLIENTE;
END$$

CREATE DEFINER=`uparcial`@`%` PROCEDURE `ActualizarTelefonoEjemplo` ()  BEGIN
  -- Actualiza teléfono cliente 2 a nuevo número
  UPDATE Cliente SET telefono = '555-1234567' WHERE ID_CLIENTE = 2;
END$$

CREATE DEFINER=`uparcial`@`%` PROCEDURE `InsertarReserva` (IN `p_ID_CLIENTE` INT, IN `p_ID_HABITACION` INT, IN `p_fecha_inicio` DATE, IN `p_fecha_fin` DATE)  BEGIN
    INSERT INTO Reserva (ID_CLIENTE, ID_HABITACION, fecha_inicio, fecha_fin, estado)
    VALUES (p_ID_CLIENTE, p_ID_HABITACION, p_fecha_inicio, p_fecha_fin, 'activa');
END$$

CREATE DEFINER=`uparcial`@`%` PROCEDURE `InsertarReservaEjemplo` ()  BEGIN
  -- Inserta reserva para cliente 1, habitación 3, fecha 2025-09-15 a 2025-09-18
  INSERT INTO Reserva (ID_RESERVA, ID_CLIENTE, ID_HABITACION, fecha_inicio, fecha_fin, estado)
  VALUES (1, 1, 3, '2025-09-15', '2025-09-18', 'activa');
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `ID_CLIENTE` int(11) NOT NULL,
  `Nombre` varchar(50) DEFAULT NULL,
  `primer_apellido` varchar(50) DEFAULT NULL,
  `segundo_apellido` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`ID_CLIENTE`, `Nombre`, `primer_apellido`, `segundo_apellido`, `email`, `telefono`) VALUES
(1, 'Juan', 'Pérez', 'Gómez', 'juanperez@gmail.com', '3001234567'),
(2, 'María', 'López', 'Rodríguez', 'marialopez@gmail.com', '3007654321'),
(3, 'Carlos', 'Ramírez', 'Torres', 'carlosramirez@gmail.com', '3011234567'),
(4, 'Ana', 'García', 'Martínez', 'anagarcia@gmail.com', '3029876543');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado`
--

CREATE TABLE `empleado` (
  `ID_EMPLEADO` int(11) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `apellido` varchar(50) DEFAULT NULL,
  `cargo` varchar(50) DEFAULT NULL,
  `salario` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `empleado`
--

INSERT INTO `empleado` (`ID_EMPLEADO`, `nombre`, `apellido`, `cargo`, `salario`) VALUES
(1, 'Laura', 'Martinez', 'Recepcionista', '2000.00'),
(2, 'Pedro', 'Suárez', 'Gerente', '3500.00'),
(3, 'Lucía', 'Fernández', 'Camarera', '1800.00'),
(4, 'Diego', 'Morales', 'Conserje', '1700.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factura`
--

CREATE TABLE `factura` (
  `ID_FACTURA` int(11) NOT NULL,
  `ID_RESERVA` int(11) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `factura`
--

INSERT INTO `factura` (`ID_FACTURA`, `ID_RESERVA`, `fecha`, `total`) VALUES
(1, 1, '2025-06-05', '600.00'),
(2, 2, '2025-06-12', '250.00'),
(3, 3, '2025-07-01', '0.00'),
(4, 4, '2025-08-20', '750.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `habitacion`
--

CREATE TABLE `habitacion` (
  `ID_HABITACION` int(11) NOT NULL,
  `tipo` varchar(50) DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `estado` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `habitacion`
--

INSERT INTO `habitacion` (`ID_HABITACION`, `tipo`, `precio`, `estado`) VALUES
(101, 'Doble', '150.00', 'Disponible'),
(102, 'Individual', '100.00', 'Ocupada'),
(103, 'Suite', '250.00', 'Disponible'),
(104, 'Doble', '150.00', 'Mantenimiento');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reserva`
--

CREATE TABLE `reserva` (
  `ID_RESERVA` int(11) NOT NULL,
  `ID_CLIENTE` int(11) DEFAULT NULL,
  `ID_HABITACION` int(11) DEFAULT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `estado` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `reserva`
--

INSERT INTO `reserva` (`ID_RESERVA`, `ID_CLIENTE`, `ID_HABITACION`, `fecha_inicio`, `fecha_fin`, `estado`) VALUES
(1, 1, 101, '2025-06-01', '2025-06-05', 'Activa'),
(2, 2, 102, '2025-06-10', '2025-06-12', 'Activa'),
(3, 3, 103, '2025-07-01', '2025-07-07', 'Cancelada'),
(4, 4, 104, '2025-08-15', '2025-08-20', 'Pendiente');

--
-- Disparadores `reserva`
--
DELIMITER $$
CREATE TRIGGER `trg_ReservaCanceladaEjemplo` AFTER UPDATE ON `reserva` FOR EACH ROW BEGIN
  -- Cambia estado de habitación a 'Disponible' si reserva cambia a 'cancelada'
  IF NEW.estado = 'cancelada' THEN
    UPDATE Habitacion SET estado = 'Disponible' WHERE ID_HABITACION = NEW.ID_HABITACION;
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_ReservaNueva` AFTER INSERT ON `reserva` FOR EACH ROW BEGIN
    UPDATE Habitacion
    SET estado = 'Ocupada'
    WHERE ID_HABITACION = NEW.ID_HABITACION;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_ReservaNuevaEjemplo` AFTER INSERT ON `reserva` FOR EACH ROW BEGIN
  -- Cambia estado de habitación a 'Ocupada' cuando se inserta reserva
  UPDATE Habitacion SET estado = 'Ocupada' WHERE ID_HABITACION = NEW.ID_HABITACION;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reserva_servicios`
--

CREATE TABLE `reserva_servicios` (
  `ID_RESERVA` int(11) NOT NULL,
  `ID_SERVICIO` int(11) NOT NULL,
  `cantidad` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `reserva_servicios`
--

INSERT INTO `reserva_servicios` (`ID_RESERVA`, `ID_SERVICIO`, `cantidad`) VALUES
(1, 1, 4),
(2, 2, 2),
(2, 4, 1),
(3, 3, 1),
(4, 1, 5),
(4, 2, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicio`
--

CREATE TABLE `servicio` (
  `ID_SERVICIO` int(11) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `servicio`
--

INSERT INTO `servicio` (`ID_SERVICIO`, `nombre`, `descripcion`, `precio`) VALUES
(1, 'Desayuno', 'Buffet de desayuno', '15.00'),
(2, 'Almuerzo', 'Buffet de almuerzo', '25.00'),
(3, 'Spa', 'Sesión de spa y masaje relajante', '50.00'),
(4, 'Transporte', 'Traslado aeropuerto-hotel', '30.00');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`ID_CLIENTE`);

--
-- Indices de la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD PRIMARY KEY (`ID_EMPLEADO`);

--
-- Indices de la tabla `factura`
--
ALTER TABLE `factura`
  ADD PRIMARY KEY (`ID_FACTURA`),
  ADD KEY `ID_RESERVA` (`ID_RESERVA`);

--
-- Indices de la tabla `habitacion`
--
ALTER TABLE `habitacion`
  ADD PRIMARY KEY (`ID_HABITACION`),
  ADD KEY `idx_estado_habitacion` (`estado`);

--
-- Indices de la tabla `reserva`
--
ALTER TABLE `reserva`
  ADD PRIMARY KEY (`ID_RESERVA`),
  ADD KEY `ID_CLIENTE` (`ID_CLIENTE`),
  ADD KEY `ID_HABITACION` (`ID_HABITACION`);

--
-- Indices de la tabla `reserva_servicios`
--
ALTER TABLE `reserva_servicios`
  ADD PRIMARY KEY (`ID_RESERVA`,`ID_SERVICIO`),
  ADD KEY `ID_SERVICIO` (`ID_SERVICIO`);

--
-- Indices de la tabla `servicio`
--
ALTER TABLE `servicio`
  ADD PRIMARY KEY (`ID_SERVICIO`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `factura`
--
ALTER TABLE `factura`
  ADD CONSTRAINT `factura_ibfk_1` FOREIGN KEY (`ID_RESERVA`) REFERENCES `reserva` (`ID_RESERVA`);

--
-- Filtros para la tabla `reserva`
--
ALTER TABLE `reserva`
  ADD CONSTRAINT `reserva_ibfk_1` FOREIGN KEY (`ID_CLIENTE`) REFERENCES `cliente` (`ID_CLIENTE`),
  ADD CONSTRAINT `reserva_ibfk_2` FOREIGN KEY (`ID_HABITACION`) REFERENCES `habitacion` (`ID_HABITACION`);

--
-- Filtros para la tabla `reserva_servicios`
--
ALTER TABLE `reserva_servicios`
  ADD CONSTRAINT `reserva_servicios_ibfk_1` FOREIGN KEY (`ID_RESERVA`) REFERENCES `reserva` (`ID_RESERVA`),
  ADD CONSTRAINT `reserva_servicios_ibfk_2` FOREIGN KEY (`ID_SERVICIO`) REFERENCES `servicio` (`ID_SERVICIO`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
