-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema pesagemSilo
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pesagemSilo
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pesagemSilo` DEFAULT CHARACTER SET utf8 ;
USE `pesagemSilo` ;

-- -----------------------------------------------------
-- Table `pesagemSilo`.`Granja`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pesagemSilo`.`Granja` (
  `idGranja` INT NOT NULL AUTO_INCREMENT,
  `nomeGranja` VARCHAR(100) NOT NULL,
  `Latitude` VARCHAR(100) NOT NULL,
  `Longitude` VARCHAR(100) NOT NULL,
  `nomeProprietario` VARCHAR(100) NOT NULL,
  `Silos` INT NOT NULL,
  PRIMARY KEY (`idGranja`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pesagemSilo`.`Silo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pesagemSilo`.`Silo` (
  `idSilo` INT NOT NULL AUTO_INCREMENT,
  `Capacidade` FLOAT UNSIGNED NOT NULL,
  `idGranja` INT NOT NULL,
  PRIMARY KEY (`idSilo`),
  UNIQUE INDEX `idSilo_UNIQUE` (`idSilo` ASC) VISIBLE,
  INDEX `fk_Silo_Granja_idx` (`idGranja` ASC) VISIBLE,
  CONSTRAINT `fk_Silo_Granja`
    FOREIGN KEY (`idGranja`)
    REFERENCES `pesagemSilo`.`Granja` (`idGranja`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pesagemSilo`.`Medicao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pesagemSilo`.`Medicao` (
  `Pesagem` FLOAT NOT NULL,
  `Data` DATETIME NOT NULL,
  `Silo_idSilo` INT NOT NULL,
  PRIMARY KEY (`Data`),
  INDEX `fk_Medicao_Silo1_idx` (`Silo_idSilo` ASC) VISIBLE,
  CONSTRAINT `fk_Medicao_Silo1`
    FOREIGN KEY (`Silo_idSilo`)
    REFERENCES `pesagemSilo`.`Silo` (`idSilo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
