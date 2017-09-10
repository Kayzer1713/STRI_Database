CREATE OR REPLACE PROCEDURE ajoutConcert (pIdConcert Concert.idConcert%TYPE, pNomConcert Concert.nomConcert%TYPE, pLieuConcert Concert.lieuConcert%TYPE, pDateConcert Concert.dateConcert%TYPE, pNomArtiste Artiste.nomArtiste%TYPE, pPrenomArtiste Artiste.prenomArtiste%TYPE) AS vNbConcert NUMBER:=0;

vIdArtiste Artiste.idArtiste%TYPE;

BEGIN
SELECT count(*) INTO vNbConcert
FROM Concert;

DBMS_output.put_line('Nombre de concert(s) enregistr?(s) dans la table: ' || vNbConcert);

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
SELECT Chanson.idChanson
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
  AND anneeAlbum < to_number(to_char(to_date(pDateConcert),'YYYY'))

) LOOP INSERT INTO InterpreterEnConcert VALUES (pIdConcert, c1_ligne.idChanson,vIdArtiste);

END LOOP;

-- récupérer l'année d'une date: to_number(to_char(to_date('JJ/MM/YYYY'),'YYYY'))
 END;