-- POLICIER nom prenom grade et date optention du grade
SELECT PERSONNE.nom as nom ,PERSONNE.prenom as prenom , NOMME.nomGrad as Grade ,NOMME.datePromotion as date_derniere_Promotion
FROM PERSONNE,POLICIER P ,NOMME inner join(SELECT idpol ,max(datePromotion) as maxdate FROM NOMME GROUP BY idpol) N
WHERE PERSONNE.idPers= P.idpol and P.idpol=NOMME.idpol and P.idpol=N.idpol and NOMME.datePromotion=n.maxdate;

-- POLICIER qui ENQUETE et le numDossier
SELECT PERSONNE.prenom, PERSONNE.nom, AFFAIRE.statut, AFFAIRE.idAff
FROM POLICIER, ENQUETE, AFFAIRE, PERSONNE
WHERE POLICIER.idPol = PERSONNE.idPers AND ENQUETE.idAff = AFFAIRE.idAff AND ENQUETE.idPol = POLICIER.idPol;

-- Civil
SELECT *
FROM personne
WHERE personne.idPers not in (SELECT idpol from policier);

-- poucentage de cellule occupée
SELECT (COUNT(*)/12*100) as '% de cellule utilisée le 20 décembre 2021'
FROM GARDE_A_VUE
WHERE "2021-12-20"<fin;

-- nom et prenom des recidivistes
SELECT nom , prenom
from PERSONNE
where idPers in (
  SELECT idCiv
  from (
    SELECT idCiv, COUNT(*) as nb
    from IMPLIQUE
    where role="suspect" group by idCiv) a
  where a.nb>1);

SELECT "TEST TRIGGERS, FONCTION, PROCEDURE";
INSERT INTO GARDE_A_VUE (debut, fin,idCiv,motif,numCellule) VALUES ("2021-12-20", NULL ,1,"Interrogation pour vol",22);
INSERT INTO GARDE_A_VUE (debut, fin,idCiv,motif,numCellule) VALUES ("2021-12-20", NULL ,1,"Interrogation pour vol",12);
UPDATE GARDE_A_VUE SET idCiv=3, motif="mauvais comportement" WHERE numCellule = 12;

SELECT nb_gav_an(2021)
;

INSERT INTO POLICIER (idPol, salaire, specialite) VALUES (4, 1500, "Maître-chien");
SELECT nomGrad, nom, prenom FROM NOMME, PERSONNE WHERE idPol = 4 AND idPers = 4;


CALL policier_from_grade("Major");
CALL policier_from_grade("Lieutenant");