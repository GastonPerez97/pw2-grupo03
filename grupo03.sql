-- MySQL Script generated by MySQL Workbench
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema grupo03
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema grupo03
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `grupo03` ;
USE `grupo03` ;

-- -----------------------------------------------------
-- Table `grupo03`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `grupo03`.`usuario` (
  `id_usuario` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(50) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `dni` VARCHAR(45) NOT NULL,
  `birthdate` DATE NOT NULL,
  `fecha_alta` DATE NOT NULL,
  `activado` BIT NOT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  UNIQUE INDEX `dni_UNIQUE` (`dni` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `grupo03`.`rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `grupo03`.`rol` (
  `id_rol` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(100) NULL,
  PRIMARY KEY (`id_rol`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `grupo03`.`usuario_rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `grupo03`.`usuario_rol` (
  `id_usuario` INT NOT NULL,
  `id_rol` INT NOT NULL,
  PRIMARY KEY (`id_usuario`, `id_rol`),
  INDEX `rol_FK_idx` (`id_rol` ASC),
  CONSTRAINT `usuario_rol_FK`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `grupo03`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `rol_FK`
    FOREIGN KEY (`id_rol`)
    REFERENCES `grupo03`.`rol` (`id_rol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `grupo03`.`tipo_licencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `grupo03`.`tipo_licencia` (
  `id_tipo_licencia` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(100) NULL,
  PRIMARY KEY (`id_tipo_licencia`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `grupo03`.`chofer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `grupo03`.`chofer` (
  `id_chofer` INT NOT NULL AUTO_INCREMENT,
  `numero_licencia` VARCHAR(45) NOT NULL,
  `id_tipo_licencia` INT NOT NULL,
  PRIMARY KEY (`id_chofer`),
  UNIQUE INDEX `license_number_UNIQUE` (`numero_licencia` ASC),
  INDEX `id_tipo_licencia_INDEX` (`id_tipo_licencia` ASC),
  CONSTRAINT `tipo_licencia_FK`
    FOREIGN KEY (`id_tipo_licencia`)
    REFERENCES `grupo03`.`tipo_licencia` (`id_tipo_licencia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = binary;


-- -----------------------------------------------------
-- Table `grupo03`.`marca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `grupo03`.`marca` (
  `id_marca` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_marca`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `grupo03`.`modelo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `grupo03`.`modelo` (
  `id_modelo` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `id_marca` INT NOT NULL,
  PRIMARY KEY (`id_modelo`),
  INDEX `id_marca_INDEX` (`id_marca` ASC),
  CONSTRAINT `marca_FK`
    FOREIGN KEY (`id_marca`)
    REFERENCES `grupo03`.`marca` (`id_marca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `grupo03`.`unidad_de_transporte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `grupo03`.`unidad_de_transporte` (
  `id_unidad_de_transporte` INT NOT NULL AUTO_INCREMENT,
  `patente` VARCHAR(45) NOT NULL,
  `posicion_actual` VARCHAR(150) NOT NULL,
  `anio_fabricacion` TINYINT NOT NULL,
  `numero_chasis` VARCHAR(45) NOT NULL,
  `id_marca` INT NOT NULL,
  `id_modelo` INT NOT NULL,
  PRIMARY KEY (`id_unidad_de_transporte`),
  UNIQUE INDEX `patente_UNIQUE` (`patente` ASC),
  UNIQUE INDEX `numero_chasis_UNIQUE` (`numero_chasis` ASC),
  INDEX `id_marca_INDEX` (`id_marca` ASC),
  INDEX `id_modelo_INDEX` (`id_modelo` ASC),
  CONSTRAINT `marca_transporte_FK`
    FOREIGN KEY (`id_marca`)
    REFERENCES `grupo03`.`marca` (`id_marca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `modelo_transporte_FK`
    FOREIGN KEY (`id_modelo`)
    REFERENCES `grupo03`.`modelo` (`id_modelo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `grupo03`.`service`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `grupo03`.`service` (
  `id_service` INT NOT NULL AUTO_INCREMENT,
  `fecha_service` DATE NOT NULL,
  `detalle` VARCHAR(150) NOT NULL,
  `costo` DECIMAL(10,2) UNSIGNED NOT NULL,
  `kilometraje_actual_unidad` INT UNSIGNED NOT NULL,
  `interno` BIT NOT NULL,
  `id_usuario` INT NOT NULL,
  `id_unidad_de_transporte` INT NOT NULL,
  PRIMARY KEY (`id_service`),
  INDEX `id_usuario_INDEX` (`id_usuario` ASC),
  INDEX `id_unidad_de_transporte_INDEX` (`id_unidad_de_transporte` ASC),
  CONSTRAINT `usuario_service_FK`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `grupo03`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `unidad_de_transporte_FK`
    FOREIGN KEY (`id_unidad_de_transporte`)
    REFERENCES `grupo03`.`unidad_de_transporte` (`id_unidad_de_transporte`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `grupo03`.`tipo_remolque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `grupo03`.`tipo_remolque` (
  `id_tipo_remolque` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `peso_maximo` INT NOT NULL,
  PRIMARY KEY (`id_tipo_remolque`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `grupo03`.`remolque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `grupo03`.`remolque` (
  `id_remolque` INT NOT NULL AUTO_INCREMENT,
  `id_tipo_remolque` INT NOT NULL,
  PRIMARY KEY (`id_remolque`),
  INDEX `id_tipo_remolque_INDEX` (`id_tipo_remolque` ASC),
  CONSTRAINT `unidad_de_transporte_remolque_FK`
    FOREIGN KEY (`id_remolque`)
    REFERENCES `grupo03`.`unidad_de_transporte` (`id_unidad_de_transporte`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `tipo_remolque_FK`
    FOREIGN KEY (`id_tipo_remolque`)
    REFERENCES `grupo03`.`tipo_remolque` (`id_tipo_remolque`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `grupo03`.`tipo_vehiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `grupo03`.`tipo_vehiculo` (
  `id_tipo_vehiculo` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_tipo_vehiculo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `grupo03`.`viaje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `grupo03`.`viaje` (
  `id_viaje` INT NOT NULL AUTO_INCREMENT,
  `consumo_combustible_previsto` DECIMAL(10,2) NOT NULL,
  `consumo_combustible_real` DECIMAL(10,2) ZEROFILL NOT NULL,
  `kilometros_previstos` DECIMAL(10,2) NOT NULL,
  `kilometros_reales` DECIMAL(10,2) ZEROFILL NOT NULL,
  `origen` VARCHAR(150) NOT NULL,
  `destino` VARCHAR(150) NOT NULL,
  `fecha_salida` DATETIME NOT NULL,
  `fecha_llegada_estimada` DATETIME NOT NULL,
  `fecha_llegada` DATETIME NULL,
  PRIMARY KEY (`id_viaje`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `grupo03`.`tipo_carga`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `grupo03`.`tipo_carga` (
  `id_tipo_carga` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_tipo_carga`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `grupo03`.`carga`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `grupo03`.`carga` (
  `id_carga` INT NOT NULL AUTO_INCREMENT,
  `peso` DECIMAL(10,2) ZEROFILL NOT NULL,
  `fragil` BIT NOT NULL,
  `id_tipo_carga` INT NOT NULL,
  `id_viaje` INT NOT NULL,
  PRIMARY KEY (`id_carga`),
  INDEX `id_tipo_carga_INDEX` (`id_tipo_carga` ASC),
  INDEX `id_viaje_INDEX` (`id_viaje` ASC),
  CONSTRAINT `viaje_carga_FK`
    FOREIGN KEY (`id_viaje`)
    REFERENCES `grupo03`.`viaje` (`id_viaje`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `tipo_carga_FK`
    FOREIGN KEY (`id_tipo_carga`)
    REFERENCES `grupo03`.`tipo_carga` (`id_tipo_carga`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `grupo03`.`desvio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `grupo03`.`desvio` (
  `id_desvio` INT NOT NULL AUTO_INCREMENT,
  `razon` VARCHAR(100) NOT NULL,
  `tiempo` TIME NOT NULL,
  PRIMARY KEY (`id_desvio`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `grupo03`.`viaje_desvio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `grupo03`.`viaje_desvio` (
  `id_viaje` INT NOT NULL,
  `id_desvio` INT NOT NULL,
  PRIMARY KEY (`id_viaje`, `id_desvio`),
  INDEX `desvio_FK_idx` (`id_desvio` ASC),
  CONSTRAINT `viaje_desvio_FK`
    FOREIGN KEY (`id_viaje`)
    REFERENCES `grupo03`.`viaje` (`id_viaje`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `desvio_FK`
    FOREIGN KEY (`id_desvio`)
    REFERENCES `grupo03`.`desvio` (`id_desvio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `grupo03`.`viaje_chofer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `grupo03`.`viaje_chofer` (
  `id_viaje` INT NOT NULL,
  `id_chofer` INT NOT NULL,
  PRIMARY KEY (`id_viaje`, `id_chofer`),
  INDEX `chofer_FK_idx` (`id_chofer` ASC),
  CONSTRAINT `viaje_chofer_FK`
    FOREIGN KEY (`id_viaje`)
    REFERENCES `grupo03`.`viaje` (`id_viaje`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `chofer_FK`
    FOREIGN KEY (`id_chofer`)
    REFERENCES `grupo03`.`chofer` (`id_chofer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `grupo03`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `grupo03`.`cliente` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(50) NOT NULL,
  `dni` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_cliente`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  UNIQUE INDEX `dni_UNIQUE` (`dni` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `grupo03`.`factura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `grupo03`.`factura` (
  `id_factura` INT NOT NULL AUTO_INCREMENT,
  `numero_factura` VARCHAR(45) NOT NULL,
  `fecha_facturacion` DATE NOT NULL,
  `fecha_pago` DATE NULL,
  `id_cliente` INT NOT NULL,
  `id_viaje` INT NOT NULL,
  PRIMARY KEY (`id_factura`),
  INDEX `id_cliente_INDEX` (`id_cliente` ASC),
  INDEX `id_viaje_INDEX` (`id_viaje` ASC),
  CONSTRAINT `cliente_FK`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `grupo03`.`cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `viaje_factura_FK`
    FOREIGN KEY (`id_viaje`)
    REFERENCES `grupo03`.`viaje` (`id_viaje`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `grupo03`.`viaje_unidad_de_transporte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `grupo03`.`viaje_unidad_de_transporte` (
  `id_viaje` INT NOT NULL,
  `id_unidad_de_transporte` INT NOT NULL,
  PRIMARY KEY (`id_viaje`, `id_unidad_de_transporte`),
  INDEX `id_unidad_de_transporte_idx` (`id_unidad_de_transporte` ASC),
  CONSTRAINT `viaje_transporte_FK`
    FOREIGN KEY (`id_viaje`)
    REFERENCES `grupo03`.`viaje` (`id_viaje`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `unidad_de_transporte_viaje_FK`
    FOREIGN KEY (`id_unidad_de_transporte`)
    REFERENCES `grupo03`.`unidad_de_transporte` (`id_unidad_de_transporte`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `grupo03`.`vehiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `grupo03`.`vehiculo` (
  `id_vehiculo` INT NOT NULL,
  `numero_motor` VARCHAR(45) NOT NULL,
  `kilometraje` DECIMAL(10,2) NOT NULL,
  `id_tipo_vehiculo` INT NOT NULL,
  PRIMARY KEY (`id_vehiculo`),
  UNIQUE INDEX `numero_motor_UNIQUE` (`numero_motor` ASC),
  INDEX `id_tipo_vehiculo_INDEX` (`id_tipo_vehiculo` ASC),
  INDEX `unidad_de_transporte_FK_idx` (`id_vehiculo` ASC),
  CONSTRAINT `unidad_de_transporte_vehiculo_FK`
    FOREIGN KEY (`id_vehiculo`)
    REFERENCES `grupo03`.`unidad_de_transporte` (`id_unidad_de_transporte`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `tipo_vehiculo_FK`
    FOREIGN KEY (`id_tipo_vehiculo`)
    REFERENCES `grupo03`.`tipo_vehiculo` (`id_tipo_vehiculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `grupo03`.`costo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `grupo03`.`costo` (
  `id_costo` INT NOT NULL AUTO_INCREMENT,
  `detalle` VARCHAR(45) NOT NULL,
  `importe` DECIMAL(10,2) NOT NULL,
  `id_factura` INT NOT NULL,
  PRIMARY KEY (`id_costo`),
  INDEX `id_factura_INDEX` (`id_factura` ASC),
  CONSTRAINT `factura_FK`
    FOREIGN KEY (`id_factura`)
    REFERENCES `grupo03`.`factura` (`id_factura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- INSERTS
-- -----------------------------------------------------
INSERT INTO usuario (id_usuario, email, dni, password, nombre, apellido, birthdate, fecha_alta, activado) VALUES (1338, 'mail@test.com', 124567, '81dc9bdb52d04dc20036dbd8313ed055', 'Jorge', 'Perez', '1960-12-11', '2020-11-17', b'0');
INSERT INTO `grupo03`.`tipo_vehiculo` (`id_tipo_vehiculo`, `nombre`) VALUES ('1', 'camion');
INSERT INTO `grupo03`.`marca` (`id_marca`, `nombre`) VALUES ('1', 'fiat');
INSERT INTO `grupo03`.`modelo` (`id_modelo`, `nombre`, `id_marca`) VALUES ('1', 'cargo', '1');
INSERT INTO `grupo03`.`unidad_de_transporte` (`id_unidad_de_transporte`, `patente`, `posicion_actual`, `anio_fabricacion`, `numero_chasis`, `id_marca`, `id_modelo`) VALUES ('1', 'abc123', 'acb', '94', '234423342', '1', '1');
INSERT INTO `grupo03`.`vehiculo` (`id_vehiculo`, `numero_motor`, `kilometraje`, `id_tipo_vehiculo`) VALUES ('1', '23423', '60000', '1');
INSERT INTO `grupo03`.`service` (`id_service`, `fecha_service`, `detalle`, `costo`, `kilometraje_actual_unidad`, `interno`, `id_usuario`, `id_unidad_de_transporte`) VALUES ('1', '1111-11-11', 'cambio de aceite', '15000', '65000', b'0', '1338', b'1');

-- (contraseña usuario id 1337: 1234) 
INSERT INTO rol (id_rol, nombre, descripcion) VALUES (1, 'Administrador', 'AdminDesc'), (2, 'Supervisor', 'SupervisorDesc'), (3, 'Encargado de Taller', 'EncargadoTallerDesc'), (4, 'Chofer', 'ChoferDesc');
INSERT INTO usuario (id_usuario, email, dni, password, nombre, apellido, birthdate, fecha_alta, activado) VALUES (1337, 'mail@mail.com', 1234567, '81dc9bdb52d04dc20036dbd8313ed055', 'Juan', 'Perez', '1960-11-11', '2020-11-17', b'0');
INSERT INTO usuario_rol (id_usuario, id_rol) VALUES (1337, 1);



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
