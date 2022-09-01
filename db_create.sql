-- GROUPE 1 classe C

-- •    Dolo Clément 21807057
-- •    Bergon Thomas 21911767
-- •    Bouallouche Yanis 21914125
-- •    Benfouga Ryan 21908769

CREATE SCHEMA IF NOT EXISTS `commissariat` DEFAULT CHARACTER SET utf8 ;
USE `commissariat` ;

-- Table PERSONNE
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `commissariat`.`PERSONNE` (
  `idPers` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL DEFAULT NULL,
  `prenom` VARCHAR(45) NULL DEFAULT NULL,
  `sexe` VARCHAR(45) NULL DEFAULT NULL,
  `dateNaissance` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idPers`))
ENGINE = InnoDB;


-- Table POLICIER
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `commissariat`.`POLICIER` (
  `idPol` INT NOT NULL,
  `salaire` DOUBLE NULL DEFAULT NULL,
  `specialite` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idPol`),
  CONSTRAINT `fk_POLICIER_1`
    FOREIGN KEY (`idPol`)
    REFERENCES `commissariat`.`PERSONNE` (`idPers`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- Table CIVIL
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `commissariat`.`CIVIL` (
  `idCiv` INT NOT NULL,
  PRIMARY KEY (`idCiv`),
  CONSTRAINT `fk_CIVIL_1`
    FOREIGN KEY (`idCiv`)
    REFERENCES `commissariat`.`PERSONNE` (`idPers`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- Table AFFAIRE
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `commissariat`.`AFFAIRE` (
  `idAff` INT NOT NULL AUTO_INCREMENT,
  `statut` ENUM ('en cours', 'classée', 'sans suite'),
  `rapport` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idAff`))
ENGINE = InnoDB;


-- Table PIECES_A_CONVICTION
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `commissariat`.`PIECES_A_CONVICTION` (
  `idPAC` INT NOT NULL AUTO_INCREMENT,
  `idCiv` INT NULL DEFAULT NULL,
  `idAff` INT NULL DEFAULT NULL,
  `nomPiece` VARCHAR(45) NULL DEFAULT NULL,
  `quantite` DOUBLE NULL DEFAULT NULL,
  PRIMARY KEY (`idPAC`),
  INDEX `fk_PIECES_A_CONVICTION_1` (`idCiv` ASC),
  INDEX `fk_PIECES_A_CONVICTION_2` (`idAff` ASC),
  CONSTRAINT `fk_PIECES_A_CONVICTION_1`
    FOREIGN KEY (`idCiv`)
    REFERENCES `commissariat`.`CIVIL` (`idCiv`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_PIECES_A_CONVICTION_2`
    FOREIGN KEY (`idAff`)
    REFERENCES `commissariat`.`AFFAIRE` (`idAff`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- Table IMPLIQUE
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `commissariat`.`IMPLIQUE` (
  `idCiv` INT NOT NULL,
  `idAff` INT NOT NULL,
  `role` ENUM ('victime','témoin','suspect'),
  PRIMARY KEY (`idCiv`, `idAff`),
  INDEX `fk_IMPLIQUE_2` (`idAff` ASC),
  CONSTRAINT `fk_IMPLIQUE_1`
    FOREIGN KEY (`idCiv`)
    REFERENCES `commissariat`.`CIVIL` (`idCiv`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_IMPLIQUE_2`
    FOREIGN KEY (`idAff`)
    REFERENCES `commissariat`.`AFFAIRE` (`idAff`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- Table ENQUETE
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `commissariat`.`ENQUETE` (
  `idPol` INT NOT NULL,
  `idAff` INT NOT NULL,
  PRIMARY KEY (`idPol`, `idAff`),
  INDEX `fk_ENQUETE_2` (`idAff` ASC),
  CONSTRAINT `fk_ENQUETE_1`
    FOREIGN KEY (`idPol`)
    REFERENCES `commissariat`.`POLICIER` (`idPol`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_ENQUETE_2`
    FOREIGN KEY (`idAff`)
    REFERENCES `commissariat`.`AFFAIRE` (`idAff`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- Table GARDE_A_VUE
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `commissariat`.`GARDE_A_VUE` (
  `numCellule` INT NOT NULL,
  `motif` LONGTEXT NULL DEFAULT NULL,
  `debut` DATE NULL DEFAULT NULL,
  `fin` DATE NULL DEFAULT NULL,
  `idCiv` INT NULL DEFAULT NULL,
  PRIMARY KEY (`numCellule`),
  INDEX `fk_GARDE_A_VUE_1` (`idCiv` ASC),
  CONSTRAINT `fk_GARDE_A_VUE_1`
    FOREIGN KEY (`idCiv`)
    REFERENCES `commissariat`.`CIVIL` (`idCiv`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- Table GRADES
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `commissariat`.`GRADES` (
  `nom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`nom`))
ENGINE = InnoDB;


-- Table NOMME
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `commissariat`.`NOMME` (
  `idPol` INT NOT NULL,
  `nomGrad` VARCHAR(45) NOT NULL,
  `datePromotion` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`idPol`, `nomGrad`),
  INDEX `fk_NOMME_2` (`nomGrad` ASC),
  CONSTRAINT `fk_NOMME_1`
    FOREIGN KEY (`idPol`)
    REFERENCES `commissariat`.`POLICIER` (`idPol`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_NOMME_2`
    FOREIGN KEY (`nomGrad`)
    REFERENCES `commissariat`.`GRADES` (`nom`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

INSERT INTO GRADES (nom) VALUES
    ('Cadet'),
    ('Gardien de la paix'),
    ('Brigadier'),
    ('Major'),
    ('Lieutenant'),
    ('Capitaine'),
    ('Commandant'),
    ('Commissaire');

INSERT INTO PERSONNE (nom, prenom, sexe, dateNaissance) VALUES
    ("Garnier", "Lucille", "F", "1984-03-09"),
    ("Normand", "Lafrenière", "H", "1987-08-16"),
    ("Clementine", "Varieur", "F", "1977-05-15"),
    ("Eliot", "Faubert", "H", "1991-10-25"),
    ("Lance", "Caya", "H", "1969-09-28"),
    ("Tristan", "David", "H", "1986-12-17"),
    ("Emmanuel", "Gareau", "H", "1974-04-21"),
    ("Valentine", "Lacroix", "F", "1998-05-08"),
    ("Martin", "Ailleboust", "H", "2000-03-30"),
    ("Isabelle", "Duval", "F", "1968-09-25");

INSERT INTO POLICIER (idPol, salaire, specialite) VALUES
    (10, 1500, "Maître-chien"),
    (5, 1600, "Motocycliste"),
    (3, 1500, "Motocycliste"),
    (2, 1400, "Négociateur"),
    (7, 1500, "Opérationnel"),
    (8, 1450, "Opérationnel");

-- REAL DATES AFTER TRIGGER
UPDATE NOMME
    SET datePromotion = "1987-09-04"
    WHERE idPol = 10;

UPDATE NOMME
    SET datePromotion = "1992-12-23"
    WHERE idPol = 5;

UPDATE NOMME
    SET datePromotion = "2001-07-05"
    WHERE idPol = 3;

UPDATE NOMME
    SET datePromotion = "2008-09-12"
    WHERE idPol = 2;

UPDATE NOMME
    SET datePromotion = "2009-09-02"
    WHERE idPol = 7;

UPDATE NOMME
    SET datePromotion = "2020-02-25"
    WHERE idPol = 8;

INSERT INTO NOMME (idPol, nomGrad, datePromotion) VALUES
    (10, "Gardien de la paix", "1988-09-04"),
    (10, "Brigadier", "1991-09-04"),
    (10, "Major", "1993-09-04"),
    (10, "Lieutenant", "1996-09-04"),
    (10, "Capitaine", "1999-09-04"),
    (10, "Commandant", "2004-09-04"),
    (10, "Commissaire", "2011-09-04"),
    (5, "Gardien de la paix", "1993-12-23"),
    (5, "Brigadier", "1996-12-23"),
    (5, "Major", "1999-12-23"),
    (5, "Lieutenant", "2004-12-23"),
    (5, "Capitaine", "2015-12-23"),
    (3, "Gardien de la paix", "2003-07-05"),
    (3, "Brigadier", "2005-07-05"),
    (3, "Major", "2013-07-05"),
    (3, "Lieutenant", "2018-07-05"),
    (2, "Gardien de la paix", "2009-09-12"),
    (2, "Brigadier", "2011-09-12"),
    (2, "Major", "2015-09-12"),
    (7, "Gardien de la paix", "2011-09-02"),
    (7, "Brigadier", "2014-09-02"),
    (7, "Major", "2017-09-02"),
    (8, "Gardien de la paix", "2021-02-25");

INSERT INTO CIVIL (idCiv) VALUES
    (1),
    (4),
    (6),
    (9);

INSERT INTO AFFAIRE (statut, rapport) VALUES
    ("en cours", "r1.pdf"),
    ("en cours", "r2.pdf"),
    ("en cours", "r3.pdf"),
    ("classée", "r4.pdf"),
    ("classée", "r5.pdf"),
    ("sans suite", "r6.pdf"),
    ("sans suite", "r7.pdf"),
    ("en cours", "r8.pdf");

INSERT INTO ENQUETE (idAff,idPol) VALUES
    (1,5),
    (2,2),
    (2,5),
    (3,7),
    (8,7),
    (8,8);

INSERT INTO GARDE_A_VUE (debut, fin,idCiv,motif,numCellule) VALUES
  ("2021-12-20","2021-12-21",1,"Interrogation pour vol",2),
  ("2021-12-20","2021-12-21",4,"Empêcher la destruction d'indices",5);

INSERT INTO IMPLIQUE(idCiv,idAff,role) VALUES
  (4,8,"suspect"),
  (4,7,"suspect");

DELIMITER $$

  CREATE FUNCTION nb_gav_an (anne INTEGER) RETURNS INTEGER
  NOT DETERMINISTIC READS SQL DATA
  BEGIN
      declare num INTEGER;
      SELECT count(*)
      INTO num FROM GARDE_A_VUE
      WHERE YEAR(debut) = anne;
      RETURN num;
  END$$

  CREATE TRIGGER verif_update_cellule
      BEFORE  UPDATE ON GARDE_A_VUE
      FOR EACH ROW
      BEGIN
      IF new.numCellule > 12
          THEN signal sqlstate '46000' set message_text = 'Respectez le numero de cellule (max 12)';
      ELSEIF old.fin IS NULL
          THEN signal sqlstate '45000' set message_text = 'La cellule est occupé';
      END IF;
  END$$

  CREATE TRIGGER verif_insert_cellule
      BEFORE INSERT ON GARDE_A_VUE
      FOR EACH ROW
      BEGIN
      IF new.numCellule > 12
          THEN signal sqlstate '46000' set message_text = 'Respectez le numero de cellule (max 12)';
      END IF;
  END$$

  -- Insère la "promotion" du policier dans la table nomme, lors de son recrutement.
  CREATE TRIGGER log_first_grade
      AFTER INSERT
      ON POLICIER FOR EACH ROW
      BEGIN
          INSERT INTO NOMME(idPol, nomGrad, datePromotion)
          VALUES(new.idPol, 'Cadet', current_date());
  END$$

  CREATE PROCEDURE policier_from_grade(IN grade VARCHAR(45))
    BEGIN
      SELECT nom,prenom 
      FROM PERSONNE P, POLICIER PO, NOMME N
      WHERE N.idPol=PO.idPol 
      AND PO.idPol=P.idPers 
      AND N.nomGrad=grade
      AND datePromotion IN (SELECT MAX(datePromotion) FROM NOMME GROUP BY idPol);
    END$$

DELIMITER ;
