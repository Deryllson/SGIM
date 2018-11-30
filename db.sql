-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema sgim1.1
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema sgim1.1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `sgim1.1` DEFAULT CHARACTER SET utf8 ;
USE `sgim1.1` ;

-- -----------------------------------------------------
-- Table `sgim1.1`.`anolectivo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgim1.1`.`anolectivo` (
  `id_anolectivo` INT(10) NOT NULL AUTO_INCREMENT,
  `ano` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_anolectivo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `sgim1.1`.`authitem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgim1.1`.`authitem` (
  `name` VARCHAR(64) NOT NULL,
  `type` INT(11) NOT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `bizrule` TEXT NULL DEFAULT NULL,
  `data` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sgim1.1`.`authassignment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgim1.1`.`authassignment` (
  `itemname` VARCHAR(64) NOT NULL,
  `userid` VARCHAR(64) NOT NULL,
  `bizrule` TEXT NULL DEFAULT NULL,
  `data` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`itemname`, `userid`),
  CONSTRAINT `authassignment_ibfk_1`
    FOREIGN KEY (`itemname`)
    REFERENCES `sgim1.1`.`authitem` (`name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sgim1.1`.`authitemchild`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgim1.1`.`authitemchild` (
  `parent` VARCHAR(64) NOT NULL,
  `child` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`parent`, `child`),
  CONSTRAINT `authitemchild_ibfk_1`
    FOREIGN KEY (`parent`)
    REFERENCES `sgim1.1`.`authitem` (`name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `authitemchild_ibfk_2`
    FOREIGN KEY (`child`)
    REFERENCES `sgim1.1`.`authitem` (`name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE INDEX `child` ON `sgim1.1`.`authitemchild` (`child` ASC);


-- -----------------------------------------------------
-- Table `sgim1.1`.`avaliacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgim1.1`.`avaliacao` (
  `id_avaliacao` INT(10) NOT NULL,
  `nomesistema` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_avaliacao`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `sgim1.1`.`curso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgim1.1`.`curso` (
  `id_curso` INT(10) NOT NULL,
  `nomeCurso` VARCHAR(45) NOT NULL,
  `coordenacao` VARCHAR(40) NOT NULL,
  `numvagas` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_curso`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sgim1.1`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgim1.1`.`usuario` (
  `id_usuario` INT(10) NOT NULL AUTO_INCREMENT,
  `nomeuser` VARCHAR(15) NOT NULL,
  `senha` CHAR(50) NOT NULL,
  `nomecompleto` VARCHAR(50) NOT NULL,
  `bi` VARCHAR(14) NOT NULL DEFAULT 'Por actualizar',
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `foto` LONGBLOB NULL DEFAULT NULL,
  `sessao` TINYINT(1) NOT NULL DEFAULT '0',
  `activo` TINYINT(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_usuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sgim1.1`.`habilitacoes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgim1.1`.`habilitacoes` (
  `id_habilitacoes` INT(10) NOT NULL AUTO_INCREMENT,
  `habilita` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_habilitacoes`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `sgim1.1`.`pais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgim1.1`.`pais` (
  `id_pais` INT(10) NOT NULL,
  `nomePais` VARCHAR(45) NOT NULL,
  `nomeAbrev` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id_pais`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sgim1.1`.`provincia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgim1.1`.`provincia` (
  `id_provincia` INT(11) NOT NULL AUTO_INCREMENT,
  `nomeProvincia` VARCHAR(45) NOT NULL,
  `id_pais` INT(11) NOT NULL,
  PRIMARY KEY (`id_provincia`),
  CONSTRAINT `Reftb_pais3`
    FOREIGN KEY (`id_pais`)
    REFERENCES `sgim1.1`.`pais` (`id_pais`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE INDEX `Refځ63` ON `sgim1.1`.`provincia` (`id_pais` ASC);


-- -----------------------------------------------------
-- Table `sgim1.1`.`escolaproveniencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgim1.1`.`escolaproveniencia` (
  `id_escolaProveniencia` INT(11) NOT NULL AUTO_INCREMENT,
  `nomeEscola` VARCHAR(80) NOT NULL,
  `id_provincia` INT(11) NOT NULL,
  PRIMARY KEY (`id_escolaProveniencia`),
  CONSTRAINT `Reftb_provincia26`
    FOREIGN KEY (`id_provincia`)
    REFERENCES `sgim1.1`.`provincia` (`id_provincia`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE INDEX `Ref326` ON `sgim1.1`.`escolaproveniencia` (`id_provincia` ASC);


-- -----------------------------------------------------
-- Table `sgim1.1`.`candidatura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgim1.1`.`candidatura` (
  `num_candidatura` INT(10) NOT NULL AUTO_INCREMENT,
  `nom_candidato` VARCHAR(50) NOT NULL,
  `datainsc` DATE NOT NULL,
  `genero` VARCHAR(10) NOT NULL,
  `docident` VARCHAR(16) NOT NULL,
  `id_curso` INT(11) NOT NULL,
  `notaAcesso` DECIMAL(5,2) NULL DEFAULT NULL,
  `admitido` TINYINT(1) NULL DEFAULT NULL,
  `id_usuario` INT(11) NOT NULL,
  `regime` TINYINT(1) NOT NULL DEFAULT '0',
  `escolaproveniencia_id_escolaProveniencia` INT(11) NOT NULL,
  `habilitacoes_id_habilitacoes` INT(10) NOT NULL,
  `datacand` DATETIME NOT NULL,
  PRIMARY KEY (`num_candidatura`),
  CONSTRAINT `Reftb_curso30`
    FOREIGN KEY (`id_curso`)
    REFERENCES `sgim1.1`.`curso` (`id_curso`),
  CONSTRAINT `Reftb_usuario31`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `sgim1.1`.`usuario` (`id_usuario`),
  CONSTRAINT `fk_candidatura_habilitacoes1`
    FOREIGN KEY (`habilitacoes_id_habilitacoes`)
    REFERENCES `sgim1.1`.`habilitacoes` (`id_habilitacoes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inscricao_escolaproveniencia1`
    FOREIGN KEY (`escolaproveniencia_id_escolaProveniencia`)
    REFERENCES `sgim1.1`.`escolaproveniencia` (`id_escolaProveniencia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE INDEX `Ref1130` ON `sgim1.1`.`candidatura` (`id_curso` ASC);

CREATE INDEX `Ref1131` ON `sgim1.1`.`candidatura` (`id_usuario` ASC);

CREATE INDEX `fk_inscricao_escolaproveniencia1_idx` ON `sgim1.1`.`candidatura` (`escolaproveniencia_id_escolaProveniencia` ASC);

CREATE INDEX `fk_candidatura_habilitacoes1_idx` ON `sgim1.1`.`candidatura` (`habilitacoes_id_habilitacoes` ASC);


-- -----------------------------------------------------
-- Table `sgim1.1`.`classe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgim1.1`.`classe` (
  `numclasse` INT(10) NOT NULL,
  `descricao` VARCHAR(45) NOT NULL,
  `anolectivo_id_anolectivo` INT(10) NOT NULL,
  PRIMARY KEY (`numclasse`),
  CONSTRAINT `fk_classe_anolectivo1`
    FOREIGN KEY (`anolectivo_id_anolectivo`)
    REFERENCES `sgim1.1`.`anolectivo` (`id_anolectivo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_classe_anolectivo1_idx` ON `sgim1.1`.`classe` (`anolectivo_id_anolectivo` ASC);


-- -----------------------------------------------------
-- Table `sgim1.1`.`classe_has_anolectivo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgim1.1`.`classe_has_anolectivo` (
  `classe_numclasse` INT(11) NOT NULL,
  `anolectivo_id_anolectivo` INT(11) NOT NULL,
  PRIMARY KEY (`classe_numclasse`, `anolectivo_id_anolectivo`),
  CONSTRAINT `fk_classe_has_anolectivo_anolectivo1`
    FOREIGN KEY (`anolectivo_id_anolectivo`)
    REFERENCES `sgim1.1`.`anolectivo` (`id_anolectivo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_classe_has_anolectivo_classe1`
    FOREIGN KEY (`classe_numclasse`)
    REFERENCES `sgim1.1`.`classe` (`numclasse`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_classe_has_anolectivo_anolectivo1_idx` ON `sgim1.1`.`classe_has_anolectivo` (`anolectivo_id_anolectivo` ASC);

CREATE INDEX `fk_classe_has_anolectivo_classe1_idx` ON `sgim1.1`.`classe_has_anolectivo` (`classe_numclasse` ASC);


-- -----------------------------------------------------
-- Table `sgim1.1`.`consulcandidato`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgim1.1`.`consulcandidato` (
  `id_consulcandidato` INT(11) NOT NULL AUTO_INCREMENT,
  `nomeCand` VARCHAR(50) NULL DEFAULT NULL,
  `bi` VARCHAR(14) NOT NULL,
  `media` DECIMAL(5,2) NOT NULL,
  `user` INT(11) NOT NULL,
  `status` TINYINT(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_consulcandidato`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sgim1.1`.`consultor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgim1.1`.`consultor` (
  `id_consultor` INT(11) NOT NULL AUTO_INCREMENT,
  `nomeCand` VARCHAR(50) NULL DEFAULT NULL,
  `bi` VARCHAR(14) NOT NULL,
  `media` DECIMAL(5,2) NOT NULL,
  `user` VARCHAR(50) NOT NULL,
  `dataconsul` DATE NOT NULL,
  PRIMARY KEY (`id_consultor`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sgim1.1`.`disciplina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgim1.1`.`disciplina` (
  `id_disciplina` INT(10) NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(45) NOT NULL,
  `classe_numclasse` INT(10) NOT NULL,
  `cargahoraria` VARCHAR(10) NOT NULL,
  `avaliacao_id_avaliacao` INT(10) NOT NULL,
  `curso_id_curso` INT(10) NOT NULL,
  PRIMARY KEY (`id_disciplina`),
  CONSTRAINT `fk_disciplina_avaliacao1`
    FOREIGN KEY (`avaliacao_id_avaliacao`)
    REFERENCES `sgim1.1`.`avaliacao` (`id_avaliacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_disciplina_classe1`
    FOREIGN KEY (`classe_numclasse`)
    REFERENCES `sgim1.1`.`classe` (`numclasse`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_disciplina_curso1`
    FOREIGN KEY (`curso_id_curso`)
    REFERENCES `sgim1.1`.`curso` (`id_curso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_disciplina_classe1_idx` ON `sgim1.1`.`disciplina` (`classe_numclasse` ASC);

CREATE INDEX `fk_disciplina_avaliacao1_idx` ON `sgim1.1`.`disciplina` (`avaliacao_id_avaliacao` ASC);

CREATE INDEX `fk_disciplina_curso1_idx` ON `sgim1.1`.`disciplina` (`curso_id_curso` ASC);


-- -----------------------------------------------------
-- Table `sgim1.1`.`municipio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgim1.1`.`municipio` (
  `id_municipio` INT(10) NOT NULL AUTO_INCREMENT,
  `nomeMun` VARCHAR(45) NOT NULL,
  `id_provincia` INT(11) NOT NULL,
  PRIMARY KEY (`id_municipio`),
  CONSTRAINT `Reftb_provincia4`
    FOREIGN KEY (`id_provincia`)
    REFERENCES `sgim1.1`.`provincia` (`id_provincia`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE INDEX `Ref34` ON `sgim1.1`.`municipio` (`id_provincia` ASC);


-- -----------------------------------------------------
-- Table `sgim1.1`.`endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgim1.1`.`endereco` (
  `id_morada` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(50) NOT NULL,
  `municipio_id_municipio` INT(11) NOT NULL,
  `rua` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_morada`),
  CONSTRAINT `fk_endereco_municipio1`
    FOREIGN KEY (`municipio_id_municipio`)
    REFERENCES `sgim1.1`.`municipio` (`id_municipio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE UNIQUE INDEX `id_morada` ON `sgim1.1`.`endereco` (`id_morada` ASC);

CREATE INDEX `fk_endereco_municipio1_idx` ON `sgim1.1`.`endereco` (`municipio_id_municipio` ASC);


-- -----------------------------------------------------
-- Table `sgim1.1`.`estado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgim1.1`.`estado` (
  `id_estado` INT(10) NOT NULL,
  `descricao` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_estado`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `sgim1.1`.`estudante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgim1.1`.`estudante` (
  `matricula` INT(10) NOT NULL AUTO_INCREMENT,
  `nomeCompleto` VARCHAR(60) NOT NULL,
  `dataNasc` DATE NOT NULL,
  `docident` VARCHAR(45) NOT NULL,
  `identnum` VARCHAR(16) NOT NULL,
  `nompai` VARCHAR(60) NOT NULL,
  `nommae` VARCHAR(60) NOT NULL,
  `genero` CHAR(1) NOT NULL,
  `regime` CHAR(1) NOT NULL,
  `foto` LONGBLOB NULL DEFAULT NULL,
  `curso_id_curso` INT(10) NOT NULL,
  PRIMARY KEY (`matricula`),
  CONSTRAINT `fk_estudante_curso1`
    FOREIGN KEY (`curso_id_curso`)
    REFERENCES `sgim1.1`.`curso` (`id_curso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE INDEX `fk_estudante_curso1_idx` ON `sgim1.1`.`estudante` (`curso_id_curso` ASC);


-- -----------------------------------------------------
-- Table `sgim1.1`.`turma`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgim1.1`.`turma` (
  `numturma` INT(10) NOT NULL,
  `descricao` VARCHAR(15) NOT NULL,
  `sala` VARCHAR(5) NOT NULL,
  `turno` TINYBLOB NOT NULL,
  `classe_numclasse` INT(10) NOT NULL,
  `anolectivo_id_anolectivo` INT(10) NOT NULL,
  PRIMARY KEY (`numturma`),
  CONSTRAINT `fk_turma_anolectivo1`
    FOREIGN KEY (`anolectivo_id_anolectivo`)
    REFERENCES `sgim1.1`.`anolectivo` (`id_anolectivo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_turma_classe1`
    FOREIGN KEY (`classe_numclasse`)
    REFERENCES `sgim1.1`.`classe` (`numclasse`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_turma_classe1_idx` ON `sgim1.1`.`turma` (`classe_numclasse` ASC);

CREATE INDEX `fk_turma_anolectivo1_idx` ON `sgim1.1`.`turma` (`anolectivo_id_anolectivo` ASC);


-- -----------------------------------------------------
-- Table `sgim1.1`.`estudante_has_turma`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgim1.1`.`estudante_has_turma` (
  `estudante_matricula` INT(10) NOT NULL,
  `turma_numturma` INT(10) NOT NULL,
  PRIMARY KEY (`estudante_matricula`, `turma_numturma`),
  CONSTRAINT `fk_estudante_has_turma_estudante1`
    FOREIGN KEY (`estudante_matricula`)
    REFERENCES `sgim1.1`.`estudante` (`matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_estudante_has_turma_turma1`
    FOREIGN KEY (`turma_numturma`)
    REFERENCES `sgim1.1`.`turma` (`numturma`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE INDEX `fk_estudante_has_turma_turma1_idx` ON `sgim1.1`.`estudante_has_turma` (`turma_numturma` ASC);

CREATE INDEX `fk_estudante_has_turma_estudante1_idx` ON `sgim1.1`.`estudante_has_turma` (`estudante_matricula` ASC);


-- -----------------------------------------------------
-- Table `sgim1.1`.`historicoacademico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgim1.1`.`historicoacademico` (
  `id_historicoacademico` INT(11) NOT NULL,
  `turma_numturma` INT(10) NOT NULL,
  `classe_numclasse` INT(10) NOT NULL,
  `anolectivo_id_anolectivo` INT(10) NOT NULL,
  `estudante_matricula` INT(10) NOT NULL,
  `estado_id_estado` INT(10) NOT NULL,
  PRIMARY KEY (`id_historicoacademico`),
  CONSTRAINT `fk_historicoacademico_anolectivo1`
    FOREIGN KEY (`anolectivo_id_anolectivo`)
    REFERENCES `sgim1.1`.`anolectivo` (`id_anolectivo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_historicoacademico_classe1`
    FOREIGN KEY (`classe_numclasse`)
    REFERENCES `sgim1.1`.`classe` (`numclasse`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_historicoacademico_estado1`
    FOREIGN KEY (`estado_id_estado`)
    REFERENCES `sgim1.1`.`estado` (`id_estado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_historicoacademico_estudante1`
    FOREIGN KEY (`estudante_matricula`)
    REFERENCES `sgim1.1`.`estudante` (`matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_historicoacademico_turma1`
    FOREIGN KEY (`turma_numturma`)
    REFERENCES `sgim1.1`.`turma` (`numturma`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_historicoacademico_turma1_idx` ON `sgim1.1`.`historicoacademico` (`turma_numturma` ASC);

CREATE INDEX `fk_historicoacademico_classe1_idx` ON `sgim1.1`.`historicoacademico` (`classe_numclasse` ASC);

CREATE INDEX `fk_historicoacademico_estudante1_idx` ON `sgim1.1`.`historicoacademico` (`estudante_matricula` ASC);

CREATE INDEX `fk_historicoacademico_anolectivo1_idx` ON `sgim1.1`.`historicoacademico` (`anolectivo_id_anolectivo` ASC);

CREATE INDEX `fk_historicoacademico_estado1_idx` ON `sgim1.1`.`historicoacademico` (`estado_id_estado` ASC);


-- -----------------------------------------------------
-- Table `sgim1.1`.`instituicao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgim1.1`.`instituicao` (
  `id_instituicao` INT(10) NOT NULL AUTO_INCREMENT,
  `nomeInst` VARCHAR(45) NOT NULL,
  `nomeDG` VARCHAR(45) NULL DEFAULT NULL,
  `nomeDAdm` VARCHAR(45) NULL DEFAULT NULL,
  `nomeDPed` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_instituicao`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sgim1.1`.`trimestre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgim1.1`.`trimestre` (
  `numtrimestre` INT(10) NOT NULL,
  `descricao` VARCHAR(45) NOT NULL,
  `classe_has_anolectivo1_classe_numclasse` INT(10) NOT NULL,
  `classe_has_anolectivo1_anolectivo_id_anolectivo` INT(10) NOT NULL,
  PRIMARY KEY (`numtrimestre`, `classe_has_anolectivo1_classe_numclasse`, `classe_has_anolectivo1_anolectivo_id_anolectivo`),
  CONSTRAINT `fk_trimestre_classe_has_anolectivo11`
    FOREIGN KEY (`classe_has_anolectivo1_classe_numclasse` , `classe_has_anolectivo1_anolectivo_id_anolectivo`)
    REFERENCES `sgim1.1`.`classe_has_anolectivo1` (`classe_numclasse` , `anolectivo_id_anolectivo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_trimestre_classe_has_anolectivo11_idx` ON `sgim1.1`.`trimestre` (`classe_has_anolectivo1_classe_numclasse` ASC, `classe_has_anolectivo1_anolectivo_id_anolectivo` ASC);


-- -----------------------------------------------------
-- Table `sgim1.1`.`pautas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgim1.1`.`pautas` (
  `id_pautas` INT(10) NOT NULL,
  `numpresencas` BIT(2) NULL DEFAULT NULL,
  `numausencias` BIT(2) NULL DEFAULT NULL,
  `disciplina_id_disciplina` INT(10) NOT NULL,
  `turma_numturma` INT(10) NOT NULL,
  `classe_numclasse` INT(10) NOT NULL,
  `trimestre_numtrimestre` INT(10) NOT NULL,
  `trimestre_classe_has_anolectivo1_classe_numclasse` INT(10) NOT NULL,
  `trimestre_classe_has_anolectivo1_anolectivo_id_anolectivo` INT(10) NOT NULL,
  `estudante_matricula` INT(10) NOT NULL,
  `MAC` FLOAT NOT NULL,
  `CPP` FLOAT NOT NULL,
  `CAP` FLOAT NOT NULL,
  `CPE` FLOAT NOT NULL,
  `CF` FLOAT NOT NULL,
  PRIMARY KEY (`id_pautas`),
  CONSTRAINT `fk_pautas_classe1`
    FOREIGN KEY (`classe_numclasse`)
    REFERENCES `sgim1.1`.`classe` (`numclasse`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pautas_disciplina1`
    FOREIGN KEY (`disciplina_id_disciplina`)
    REFERENCES `sgim1.1`.`disciplina` (`id_disciplina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pautas_estudante1`
    FOREIGN KEY (`estudante_matricula`)
    REFERENCES `sgim1.1`.`estudante` (`matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pautas_trimestre1`
    FOREIGN KEY (`trimestre_numtrimestre` , `trimestre_classe_has_anolectivo1_classe_numclasse` , `trimestre_classe_has_anolectivo1_anolectivo_id_anolectivo`)
    REFERENCES `sgim1.1`.`trimestre` (`numtrimestre` , `classe_has_anolectivo1_classe_numclasse` , `classe_has_anolectivo1_anolectivo_id_anolectivo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pautas_turma1`
    FOREIGN KEY (`turma_numturma`)
    REFERENCES `sgim1.1`.`turma` (`numturma`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_pautas_disciplina1_idx` ON `sgim1.1`.`pautas` (`disciplina_id_disciplina` ASC);

CREATE INDEX `fk_pautas_turma1_idx` ON `sgim1.1`.`pautas` (`turma_numturma` ASC);

CREATE INDEX `fk_pautas_classe1_idx` ON `sgim1.1`.`pautas` (`classe_numclasse` ASC);

CREATE INDEX `fk_pautas_trimestre1_idx` ON `sgim1.1`.`pautas` (`trimestre_numtrimestre` ASC, `trimestre_classe_has_anolectivo1_classe_numclasse` ASC, `trimestre_classe_has_anolectivo1_anolectivo_id_anolectivo` ASC);

CREATE INDEX `fk_pautas_estudante1_idx` ON `sgim1.1`.`pautas` (`estudante_matricula` ASC);


-- -----------------------------------------------------
-- Table `sgim1.1`.`reconfirmacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgim1.1`.`reconfirmacao` (
  `Id_reconfirmacao` INT(10) NOT NULL AUTO_INCREMENT,
  `anoFrequencia` VARCHAR(10) NOT NULL,
  `dataRec` DATE NOT NULL,
  `usuario_id_usuario` INT(10) NOT NULL,
  `curso_id_curso` INT(10) NOT NULL,
  `estudante_matricula` INT(10) NOT NULL,
  PRIMARY KEY (`Id_reconfirmacao`),
  CONSTRAINT `fk_reconfirmacao_curso1`
    FOREIGN KEY (`curso_id_curso`)
    REFERENCES `sgim1.1`.`curso` (`id_curso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reconfirmacao_estudante1`
    FOREIGN KEY (`estudante_matricula`)
    REFERENCES `sgim1.1`.`estudante` (`matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reconfirmacao_usuario1`
    FOREIGN KEY (`usuario_id_usuario`)
    REFERENCES `sgim1.1`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE INDEX `fk_reconfirmacao_usuario1_idx` ON `sgim1.1`.`reconfirmacao` (`usuario_id_usuario` ASC);

CREATE INDEX `fk_reconfirmacao_curso1_idx` ON `sgim1.1`.`reconfirmacao` (`curso_id_curso` ASC);

CREATE INDEX `fk_reconfirmacao_estudante1_idx` ON `sgim1.1`.`reconfirmacao` (`estudante_matricula` ASC);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
