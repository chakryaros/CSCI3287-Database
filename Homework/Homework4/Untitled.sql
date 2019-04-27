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
  `U.O.M` VARCHAR(45) NOT NULL,
  `Size` INT NOT NULL,
  `UnitCost` DECIMAL(3,2) NOT NULL,
  `UnitPrice` DECIMAL(3,2) NOT NULL,
  `UnitQTY` INT NOT NULL,
  `UnitOrder` INT NOT NULL,
  `ReorderLevel` INT NOT NULL,
  PRIMARY KEY (`LM_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Eden_landscape`.`LiveStock`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Eden_landscape`.`LiveStock` (
  `LiveStockID` INT NOT NULL AUTO_INCREMENT,
  `Description` VARCHAR(25) NOT NULL,
  `size` INT NOT NULL,
  `UnitCost` DECIMAL(3,2) NOT NULL,
  `UnitPrice` DECIMAL(3,2) NOT NULL,
  `UnitQYT` INT NOT NULL,
  `UnitOrder` INT NOT NULL,
  `ReorderLevel` INT NOT NULL,
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
  `ServiceID` INT NOT NULL AUTO_INCREMENT,
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
-- Table `Eden_landscape`.`LiveStock_has_Suppiler`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Eden_landscape`.`LiveStock_has_Suppiler` (
  `LiveStock_LiveStockID` INT NOT NULL,
  `Suppiler_SuppilerID` INT NOT NULL,
  PRIMARY KEY (`LiveStock_LiveStockID`, `Suppiler_SuppilerID`),
  INDEX `fk_LiveStock_has_Suppiler_Suppiler1_idx` (`Suppiler_SuppilerID` ASC) VISIBLE,
  INDEX `fk_LiveStock_has_Suppiler_LiveStock1_idx` (`LiveStock_LiveStockID` ASC) VISIBLE,
  CONSTRAINT `fk_LiveStock_has_Suppiler_LiveStock1`
    FOREIGN KEY (`LiveStock_LiveStockID`)
    REFERENCES `Eden_landscape`.`LiveStock` (`LiveStockID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_LiveStock_has_Suppiler_Suppiler1`
    FOREIGN KEY (`Suppiler_SuppilerID`)
    REFERENCES `Eden_landscape`.`Suppiler` (`SuppilerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Eden_landscape`.`LiveStock_has_Shipment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Eden_landscape`.`LiveStock_has_Shipment` (
  `LiveStock_LiveStockID` INT NOT NULL,
  `Shipment_ShipmentID` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`LiveStock_LiveStockID`, `Shipment_ShipmentID`),
  INDEX `fk_LiveStock_has_Shipment_Shipment1_idx` (`Shipment_ShipmentID` ASC) VISIBLE,
  INDEX `fk_LiveStock_has_Shipment_LiveStock1_idx` (`LiveStock_LiveStockID` ASC) VISIBLE,
  CONSTRAINT `fk_LiveStock_has_Shipment_LiveStock1`
    FOREIGN KEY (`LiveStock_LiveStockID`)
    REFERENCES `Eden_landscape`.`LiveStock` (`LiveStockID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_LiveStock_has_Shipment_Shipment1`
    FOREIGN KEY (`Shipment_ShipmentID`)
    REFERENCES `Eden_landscape`.`Shipment` (`ShipmentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Eden_landscape`.`LandscapeMaterials_has_Suppiler`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Eden_landscape`.`LandscapeMaterials_has_Suppiler` (
  `LandscapeMaterials_LM_ID` INT NOT NULL,
  `Suppiler_SuppilerID` INT NOT NULL,
  PRIMARY KEY (`LandscapeMaterials_LM_ID`, `Suppiler_SuppilerID`),
  INDEX `fk_LandscapeMaterials_has_Suppiler_Suppiler1_idx` (`Suppiler_SuppilerID` ASC) VISIBLE,
  INDEX `fk_LandscapeMaterials_has_Suppiler_LandscapeMaterials1_idx` (`LandscapeMaterials_LM_ID` ASC) VISIBLE,
  CONSTRAINT `fk_LandscapeMaterials_has_Suppiler_LandscapeMaterials1`
    FOREIGN KEY (`LandscapeMaterials_LM_ID`)
    REFERENCES `Eden_landscape`.`LandscapeMaterials` (`LM_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_LandscapeMaterials_has_Suppiler_Suppiler1`
    FOREIGN KEY (`Suppiler_SuppilerID`)
    REFERENCES `Eden_landscape`.`Suppiler` (`SuppilerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Eden_landscape`.`LandscapeMaterials_has_Shipment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Eden_landscape`.`LandscapeMaterials_has_Shipment` (
  `LandscapeMaterials_LM_ID` INT NOT NULL,
  `Shipment_ShipmentID` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`LandscapeMaterials_LM_ID`, `Shipment_ShipmentID`),
  INDEX `fk_LandscapeMaterials_has_Shipment_Shipment1_idx` (`Shipment_ShipmentID` ASC) VISIBLE,
  INDEX `fk_LandscapeMaterials_has_Shipment_LandscapeMaterials1_idx` (`LandscapeMaterials_LM_ID` ASC) VISIBLE,
  CONSTRAINT `fk_LandscapeMaterials_has_Shipment_LandscapeMaterials1`
    FOREIGN KEY (`LandscapeMaterials_LM_ID`)
    REFERENCES `Eden_landscape`.`LandscapeMaterials` (`LM_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_LandscapeMaterials_has_Shipment_Shipment1`
    FOREIGN KEY (`Shipment_ShipmentID`)
    REFERENCES `Eden_landscape`.`Shipment` (`ShipmentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
