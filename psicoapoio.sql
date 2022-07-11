SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`usuario` (
  `idusuario` INT NOT NULL,
  `nome` VARCHAR(100) NULL,
  `email` VARCHAR(100) NULL,
  `senha` VARCHAR(100) NULL,
  PRIMARY KEY (`idusuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`post`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`post` (
  `idpost` INT NOT NULL,
  `postagem` VARCHAR(255) NULL,
  `comentario_idcomentario` INT NOT NULL,
  `usuario_idusuario` INT NOT NULL,
  PRIMARY KEY (`idpost`, `comentario_idcomentario`, `usuario_idusuario`),
  INDEX `fk_post_usuario1_idx` (`usuario_idusuario` ASC),
  CONSTRAINT `fk_post_usuario1`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `mydb`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`comentario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`comentario` (
  `idcomentario` INT NOT NULL,
  `resp_comentario` VARCHAR(255) NULL,
  `curtidas` INT NULL,
  `usuario_idusuario` INT NOT NULL,
  `post_idpost` INT NOT NULL,
  `post_comentario_idcomentario` INT NOT NULL,
  PRIMARY KEY (`idcomentario`, `post_idpost`, `post_comentario_idcomentario`),
  INDEX `fk_comentario_usuario_idx` (`usuario_idusuario` ASC),
  INDEX `fk_comentario_post1_idx` (`post_idpost` ASC, `post_comentario_idcomentario` ASC),
  CONSTRAINT `fk_comentario_usuario`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `mydb`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comentario_post1`
    FOREIGN KEY (`post_idpost` , `post_comentario_idcomentario`)
    REFERENCES `mydb`.`post` (`idpost` , `comentario_idcomentario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`conteudos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`conteudos` (
  `idconteudos` INT NOT NULL,
  `descricao` VARCHAR(45) NULL,
  `tittulo` VARCHAR(255) NULL,
  `usuario_idusuario` INT NOT NULL,
  PRIMARY KEY (`idconteudos`),
  INDEX `fk_conteudos_usuario1_idx` (`usuario_idusuario` ASC),
  CONSTRAINT `fk_conteudos_usuario1`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `mydb`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`denuncia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`denuncia` (
  `usuario_idusuario` INT NOT NULL,
  `comentario_idcomentario` INT NOT NULL,
  PRIMARY KEY (`usuario_idusuario`, `comentario_idcomentario`),
  INDEX `fk_usuario_has_comentario_comentario1_idx` (`comentario_idcomentario` ASC),
  INDEX `fk_usuario_has_comentario_usuario1_idx` (`usuario_idusuario` ASC),
  CONSTRAINT `fk_usuario_has_comentario_usuario1`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `mydb`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_has_comentario_comentario1`
    FOREIGN KEY (`comentario_idcomentario`)
    REFERENCES `mydb`.`comentario` (`idcomentario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `mydb` ;

-- -----------------------------------------------------
-- Placeholder table for view `mydb`.`view1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`view1` (`id` INT);

-- -----------------------------------------------------
-- View `mydb`.`view1`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`view1`;
USE `mydb`;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
