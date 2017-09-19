-- TP3: Gestion des exceptions

-- Q1:
CREATE OR REPLACE PROCEDURE ajoutConcert (pIdConcert Concert.idConcert%TYPE, pNomConcert Concert.nomConcert%TYPE, pLieuConcert Concert.lieuConcert%TYPE, pDateConcert Concert.dateConcert%TYPE, pNomArtiste Artiste.nomArtiste%TYPE, pPrenomArtiste Artiste.prenomArtiste%TYPE) AS vNbConcert NUMBER:=0;

vIdArtiste Artiste.idArtiste%TYPE;

DISCRIMINATION_EXCEPTION EXCEPTION;

BEGIN -- Obtention de l'idArtiste pour travailler plus simplement

SELECT idArtiste INTO vIdArtiste
FROM Artiste
WHERE prenomArtiste = pPrenomArtiste
  AND nomArtiste = pNomArtiste;

SELECT COUNT(Chanson.idChanson) INTO vNombreChansonArtiste
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
  AND anneeAlbum < to_number(to_char(to_date(pDateConcert),'YYYY'));


SELECT count(*) INTO vNbConcert
FROM Concert;

DBMS_output.put_line('Nombre de concert(s) enregistré(s) dans la table: ' || vNbConcert);

IF vNombreChansonArtiste = 0 THEN RAISE DISCRIMINATION_EXCEPTION END IF;

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

EXCEPTION
-- 1 gestion NO_DATA_FOUND
WHEN NO_DATA_FOUND THEN DBMS_output.put_line('nomArtiste ou prenomArtiste inexistant.');
-- 2 gestion du DUP_VAL_ON_INDEX
WHEN DUP_VAL_ON_INDEX THEN DBMS_output.put_line('Identifiant de concert (idConcert) déjà existant!');
-- 3 gestion du nombre de chanson de l'artiste
WHEN DISCRIMINATION_EXCEPTION THEN DBMS_output.put_line('Mec wtf tu peux pas faire de concert sans avoir de chanson!');

END;

-- Q2

CREATE OR REPLACE PROCEDURE MAJPiste (pIdPiste Piste.idPiste%TYPE, pNoPiste Piste.noPiste%TYPE) IS

NUM_PISTE_EXISTANT EXCEPTION;
NUM_PISTE_INVALIDE EXCEPTION;
PRAGMA EXCEPTION_INIT(NUM_PISTE_INVALIDE, -2290);
vNumPiste NUMBER:=0;
vTitreAlbum Album.titreAlbum%TYPE;
vTitreChanson Chanson.titreChanson%TYPE;

BEGIN

-- test du numéro de la piste

SELECT COUNT(*) INTO vNumPiste
FROM Piste P1, Piste P2, Album A
WHERE P1.idPiste = pIdPiste
AND P1.idAlbum = A.idAlbum
AND P2.idAlbum = P1.idAlbum
AND P2.noPiste = pNoPiste;

IF vNumPiste > 0
THEN RAISE NUM_PISTE_EXISTANT;
END IF;

SELECT titreAlbum AS "Titre album",
       titreChanson AS "Titre chanson" INTO vTitreAlbum,
                                            vTitreChanson
FROM Album A,
     Piste P,
     Chanson C
WHERE P.idPiste = pIdPiste
  AND P.idAlbum = A.idAlbum
  AND P.idChanson = C.idChanson;

-- maj du numéro de la piste:

  UPDATE Piste
  SET noPiste = pNoPiste WHERE idPiste = pIdPiste;


EXCEPTION
-- 1 Piste.idPiste inexistant
 WHEN NO_DATA_FOUND THEN DBMS_output.put_line('idPiste inexistant!');

-- 2 Piste déjà utilisé
 WHEN NUM_PISTE_EXISTANT THEN DBMS_output.put_line('Le numéro de piste ' || pNoPiste || ' est déjà utilisé!');

-- 3 Piste entre 1 et 40
WHEN NUM_PISTE_INVALIDE THEN DBMS_output.put_line('Le numéro de piste ' || pNoPiste || ' doit être compris entre 1 et 40!');
END;


-- Q3

CREATE OR REPLACE PROCEDURE AjoutChanson(pIdChanson Chanson.idChanson%TYPE, pTitreChanson Chanson.titreChanson%TYPE, pAnneeChanson Chanson.anneeChanson%TYPE, pIdAuteur Chanson.idAuteur%TYPE, pIdCompositeur Chanson.idCompositeur%TYPE) IS

EXCEPTION_CLE_ETRANGERE EXCEPTION;
PRAGMA EXCEPTION_INIT(EXCEPTION_CLE_ETRANGERE, -2290);

EXCEPTION_PARAM_NULL EXCEPTION;
PRAGMA EXCEPTION_INIT(EXCEPTION_PARAM_NULL, -2291);

BEGIN
INSERT INTO Chanson
(idChanson, titreChanson, anneeChanson, idAuteur, idCompositeur)
VALUES
(pIdChanson, pTitreChanson, pAnneeChanson, pIdAuteur, pIdCompositeur);

EXCEPTION

WHEN DUP_VAL_ON_INDEX THEN DBMS_OUTPUT.PUT_LINE('Identifiant de chanson déjà existant');

WHEN EXCEPTION_CLE_ETRANGERE THEN
IF sqlerrm LIKE '%(fk_chanson_auteur)%'
THEN DBMS_output.put_line('L''ID auteur rentré (' || pIdAuteur || ') n''existe pas veuillez entrer un idAuteur connu.');
  ELSIF sqlerrm LIKE '%(fk_chanson_compositeur)%'
  THEN DBMS_output.put_line('L''ID compositeur rentré (' || pIdCompositeur || ') n''existe pas veuillez entrer un idCompositeur connu.');
END IF;

WHEN EXCEPTION_PARAM_NULL THEN
  IF sqlerrm LIKE '%(nn_titreChanson)%'
  THEN DBMS_output.put_line('Le titre de chanson ne peux pas être vide!');
  ELSIF sqlerrm LIKE '%(nn_idAuteur)%'
    THEN DBMS_output.put_line('Il faut préciser un ID auteur!');
      ELSIF sqlerrm LIKE '%(nn_idCompositeur)%'
        THEN DBMS_output.put_line('Il faut préciser un ID compositeur!');
END IF;
WHEN OTHERS THEN DBMS_output.put_line('smdfkùqsmlfkm' || sqlerrm || sqlcode);
END;
