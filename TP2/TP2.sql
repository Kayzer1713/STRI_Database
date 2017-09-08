-- TP2 Procédures PL/SQL : gestion des curseurs --

SET SERVEROUTPUT ON;

 -- Q1
CREATE OR REPLACE PROCEDURE ajoutConcert (pIdConcert Concert.idConcert%TYPE,
                            pNomConcert Concert.nomConcert%TYPE,
                            pLieuConcert Concert.lieuConcert%TYPE,
                            pDateConcert Concert.dateConcert%TYPE,
                            pNomArtiste Artiste.nomArtiste%TYPE,
                            pPrenomArtiste Artiste.prenomArtiste%TYPE) AS
vNbConcert NUMBER:=0;
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


FOR c1_ligne IN (
SELECT *
FROM Artiste,
     Interpreter,
     Piste,
     Album
WHERE Artiste.idArtiste = vIdArtiste
  AND Interpreter.idArtiste = Artiste.idArtiste
  AND Interpreter.idPiste = Piste.idPiste
  AND Piste.idAlbum = Album.idAlbum
  AND ANNEEALBUM < pDateConcert;

) LOOP END LOOP;
-- récupèrer l'année d'une date: to_number(to_char(to_date(‘JJ/MM/YYYY’),’YYYY’))

END; /


SELECT *
FROM Artiste, Interpreter, Piste, Album
WHERE Artiste.idArtiste = 1
AND Interpreter.idArtiste = Artiste.idArtiste
AND Interpreter.idPiste = Piste.idPiste
AND Piste.idAlbum = Album.idAlbum
AND EXTRACT(YEAR FROM
   TO_DATE('1998-03-07', 'DD-MON-RR')) < 2010;
