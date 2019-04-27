-- MySQL Script generated by MySQL Workbench
-- Thu Apr  4 16:51:57 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Eden_landscape
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Eden_landscape
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Eden_landscape` DEFAULT CHARACTER SET utf8 ;
USE `Eden_landscape` ;

-- -----------------------------------------------------
-- Table `Eden_landscape`.`Suppiler`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Eden_landscape`.`Suppiler` (
  `SuppilerID` INT NOT NULL AUTO_INCREMENT,
  `Category` VARCHAR(45) NULL,
  `SupplierName` VARCHAR(45) NULL,
  `SuppilerAddress1` VARCHAR(45) NULL,
  `SuppilerAddress2` VARCHAR(45) NULL,
  `SuppilerCity` VARCHAR(45) NULL,
  `SuppilerState` VARCHAR(45) NULL,
  `SuppilerZip` VARCHAR(10) NULL,
  `SupplierPhone(Order)` VARCHAR(10) NULL,
  `SuppilerContact` VARCHAR(45) NULL,
  `ContactPhone` VARCHAR(10) NULL,
  `Shipping & BillingTerms` VARCHAR(65) NULL,
  `Preferred` TINYINT NULL,
  `SuppilerFax` VARCHAR(10) NULL,
  `Notes` TEXT(1024) NULL,
  PRIMARY KEY (`SuppilerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Eden_landscape`.`LandscapeMaterials`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Eden_landscape`.`LandscapeMaterials` (
  `LM_ID` INT NOT NULL AUTO_INCREMENT,
  `L_MName` VARCHAR(20) NOT NULL,
  `L_MDescription` VARCHAR(45) NOT NULL,
  `U.O.M` VARCHAR(45) NULL,
  `Size` INT NULL,
  `UnitCost` DECIMAL(3,2) NULL,
  `UnitPrice` DECIMAL(3,2) NULL,
  `UnitQTY` INT NULL,
  PRIMARY KEY (`LM_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Eden_landscape`.`LiveStock`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Eden_landscape`.`LiveStock` (
  `LiveStockID` INT NOT NULL AUTO_INCREMENT,
  `Description` VARCHAR(25) NOT NULL,
  `size` INT NULL,
  `UnitCost` DECIMAL(3,2) NULL,
  `UnitPrice` DECIMAL(3,2) NULL,
  `UnitQYT` INT NULL,
  PRIMARY KEY (`LiveStockID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Eden_landscape`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Eden_landscape`.`Customers` (
  `CustomersID` INT NOT NULL AUTO_INCREMENT,
  `Customer_Details` VARCHAR(65) NULL,
  PRIMARY KEY (`CustomersID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Eden_landscape`.`Invoice`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Eden_landscape`.`Invoice` (
  `InvoiceID` INT NOT NULL,
  `CustomerID` INT NOT NULL,
  `OrderDate` DATETIME NULL,
  `ShippedDate` DATETIME NULL,
  `ShipName` VARCHAR(45) NULL,
  `ShipAddress` VARCHAR(45) NULL,
  PRIMARY KEY (`InvoiceID`),
  INDEX `customerID_idx` (`CustomerID` ASC) VISIBLE,
  CONSTRAINT `customerID`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `Eden_landscape`.`Customers` (`CustomersID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Eden_landscape`.`Service`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Eden_landscape`.`Service` (
  `ServiceID` INT ZEROFILL NOT NULL,
  `Description` VARCHAR(45) NULL,
  PRIMARY KEY (`ServiceID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Eden_landscape`.`InvoiceDetail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Eden_landscape`.`InvoiceDetail` (
  `InvoiceDetails_ID` INT NOT NULL,
  `Invoice` INT NOT NULL,
  `LM_ID` INT NOT NULL,
  `LiveStockID` INT NOT NULL,
  `ServiceID` INT NOT NULL,
  `QuantityOrder` INT NOT NULL,
  `Unitprice` DECIMAL(3,2) NULL,
  `Discount` DECIMAL(3,2) NULL,
  `Type (S, LM, LS)` TINYTEXT NULL,
  PRIMARY KEY (`InvoiceDetails_ID`),
  INDEX `InvoiceID_idx` (`Invoice` ASC) VISIBLE,
  INDEX `LiveStockID_idx` (`LiveStockID` ASC) VISIBLE,
  INDEX `LM_ID_idx` (`LM_ID` ASC) VISIBLE,
  INDEX `ServiceID_idx` (`ServiceID` ASC) VISIBLE,
  CONSTRAINT `InvoiceID`
    FOREIGN KEY (`Invoice`)
    REFERENCES `Eden_landscape`.`Invoice` (`InvoiceID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `LiveStockID`
    FOREIGN KEY (`LiveStockID`)
    REFERENCES `Eden_landscape`.`LiveStock` (`LiveStockID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `LM_ID`
    FOREIGN KEY (`LM_ID`)
    REFERENCES `Eden_landscape`.`LandscapeMaterials` (`LM_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ServiceID`
    FOREIGN KEY (`ServiceID`)
    REFERENCES `Eden_landscape`.`Service` (`ServiceID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Eden_landscape`.`Shipment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Eden_landscape`.`Shipment` (
  `ShipmentID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `SupplierID` INT NOT NULL,
  `B.O.L` VARCHAR(45) NULL,
  `Description` VARCHAR(45) NULL,
  `Note` TEXT(1056) NULL,
  PRIMARY KEY (`ShipmentID`),
  INDEX `SupplierID_idx` (`SupplierID` ASC) VISIBLE,
  CONSTRAINT `SupplierID`
    FOREIGN KEY (`SupplierID`)
    REFERENCES `Eden_landscape`.`Suppiler` (`SuppilerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Eden_landscape`.`SupplierMaterial`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Eden_landscape`.`SupplierMaterial` (
  `SupplierID` INT NOT NULL,
  `LM_ID` INT NOT NULL,
  `LandscapeMaterials_LM_ID` INT NOT NULL,
  `Suppiler_SuppilerID` INT NOT NULL,
  PRIMARY KEY (`LandscapeMaterials_LM_ID`, `Suppiler_SuppilerID`),
  INDEX `fk_SupplierMaterial_Suppiler1_idx` (`SupplierID` ASC, `LM_ID` ASC) VISIBLE,
  CONSTRAINT `fk_SupplierMaterial_LandscapeMaterials1`
    FOREIGN KEY ()
    REFERENCES `Eden_landscape`.`LandscapeMaterials` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SupplierMaterial_Suppiler1`
    FOREIGN KEY (`SupplierID` , `LM_ID`)
    REFERENCES `Eden_landscape`.`Suppiler` (`SuppilerID` , `SuppilerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Eden_landscape`.`SupplierLiveStock`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Eden_landscape`.`SupplierLiveStock` (
  `SupplierID` INT NOT NULL,
  `LiveStockID` INT NOT NULL,
  `LiveStock_LiveStockID` INT NOT NULL,
  `Suppiler_SuppilerID` INT NOT NULL,
  PRIMARY KEY (`Suppiler_SuppilerID`, `LiveStock_LiveStockID`),
  INDEX `fk_SupplierLiveStock_Suppiler1_idx` (`LiveStockID` ASC, `SupplierID` ASC) VISIBLE,
  CONSTRAINT `fk_SupplierLiveStock_LiveStock1`
    FOREIGN KEY ()
    REFERENCES `Eden_landscape`.`LiveStock` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SupplierLiveStock_Suppiler1`
    FOREIGN KEY (`LiveStockID` , `SupplierID`)
    REFERENCES `Eden_landscape`.`Suppiler` (`SuppilerID` , `SuppilerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Eden_landscape`.`ShipmentMaterial`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Eden_landscape`.`ShipmentMaterial` (
  `LM_ID` INT NOT NULL,
  `ShipmentID` INT NOT NULL,
  `LandscapeMaterials_LM_ID` INT NOT NULL,
  `Shipment_ShipmentID` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`LandscapeMaterials_LM_ID`, `Shipment_ShipmentID`),
  CONSTRAINT `fk_ShipmentMaterial_LandscapeMaterials1`
    FOREIGN KEY ()
    REFERENCES `Eden_landscape`.`LandscapeMaterials` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ShipmentMaterial_Shipment1`
    FOREIGN KEY ()
    REFERENCES `Eden_landscape`.`Shipment` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Eden_landscape`.`shipmentLiveStock`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Eden_landscape`.`shipmentLiveStock` (
  `LiveStockID` INT NOT NULL,
  `ShipementID` INT NOT NULL,
  `LiveStock_LiveStockID` INT NOT NULL,
  `Shipment_ShipmentID` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`LiveStock_LiveStockID`, `Shipment_ShipmentID`),
  INDEX `fk_shipmentLiveStock_Shipment1_idx` (`ShipementID` ASC, `LiveStockID` ASC) VISIBLE,
  CONSTRAINT `fk_shipmentLiveStock_LiveStock1`
    FOREIGN KEY ()
    REFERENCES `Eden_landscape`.`LiveStock` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_shipmentLiveStock_Shipment1`
    FOREIGN KEY (`ShipementID` , `LiveStockID`)
    REFERENCES `Eden_landscape`.`Shipment` (`SupplierID` , `SupplierID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
