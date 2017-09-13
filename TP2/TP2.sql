-- TP2 Procédures PL/SQL : gestion des curseurs --

SET SERVEROUTPUT ON;

-- Q1

CREATE OR REPLACE PROCEDURE ajoutConcert (pIdConcert Concert.idConcert%TYPE, pNomConcert Concert.nomConcert%TYPE, pLieuConcert Concert.lieuConcert%TYPE, pDateConcert Concert.dateConcert%TYPE, pNomArtiste Artiste.nomArtiste%TYPE, pPrenomArtiste Artiste.prenomArtiste%TYPE) AS vNbConcert NUMBER:=0;

vIdArtiste Artiste.idArtiste%TYPE;

BEGIN
SELECT count(*) INTO vNbConcert
FROM Concert;

DBMS_output.put_line('Nombre de concert(s) enregistré(s) dans la table: ' || vNbConcert);

-- Obtention de l'idArtiste pour travailler plus simplement

SELECT idArtiste INTO vIdArtiste
FROM Artiste
WHERE prenomArtiste = pPrenomArtiste
  AND nomArtiste = pNomArtiste;

-- Création du concert

INSERT INTO Concert
VALUES (pIdConcert,
        pNomConcert,
        pLieuConcert,
        pDateConcert);


FOR c1_ligne IN
  ( SELECT Chanson.idChanson
   FROM Artiste,
        Interpreter,
        Piste,
        Album,
        Chanson
   WHERE Artiste.idArtiste = vIdArtiste
     AND Interpreter.idArtiste = Artiste.idArtiste
     AND Interpreter.idPiste = Piste.idPiste
     AND Piste.idAlbum = Album.idAlbum
     AND chanson.idChanson = piste.idChanson
     AND anneeAlbum < to_number(to_char(to_date(pDateConcert),'YYYY')) ) LOOP
INSERT INTO InterpreterEnConcert
VALUES (pIdConcert,
        c1_ligne.idChanson,
        vIdArtiste);

END LOOP;


END;

-- Q2

CREATE OR REPLACE FUNCTION dureeAlbum(ptitreAlbum ALBUM.titreAlbum%TYPE) RETURN number IS DureeTotal NUMBER:=0;

BEGIN
FOR c1_ligne IN
  (SELECT duree
   FROM Piste,
        Album
   WHERE Piste.idAlbum = Album.idAlbum
     AND Album.titreAlbum LIKE ptitreAlbum) LOOP DureeTotal := DureeTotal + c1_ligne.duree;

END LOOP;

RETURN DureeTotal;

END;

-- Q3

-- En utilisant la fonction de la question 2
SELECT titreAlbum AS Titre,
       dureeAlbum(titreAlbum) AS Durée
FROM Album;
-- Sans la fonction de la question 2
SELECT titreAlbum AS Titre,
       SUM(duree) AS Durée
FROM Album A,
     Piste P
WHERE A.idAlbum = P.idAlbum
GROUP BY titreAlbum;

-- Q4

CREATE OR REPLACE PROCEDURE MAJPiste (pIdPiste Piste.idPiste%TYPE, pNoPiste Piste.noPiste%TYPE) IS

BEGIN
SELECT titreAlbum AS "Titre album",
       titreChanson AS "Titre chanson"
FROM Album A,
     Piste P,
     Chanson C
WHERE P.idPiste = pIdPiste
  AND P.idAlbum = A.idAlbum
  AND P.idChanson = C.idChanson;

-- maj du numéro de la piste:

  UPDATE Piste
  SET noPiste = pNoPiste WHERE idPiste = pIdPiste;

END;
