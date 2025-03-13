-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ecmg
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ecmg
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ecmg` DEFAULT CHARACTER SET utf8 ;
USE `ecmg` ;

-- -----------------------------------------------------
-- Table `ecmg`.`GUEST`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecmg`.`GUEST` (
  `GuestID` INT NOT NULL,
  `FirstName` VARCHAR(45) NOT NULL,
  `LastName` VARCHAR(45) NOT NULL,
  `Street` VARCHAR(45) NULL,
  `City` VARCHAR(45) NULL,
  `State` VARCHAR(45) NULL,
  `Postcode` INT NULL,
  `MobilePhone` INT NOT NULL,
  `DateOfBirth` DATE NULL,
  `DriverLicenseNo` INT NOT NULL,
  PRIMARY KEY (`GuestID`),
  INDEX `IdxGuestName` (`LastName` ASC) VISIBLE,
  INDEX `IdxGuestPhone` (`MobilePhone` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecmg`.`MOTEL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecmg`.`MOTEL` (
  `MotelID` INT NOT NULL,
  `MotelName` VARCHAR(45) NOT NULL,
  `Street` VARCHAR(45) NULL,
  `City` VARCHAR(45) NULL,
  `State` VARCHAR(45) NULL,
  `Postcode` INT NULL,
  `Telephone` INT NOT NULL,
  PRIMARY KEY (`MotelID`),
  INDEX `IdxMotelName` (`MotelName` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecmg`.`ROOMTYPE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecmg`.`ROOMTYPE` (
  `TypeID` INT NOT NULL,
  `TypeDescription` VARCHAR(45) NULL,
  `PricePerNight` INT NOT NULL,
  PRIMARY KEY (`TypeID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecmg`.`ROOM`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecmg`.`ROOM` (
  `RoomID` INT NOT NULL,
  `MotelID` INT NOT NULL,
  `MaxNumOfAccom` INT NULL,
  `NumOfBed` INT NULL,
  `TypeID` INT NOT NULL,
  PRIMARY KEY (`RoomID`, `MotelID`),
  INDEX `fk_ROOM_MOTEL1_idx` (`MotelID` ASC) VISIBLE,
  INDEX `fk_ROOM_ROOMTYPE1_idx` (`TypeID` ASC) VISIBLE,
  CONSTRAINT `fk_ROOM_MOTEL1`
    FOREIGN KEY (`MotelID`)
    REFERENCES `ecmg`.`MOTEL` (`MotelID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ROOM_ROOMTYPE1`
    FOREIGN KEY (`TypeID`)
    REFERENCES `ecmg`.`ROOMTYPE` (`TypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecmg`.`BOOKING`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecmg`.`BOOKING` (
  `BookingID` INT NOT NULL,
  `StartDate` DATE NOT NULL,
  `EndDate` DATE NOT NULL,
  `NumOfPeople` INT NULL,
  `TotalCharge` INT NOT NULL,
  `Status` VARCHAR(45) NULL,
  `RoomID` INT NULL,
  `MotelID` INT NULL,
  `GuestID` INT NOT NULL,
  PRIMARY KEY (`BookingID`),
  INDEX `fk_BOOKING_ROOM1_idx` (`RoomID` ASC, `MotelID` ASC) VISIBLE,
  INDEX `fk_BOOKING_GUEST1_idx` (`GuestID` ASC) VISIBLE,
  CONSTRAINT `fk_BOOKING_ROOM1`
    FOREIGN KEY (`RoomID` , `MotelID`)
    REFERENCES `ecmg`.`ROOM` (`RoomID` , `MotelID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_BOOKING_GUEST1`
    FOREIGN KEY (`GuestID`)
    REFERENCES `ecmg`.`GUEST` (`GuestID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecmg`.`EMPLOYEE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecmg`.`EMPLOYEE` (
  `EmployeeID` INT NOT NULL,
  `FirstName` VARCHAR(45) NOT NULL,
  `LastName` VARCHAR(45) NOT NULL,
  `Street` VARCHAR(45) NULL,
  `City` VARCHAR(45) NULL,
  `State` VARCHAR(45) NULL,
  `Postcode` INT NULL,
  `Phone` INT NULL,
  `Gender` VARCHAR(45) NULL,
  `MotelID` INT NOT NULL,
  PRIMARY KEY (`EmployeeID`),
  INDEX `fk_EMPLOYEE_MOTEL1_idx` (`MotelID` ASC) VISIBLE,
  INDEX `IdxEmployeeName` (`LastName` ASC) VISIBLE,
  CONSTRAINT `fk_EMPLOYEE_MOTEL1`
    FOREIGN KEY (`MotelID`)
    REFERENCES `ecmg`.`MOTEL` (`MotelID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecmg`.`CONTRACTOR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecmg`.`CONTRACTOR` (
  `EmployeeID` INT NOT NULL,
  `TradeLicenseNo` INT NOT NULL,
  `SkillDescription` VARCHAR(45) NULL,
  PRIMARY KEY (`EmployeeID`),
  INDEX `fk_CONTRACTOR_EMPLOYEE1_idx` (`EmployeeID` ASC) VISIBLE,
  CONSTRAINT `fk_CONTRACTOR_EMPLOYEE1`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `ecmg`.`EMPLOYEE` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecmg`.`REPAIRJOB`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecmg`.`REPAIRJOB` (
  `JobID` INT NOT NULL,
  `CompletionDate` DATE NOT NULL,
  `LabourCost` INT NOT NULL,
  `MaterialCost` INT NOT NULL,
  `JobDescription` VARCHAR(45) NULL,
  `EmployeeID` INT NOT NULL,
  `RoomID` INT NOT NULL,
  `MotelID` INT NOT NULL,
  PRIMARY KEY (`JobID`),
  INDEX `fk_REPAIRJOB_CONTRACTOR1_idx` (`EmployeeID` ASC) VISIBLE,
  INDEX `fk_REPAIRJOB_ROOM1_idx` (`RoomID` ASC, `MotelID` ASC) VISIBLE,
  CONSTRAINT `fk_REPAIRJOB_CONTRACTOR1`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `ecmg`.`CONTRACTOR` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_REPAIRJOB_ROOM1`
    FOREIGN KEY (`RoomID` , `MotelID`)
    REFERENCES `ecmg`.`ROOM` (`RoomID` , `MotelID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecmg`.`DIGITALMEDIA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecmg`.`DIGITALMEDIA` (
  `MediaID` INT NOT NULL,
  `MediaName` VARCHAR(45) NOT NULL,
  `WebAddress` VARCHAR(45) NULL,
  `Phone` INT NULL,
  `ContactPerson` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`MediaID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecmg`.`ADVERTISEMENT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecmg`.`ADVERTISEMENT` (
  `AdvertisementID` INT NOT NULL,
  `AdvertisementDate` DATE NOT NULL,
  `Cost` INT NOT NULL,
  `MotelID` INT NOT NULL,
  `MediaID` INT NOT NULL,
  PRIMARY KEY (`AdvertisementID`),
  INDEX `fk_ADVERTISEMENT_MOTEL1_idx` (`MotelID` ASC) VISIBLE,
  INDEX `fk_ADVERTISEMENT_DIGITALMEDIA1_idx` (`MediaID` ASC) VISIBLE,
  CONSTRAINT `fk_ADVERTISEMENT_MOTEL1`
    FOREIGN KEY (`MotelID`)
    REFERENCES `ecmg`.`MOTEL` (`MotelID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ADVERTISEMENT_DIGITALMEDIA1`
    FOREIGN KEY (`MediaID`)
    REFERENCES `ecmg`.`DIGITALMEDIA` (`MediaID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecmg`.`ADMIN`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecmg`.`ADMIN` (
  `EmployeeID` INT NOT NULL,
  `AnnualSalary` INT NULL,
  PRIMARY KEY (`EmployeeID`),
  CONSTRAINT `fk_ADMIN_EMPLOYEE1`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `ecmg`.`EMPLOYEE` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecmg`.`MANAGER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecmg`.`MANAGER` (
  `EmployeeID` INT NOT NULL,
  `Qualification` VARCHAR(45) NULL,
  `YearsOfExperience` INT NULL,
  `MotelID` INT NULL,
  PRIMARY KEY (`EmployeeID`),
  INDEX `fk_MANAGER_EMPLOYEE1_idx` (`EmployeeID` ASC) VISIBLE,
  INDEX `fk_MANAGER_MOTEL1_idx` (`MotelID` ASC) VISIBLE,
  CONSTRAINT `fk_MANAGER_EMPLOYEE1`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `ecmg`.`EMPLOYEE` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `MotelID`
    FOREIGN KEY (`MotelID`)
    REFERENCES `ecmg`.`MOTEL` (`MotelID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- POPULATE TABLES --
-- Populate Guest Table --
INSERT INTO `ecmg`.`guest` VALUES(1, 'Michael', 'Hall', 'Hampden St', 'Sydney', 'NSW', 2060, 749008877, '1965-04-23', '1942045821');
INSERT INTO `ecmg`.`guest` VALUES(2, 'John', 'Smith', 'Takanna Ave', 'Clifton Springs', 'VIC', 3222, 0490787772, '1972-08-12', '1501253829');
INSERT INTO `ecmg`.`guest` VALUES(3, 'John', 'Connor', 'Windermere Way', 'Cardigan Village', 'VIC', 3352, 0760561114, '1980-12-05', '1391058192');
INSERT INTO `ecmg`.`guest` VALUES(4, 'James', 'Farrell', 'Drew St', 'Spalding', 'WA', 6530, 0451090777, '1996-07-20', '0129421592');
INSERT INTO `ecmg`.`guest` VALUES(5, 'Luke', 'Reynolds', 'Harold Ct', 'Rothwell', 'QLD', 4022, 0351455513, '1960-03-13', '1142052041');
INSERT INTO `ecmg`.`guest` VALUES(6, 'Micheal', 'Corleone', 'Clarendon Rd', 'Stanmore', 'NSW', 2048, 0251455513, '1986-09-06', '1419252941');
INSERT INTO `ecmg`.`guest` VALUES(7, 'Forest', 'Gump', 'Ocean Beach Rd', 'Umina Beach', 'NSW', 2257, 0883766445, '1992-05-17', '1105291258');
INSERT INTO `ecmg`.`guest` VALUES(8, 'Hamish', 'Newton', 'William St', 'Wodonga', 'VIC', 3690, 0365410213, '1973-11-08', '0852940612');
INSERT INTO `ecmg`.`guest` VALUES(9, 'Lochlan', 'Jones', 'Mcwhae Gardns', 'Bayswater', 'WA', 6053, 0738893992, '1959-01-02', '1129529402');
INSERT INTO `ecmg`.`guest` VALUES(10, 'Walter', 'White', 'Link Rd', 'Wombat', 'VIC', 3461, 0408456695, '2000-08-17', '0918258402');
INSERT INTO `ecmg`.`guest` VALUES(11, 'Raymond', 'Holt', 'Central Rd', 'Footscray', 'VIC', 3011, 0410654852, '1960-10-14', '0910248182');
INSERT INTO `ecmg`.`guest` VALUES(12, 'Jake', 'Peralta', 'Hermit St', 'Annandale', 'QLD', 4012, 0406478245, '1970-09-07', '1324148249');
INSERT INTO `ecmg`.`guest` VALUES(13, 'Gina', 'Linetti', 'Brooklyn Ave', 'Aitkenvale', 'QLD', 4031, 0407631852, '1970-08-20', '1331292058');
INSERT INTO `ecmg`.`guest` VALUES(14, 'Rosa', 'Diaz', 'Shire Rd', 'Perth', 'WA', 6500, 0404665987, '1974-04-01', '1312950825');
INSERT INTO `ecmg`.`guest` VALUES(15, 'Amy', 'Santiago', 'Martin St', 'Parametta', 'NSW', 2050, 0414449651, '1972-01-04', '1348195823');

-- Populate Motel --
INSERT INTO `ecmg`.`motel` VALUES(01, 'ECMG Rockhampton', 'Alma St', 'Rockhampton', 'QLD', 4700, 49277433);
INSERT INTO `ecmg`.`motel` VALUES(02, 'ECMG Mackay', 'Peel St', 'Mackay', 'QLD', 4740, 49533117);
INSERT INTO `ecmg`.`motel` VALUES(03, 'ECMG Gladstone', 'Toolooa St', 'South Gladstone', 'QLD', 4680, 49722144);
INSERT INTO `ecmg`.`motel` VALUES(04, 'ECMG Townsville', 'Flinders St', 'Townsville', 'QLD', 4810, 47721888);

-- Populate Digital Media --
INSERT INTO `ecmg`.`digitalmedia` VALUES(0011, 'TSV Ads', 'www.tsvads.com', 47721928, 'Ariel');
INSERT INTO `ecmg`.`digitalmedia` VALUES(0012, 'Rocky Media', 'www.rockymedia.com', 47724531, 'Moana');
INSERT INTO `ecmg`.`digitalmedia` VALUES(0013, 'Glad-vertisement', 'www.gladvertisement.com', 47221205, 'Tiana');
INSERT INTO `ecmg`.`digitalmedia` VALUES(0014, 'Mackay Ads', 'www.mackayads.com', 47152416, 'Merida');

-- Populate Advertisement --
INSERT INTO `ecmg`.`advertisement` VALUES(0001, '2022-08-08', 5000, 01, 0012);
INSERT INTO `ecmg`.`advertisement` VALUES(0002, '2022-08-08', 4500, 04, 0011);
INSERT INTO `ecmg`.`advertisement` VALUES(0003, '2022-08-08', 4000, 03, 0013);
INSERT INTO `ecmg`.`advertisement` VALUES(0004, '2022-08-08', 5500, 02, 0014);

-- Populate Employee --
INSERT INTO `ecmg`.`employee` VALUES(1, 'Tony', 'Stark', 'Quoin Road', 'Rockhampton', 'QLD', 4812, 62077246, 'M', 01);
INSERT INTO `ecmg`.`employee` VALUES(2, 'Steve', 'Rogers', 'Purcell Place', 'Gladstone', 'QLD', 4728, 67883482, 'M', 03);
INSERT INTO `ecmg`.`employee` VALUES(3, 'Natasha', 'Romanoff', 'Walder Crescent', 'Rockhampton', 'QLD', 4325, 62077246, 'F', 01);
INSERT INTO `ecmg`.`employee` VALUES(4, 'Clint', 'Barton', 'Frencham Street', 'Mackay', 'QLD', 4402, 61651828, 'M', 02);
INSERT INTO `ecmg`.`employee` VALUES(5, 'Tchalla', 'Okonkwo', 'Loris Way', 'Townsville', 'QLD', 4892, 90469939, 'M', 04);
INSERT INTO `ecmg`.`employee` VALUES(6, 'Stephen', 'Strange', 'Shadforth Street', 'Rockhampton', 'QLD', 4305, 53822946, 'M', 01);
INSERT INTO `ecmg`.`employee` VALUES(7, 'Bruce', 'Banner', 'Gloucester Avenue', 'Townsville', 'QLD', 4892, 83718888, 'M', 04);
INSERT INTO `ecmg`.`employee` VALUES(8, 'Bruce', 'Wayne', 'Gotham Street', 'Gladstone', 'QLD', 4820, 45568852, 'M', 03);
INSERT INTO `ecmg`.`employee` VALUES(9, 'Clark', 'Kent', 'Smallville Road', 'Mackay', 'QLD', 4632, 81200578, 'M', 02);
INSERT INTO `ecmg`.`employee` VALUES(10, 'Peter', 'Parker', 'Queens Street', 'Mackay', 'QLD', 4556, 42580972, 'M', 02);
INSERT INTO `ecmg`.`employee` VALUES(11, 'Kamala', 'Khan', 'Clifton Road', 'Townsville', 'QLD', 4693, 98834375, 'M', 04);
INSERT INTO `ecmg`.`employee` VALUES(12, 'Ron', 'Swanson', 'Pawnee Avenue', 'Rockhampton', 'QLD', 4700, 40688112, 'M', 01);
INSERT INTO `ecmg`.`employee` VALUES(13, 'Michael', 'Scott', 'Scranton Street', 'Mackay', 'QLD', 4740, 62607583, 'M', 02);
INSERT INTO `ecmg`.`employee` VALUES(14, 'Perry', 'Cox', 'Sacred Heart', 'Gladstone', 'QLD', 4680, 62440216, 'M', 03);
INSERT INTO `ecmg`.`employee` VALUES(15, 'Dean', 'Pelton', 'Greendale Street', 'Townsville', 'QLD', 4810, 67935873, 'M', 04);

-- Populate Contractor --
INSERT INTO `ecmg`.`contractor` VALUES(6, 140293, 'Plumber');
INSERT INTO `ecmg`.`contractor` VALUES(2, 144293, 'Carpenter');
INSERT INTO `ecmg`.`contractor` VALUES(10, 145193, 'Electrician');
INSERT INTO `ecmg`.`contractor` VALUES(7, 143293, 'Locksmith');

-- Populate Admin --
INSERT INTO `ecmg`.`admin` VALUES(1, 40000);
INSERT INTO `ecmg`.`admin` VALUES(3, 43000);
INSERT INTO `ecmg`.`admin` VALUES(4, 42000);
INSERT INTO `ecmg`.`admin` VALUES(5, 45000);
INSERT INTO `ecmg`.`admin` VALUES(8, 43500);
INSERT INTO `ecmg`.`admin` VALUES(9, 42500);
INSERT INTO `ecmg`.`admin` VALUES(11, 41000);

-- Populate Manager --
INSERT INTO `ecmg`.`manager` VALUES(12, 'MBA', 10, 01);
INSERT INTO `ecmg`.`manager` VALUES(13, 'BBA', 15, 02);
INSERT INTO `ecmg`.`manager` VALUES(14, 'MBBS', 12, 03);
INSERT INTO `ecmg`.`manager` VALUES(15, 'MA', 16, 04);

-- Populate Room Type--
INSERT INTO `ecmg`.`roomtype` VALUES(1, 'Standard Room', 120);
INSERT INTO `ecmg`.`roomtype` VALUES(2, 'Superior Room', 180);
INSERT INTO `ecmg`.`roomtype` VALUES(3, 'Deluxe Room', 400);

-- Populate Room --
INSERT INTO `ecmg`.`room` VALUES(10000, 01, 2, 1, 1);
INSERT INTO `ecmg`.`room` VALUES(10001, 02, 2, 1, 1);
INSERT INTO `ecmg`.`room` VALUES(10002, 03, 2, 1, 1);
INSERT INTO `ecmg`.`room` VALUES(10003, 04, 2, 1, 1);
INSERT INTO `ecmg`.`room` VALUES(10004, 01, 2, 1, 1);
INSERT INTO `ecmg`.`room` VALUES(10005, 02, 2, 1, 1);
INSERT INTO `ecmg`.`room` VALUES(10006, 03, 2, 1, 1);
INSERT INTO `ecmg`.`room` VALUES(10007, 04, 2, 1, 1);
INSERT INTO `ecmg`.`room` VALUES(10008, 01, 3, 2, 2);
INSERT INTO `ecmg`.`room` VALUES(10009, 02, 3, 2, 2);
INSERT INTO `ecmg`.`room` VALUES(10010, 03, 3, 2, 2);
INSERT INTO `ecmg`.`room` VALUES(10011, 04, 3, 2, 2);
INSERT INTO `ecmg`.`room` VALUES(10012, 01, 4, 2, 3);
INSERT INTO `ecmg`.`room` VALUES(10013, 02, 4, 2, 3);
INSERT INTO `ecmg`.`room` VALUES(10014, 03, 4, 2, 3);
INSERT INTO `ecmg`.`room` VALUES(10015, 04, 4, 2, 3);
INSERT INTO `ecmg`.`room` VALUES(10016, 04, 3, 2, 2);
INSERT INTO `ecmg`.`room` VALUES(10017, 04, 4, 2, 3);
INSERT INTO `ecmg`.`room` VALUES(10018, 03, 4, 2, 3);
INSERT INTO `ecmg`.`room` VALUES(10019, 03, 4, 2, 3);
INSERT INTO `ecmg`.`room` VALUES(10020, 02, 4, 2, 3);

-- Populate Booking Table --
INSERT INTO `ecmg`.`booking` VALUES(101, '2022-04-13', '2022-04-18', 2, 120, 'CONFIRMED', 10000, 01, 4);
INSERT INTO `ecmg`.`booking` VALUES(102, '2022-04-15', '2022-04-19', 2, 120, 'CONFIRMED', 10006, 03, 2);
INSERT INTO `ecmg`.`booking` VALUES(103, '2022-04-23', '2022-04-24', 3, 180, 'CONFIRMED', 10009, 02, 7);
INSERT INTO `ecmg`.`booking` VALUES(104, '2022-05-05', '2022-05-07', 4, 400, 'CONFIRMED', 10014, 03, 3);
INSERT INTO `ecmg`.`booking` VALUES(105, '2022-05-06', '2022-05-18', 2, 120, 'CONFIRMED', 10005, 02, 9);
INSERT INTO `ecmg`.`booking` VALUES(106, '2022-05-15', '2022-05-18', 1, 120, 'CONFIRMED', 10004, 01, 8);
INSERT INTO `ecmg`.`booking` VALUES(107, '2022-05-20', '2022-05-28', 3, 180, 'CONFIRMED', 10008, 01, 5);
INSERT INTO `ecmg`.`booking` VALUES(108, '2022-06-01', '2022-06-04', 1, 120, 'CONFIRMED', 10001, 02, 6);
INSERT INTO `ecmg`.`booking` VALUES(109, '2022-06-05', '2022-06-08', 4, 400, 'CONFIRMED', 10015, 04, 10);
INSERT INTO `ecmg`.`booking` VALUES(110, '2022-06-12', '2022-06-18', 3, 180, 'CONFIRMED', 10010, 03, 14);
INSERT INTO `ecmg`.`booking` VALUES(111, '2022-06-14', '2022-06-18', 1, 120, 'CONFIRMED', 10002, 03, 12);
INSERT INTO `ecmg`.`booking` VALUES(112, '2022-06-16', '2022-06-19', 3, 180, 'IN PROCESS', 10011, 04, 13);
INSERT INTO `ecmg`.`booking` VALUES(113, '2022-06-19', '2022-06-22', 3, 400, 'IN PROCESS', 10013, 02, 15);
INSERT INTO `ecmg`.`booking` VALUES(114, '2022-06-22', '2022-06-28', 4, 400, 'IN PROCESS', 10012, 01, 11);
INSERT INTO `ecmg`.`booking` VALUES(115, '2022-06-26', '2022-06-28', 2, 120, 'IN PROCESS', 10003, 04, 1);
INSERT INTO `ecmg`.`booking` VALUES(116, '2022-06-26', '2022-06-28', 2, 120, 'IN PROCESS', 10007, 04, 1);
INSERT INTO `ecmg`.`booking` VALUES(117, '2022-06-26', '2022-06-28', 2, 180, 'IN PROCESS', 10016, 04, 1);
INSERT INTO `ecmg`.`booking` VALUES(118, '2022-06-26', '2022-06-28', 2, 400, 'IN PROCESS', 10017, 04, 1);

-- Populate Repair Job Table --
INSERT INTO `ecmg`.`repairjob` VALUES(1001, '2022-02-08', 120, 200, 'Changing Locks', 7, 10003, 04);
INSERT INTO `ecmg`.`repairjob` VALUES(1002, '2022-02-10', 150, 250, 'New Door', 2, 10006, 03);
INSERT INTO `ecmg`.`repairjob` VALUES(1003, '2022-02-20', 90, 100, 'Fixing Lights', 10, 10009, 02);
INSERT INTO `ecmg`.`repairjob` VALUES(1004, '2022-02-24', 90, 125, 'Toilet Fix', 6, 10004, 01);

-- Stored Procedure --
DELIMITER //

CREATE PROCEDURE procedure_1()
BEGIN
Select FirstName, LastName, BookingID, StartDate, EndDate, Booking.RoomID, MotelName
FROM Booking 
JOIN Guest
	ON Booking.GuestID = Guest.GuestID
JOIN Room
	On Room.RoomID = Booking.RoomID
JOIN Motel
	On Motel.MotelID = Booking.MotelID
WHERE Motel.MotelID = 1;
END //

DELIMITER ;