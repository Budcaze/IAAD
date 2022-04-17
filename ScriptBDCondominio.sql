-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Administradora`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Administradora` (
  `CNPJ` VARCHAR(255) NOT NULL,
  `Nome` VARCHAR(45) NULL,
  `Endereço` VARCHAR(45) NULL,
  PRIMARY KEY (`CNPJ`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pessoa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pessoa` (
  `CPF` VARCHAR(255) NOT NULL,
  `Nome` VARCHAR(45) NULL,
  `Gênero` VARCHAR(45) NULL,
  `Data_Nascimento` DATE NULL,
  `Telefone` VARCHAR(45) NULL,
  `E-mail` VARCHAR(45) NULL,
  `Profissão` VARCHAR(45) NULL,
  PRIMARY KEY (`CPF`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Apartamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Apartamento` (
  `Cod_Apartamento` INT NOT NULL,
  `Cod_Edificio` INT NOT NULL,
  `CPF_Proprietário` VARCHAR(45) NOT NULL,
  `NúmeroApt` INT NULL,
  `Qtd_Quartos` INT NULL,
  `Qtd_Banheiros` VARCHAR(45) NULL,
  PRIMARY KEY (`Cod_Apartamento`),
  INDEX `Cod_Edificio_idx` (`Cod_Edificio` ASC) VISIBLE,
  INDEX `CPF_Proprietário_idx` (`CPF_Proprietário` ASC) VISIBLE,
  CONSTRAINT `Cod_Edificio`
    FOREIGN KEY (`Cod_Edificio`)
    REFERENCES `mydb`.`Edificio` (`Cod_Edificio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `CPF_Proprietário`
    FOREIGN KEY (`CPF_Proprietário`)
    REFERENCES `mydb`.`Pessoa` (`CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Morador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Morador` (
  `Cod_Apartamento` INT NOT NULL,
  `Cod_Edificio` INT NOT NULL,
  `CPF_Morador` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Cod_Apartamento`, `CPF_Morador`, `Cod_Edificio`),
  INDEX `Cod_Apartamento_idx` (`Cod_Apartamento` ASC) VISIBLE,
  INDEX `Cod_Edificio_idx` (`Cod_Edificio` ASC) VISIBLE,
  CONSTRAINT `Cod_Apartamento`
    FOREIGN KEY (`Cod_Apartamento`)
    REFERENCES `mydb`.`Apartamento` (`Cod_Apartamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Cod_Edificio`
    FOREIGN KEY (`Cod_Edificio`)
    REFERENCES `mydb`.`Edificio` (`Cod_Edificio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `CPF_Morador`
    FOREIGN KEY (`CPF_Morador`)
    REFERENCES `mydb`.`Pessoa` (`CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Edificio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Edificio` (
  `Cod_Edificio` INT NOT NULL,
  `Nome` VARCHAR(45) NULL,
  `Endereço` VARCHAR(45) NOT NULL,
  `CPF_Síndico` VARCHAR(45) NOT NULL,
  `CNPJ_Admin` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Cod_Edificio`),
  INDEX `CPF_Síndico_idx` (`CPF_Síndico` ASC) VISIBLE,
  INDEX `CNPJ_Admin_idx` (`CNPJ_Admin` ASC) VISIBLE,
  CONSTRAINT `CPF_Síndico`
    FOREIGN KEY (`CPF_Síndico`)
    REFERENCES `mydb`.`Morador` (`CPF_Morador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `CNPJ_Admin`
    FOREIGN KEY (`CNPJ_Admin`)
    REFERENCES `mydb`.`Administradora` (`CNPJ`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Funcionário`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Funcionário` (
  `CPF_Funcionário` VARCHAR(255) NOT NULL,
  `Cod_Edificio` INT NOT NULL,
  `Data_Admissão` DATE NULL,
  `CargoFunção` VARCHAR(45) NULL,
  `Salário` INT NULL,
  INDEX `CPF_Funcionário_idx` (`CPF_Funcionário` ASC) VISIBLE,
  INDEX `Cod_Edificio_idx` (`Cod_Edificio` ASC) VISIBLE,
  CONSTRAINT `CPF_Funcionário`
    FOREIGN KEY (`CPF_Funcionário`)
    REFERENCES `mydb`.`Pessoa` (`CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Cod_Edificio`
    FOREIGN KEY (`Cod_Edificio`)
    REFERENCES `mydb`.`Edificio` (`Cod_Edificio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
