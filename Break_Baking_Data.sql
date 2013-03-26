SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `bread_baking_data` ;
CREATE SCHEMA IF NOT EXISTS `bread_baking_data` DEFAULT CHARACTER SET utf8 ;
USE `bread_baking_data` ;

-- -----------------------------------------------------
-- Table `bread_baking_data`.`sourdough_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bread_baking_data`.`sourdough_type` ;

CREATE  TABLE IF NOT EXISTS `bread_baking_data`.`sourdough_type` (
  `sourdough_type_id` INT NOT NULL ,
  `sourdough_type` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`sourdough_type_id`) ,
  UNIQUE INDEX `sourdogh_type_id_UNIQUE` (`sourdough_type_id` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bread_baking_data`.`natural_yeast_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bread_baking_data`.`natural_yeast_type` ;

CREATE  TABLE IF NOT EXISTS `bread_baking_data`.`natural_yeast_type` (
  `natural_yeast_type_id` INT NOT NULL ,
  `natural_yeast_name` VARCHAR(45) NULL ,
  `natural_yeast_start_date` DATE NULL ,
  PRIMARY KEY (`natural_yeast_type_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bread_baking_data`.`materials`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bread_baking_data`.`materials` ;

CREATE  TABLE IF NOT EXISTS `bread_baking_data`.`materials` (
  `material_id` INT NOT NULL ,
  `material_name` VARCHAR(45) NULL ,
  PRIMARY KEY (`material_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bread_baking_data`.`recipe_material`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bread_baking_data`.`recipe_material` ;

CREATE  TABLE IF NOT EXISTS `bread_baking_data`.`recipe_material` (
  `recipe_material_id` INT NOT NULL ,
  `material_id` INT NULL ,
  `quantity` SMALLINT NULL ,
  PRIMARY KEY (`recipe_material_id`) ,
  INDEX `fk_recipe_materals1_idx` (`material_id` ASC) ,
  CONSTRAINT `fk_recipe_materals1`
    FOREIGN KEY (`material_id` )
    REFERENCES `bread_baking_data`.`materials` (`material_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bread_baking_data`.`sourdough_recipe`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bread_baking_data`.`sourdough_recipe` ;

CREATE  TABLE IF NOT EXISTS `bread_baking_data`.`sourdough_recipe` (
  `sourdough_recipe_id` INT NOT NULL ,
  `sourdough_type_id` INT NULL ,
  `recipe_material_id` INT NOT NULL ,
  `sourdough_recipe_name` VARCHAR(45) NULL ,
  `date` DATE NULL ,
  `natural_yeast_type_id` INT NULL ,
  PRIMARY KEY (`sourdough_recipe_id`) ,
  UNIQUE INDEX `sourdogn_recipe_id_UNIQUE` (`sourdough_recipe_id` ASC) ,
  INDEX `fk_sourdough_recipe_1_idx` (`sourdough_type_id` ASC) ,
  INDEX `fk_sourdough_recipe_2_idx` (`natural_yeast_type_id` ASC) ,
  INDEX `fk_sourdough_recipe_recipe_material1_idx` (`recipe_material_id` ASC) ,
  CONSTRAINT `fk_sourdough_recipe_1`
    FOREIGN KEY (`sourdough_type_id` )
    REFERENCES `bread_baking_data`.`sourdough_type` (`sourdough_type_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sourdough_recipe_2`
    FOREIGN KEY (`natural_yeast_type_id` )
    REFERENCES `bread_baking_data`.`natural_yeast_type` (`natural_yeast_type_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sourdough_recipe_recipe_material1`
    FOREIGN KEY (`recipe_material_id` )
    REFERENCES `bread_baking_data`.`recipe_material` (`recipe_material_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bread_baking_data`.`steps`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bread_baking_data`.`steps` ;

CREATE  TABLE IF NOT EXISTS `bread_baking_data`.`steps` (
  `step_id` INT NOT NULL ,
  `step_name` VARCHAR(45) NULL ,
  PRIMARY KEY (`step_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bread_baking_data`.`ferment_steps`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bread_baking_data`.`ferment_steps` ;

CREATE  TABLE IF NOT EXISTS `bread_baking_data`.`ferment_steps` (
  `ferment_step_id` INT NOT NULL ,
  `step_id` INT NULL ,
  `temporature` SMALLINT NULL ,
  `time` TIME NULL ,
  PRIMARY KEY (`ferment_step_id`) ,
  INDEX `fk_recipe_steps_steps1_idx` (`step_id` ASC) ,
  CONSTRAINT `fk_recipe_steps_steps1`
    FOREIGN KEY (`step_id` )
    REFERENCES `bread_baking_data`.`steps` (`step_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bread_baking_data`.`sourdough_ferment_record`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bread_baking_data`.`sourdough_ferment_record` ;

CREATE  TABLE IF NOT EXISTS `bread_baking_data`.`sourdough_ferment_record` (
  `sourdough_ferment_record_id` INT NOT NULL ,
  `sourdough_recipe_id` INT NOT NULL ,
  `date` DATE NOT NULL ,
  `ferment_hours` SMALLINT NOT NULL ,
  `temporature` SMALLINT NOT NULL ,
  `ferment_step_id` INT NULL ,
  INDEX `fk_sourdough_ferment_record_sourdough_type1_idx` (`sourdough_recipe_id` ASC) ,
  INDEX `fk_sourdough_ferment_record_recipe_steps1_idx` (`ferment_step_id` ASC) ,
  CONSTRAINT `fk_sourdough_ferment_record_sourdough_type1`
    FOREIGN KEY (`sourdough_recipe_id` )
    REFERENCES `bread_baking_data`.`sourdough_recipe` (`sourdough_recipe_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sourdough_ferment_record_recipe_steps1`
    FOREIGN KEY (`ferment_step_id` )
    REFERENCES `bread_baking_data`.`ferment_steps` (`ferment_step_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bread_baking_data`.`loaf_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bread_baking_data`.`loaf_type` ;

CREATE  TABLE IF NOT EXISTS `bread_baking_data`.`loaf_type` (
  `loaf_type_id` INT NOT NULL ,
  `loaf_type` VARCHAR(45) NULL ,
  PRIMARY KEY (`loaf_type_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bread_baking_data`.`yeast_steps`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bread_baking_data`.`yeast_steps` ;

CREATE  TABLE IF NOT EXISTS `bread_baking_data`.`yeast_steps` (
  `yeast_step_id` INT NOT NULL ,
  `step_name` SMALLINT NULL ,
  `time` TIME NULL ,
  PRIMARY KEY (`yeast_step_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bread_baking_data`.`yeast_develop_steps`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bread_baking_data`.`yeast_develop_steps` ;

CREATE  TABLE IF NOT EXISTS `bread_baking_data`.`yeast_develop_steps` (
  `yeast_develop_step_id` INT NOT NULL ,
  `yeast_step_id` INT NULL ,
  `temporature` SMALLINT NULL ,
  PRIMARY KEY (`yeast_develop_step_id`) ,
  INDEX `fk_yeast_develop_steps_yeast_steps1_idx` (`yeast_step_id` ASC) ,
  CONSTRAINT `fk_yeast_develop_steps_yeast_steps1`
    FOREIGN KEY (`yeast_step_id` )
    REFERENCES `bread_baking_data`.`yeast_steps` (`yeast_step_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bread_baking_data`.`yeast_develop_record`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bread_baking_data`.`yeast_develop_record` ;

CREATE  TABLE IF NOT EXISTS `bread_baking_data`.`yeast_develop_record` (
  `yeast_develop_record_id` INT NOT NULL ,
  `natural_yeast_type_id` INT NOT NULL ,
  `yeast_develop_step_id` INT NOT NULL ,
  `date` DATE NOT NULL ,
  `temporature` SMALLINT NULL ,
  PRIMARY KEY (`yeast_develop_record_id`) ,
  INDEX `fk_yeast_develop_record_natual_yeast1_idx` (`natural_yeast_type_id` ASC) ,
  INDEX `fk_yeast_develop_record_yeast_develop_steps1_idx` (`yeast_develop_step_id` ASC) ,
  CONSTRAINT `fk_yeast_develop_record_natural_yeast1`
    FOREIGN KEY (`natural_yeast_type_id` )
    REFERENCES `bread_baking_data`.`natural_yeast_type` (`natural_yeast_type_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_yeast_develop_record_yeast_develop_steps1`
    FOREIGN KEY (`yeast_develop_step_id` )
    REFERENCES `bread_baking_data`.`yeast_develop_steps` (`yeast_develop_step_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bread_baking_data`.`dough_recipe`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bread_baking_data`.`dough_recipe` ;

CREATE  TABLE IF NOT EXISTS `bread_baking_data`.`dough_recipe` (
  `dough_recipe_id` INT NOT NULL ,
  `recipe_material_id` INT NULL ,
  `dough_recipe_name` VARCHAR(45) NULL ,
  `date` VARCHAR(45) NULL ,
  `loaf_type_id` INT NULL ,
  `sourdough_recipe_id` INT NULL ,
  PRIMARY KEY (`dough_recipe_id`) ,
  INDEX `fk_recipe_recipe_material1_idx` (`recipe_material_id` ASC) ,
  INDEX `fk_recipe_1_idx` (`loaf_type_id` ASC) ,
  INDEX `fk_dough_recipe_sourdough_recipe1_idx` (`sourdough_recipe_id` ASC) ,
  CONSTRAINT `fk_recipe_recipe_material1`
    FOREIGN KEY (`recipe_material_id` )
    REFERENCES `bread_baking_data`.`recipe_material` (`recipe_material_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_loaf_type1`
    FOREIGN KEY (`loaf_type_id` )
    REFERENCES `bread_baking_data`.`loaf_type` (`loaf_type_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_dough_recipe_sourdough_recipe1`
    FOREIGN KEY (`sourdough_recipe_id` )
    REFERENCES `bread_baking_data`.`sourdough_recipe` (`sourdough_recipe_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bread_baking_data`.`dough_ferment_record`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bread_baking_data`.`dough_ferment_record` ;

CREATE  TABLE IF NOT EXISTS `bread_baking_data`.`dough_ferment_record` (
  `dough_ferment_steps_id` INT NOT NULL ,
  `dough_recipe_id` INT NULL ,
  `ferment_step_id` INT NULL ,
  `date` DATE NULL ,
  `time` TIME NULL ,
  `temporature` SMALLINT NULL ,
  PRIMARY KEY (`dough_ferment_steps_id`) ,
  INDEX `fk_dough_ferment_record_dough_recipe2_idx` (`dough_recipe_id` ASC) ,
  INDEX `fk_dough_ferment_record_recipe_steps1_idx` (`ferment_step_id` ASC) ,
  CONSTRAINT `fk_dough_ferment_record_dough_recipe2`
    FOREIGN KEY (`dough_recipe_id` )
    REFERENCES `bread_baking_data`.`dough_recipe` (`dough_recipe_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_dough_ferment_record_recipe_steps1`
    FOREIGN KEY (`ferment_step_id` )
    REFERENCES `bread_baking_data`.`ferment_steps` (`ferment_step_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `bread_baking_data` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
