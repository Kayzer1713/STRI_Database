-- TP4

-- Q1

Un paquetage est un ensemble de procédures et fonctions regroupées dans un objet nommé
Paquetage : Ensemble de programmes ayant un lien logique entre eux

-- Q2


CREATE OR REPLACE
PACKAGE MUSIQUE AS

PROCEDURE afficheSupport(pidSupport SUPPORT.NOMSUPPORT%TYPE);
PROCEDURE AjoutChanson(pIdChanson Chanson.idChanson%TYPE, pTitreChanson Chanson.titreChanson%TYPE, pAnneeChanson Chanson.anneeChanson%TYPE, pIdAuteur Chanson.idAuteur%TYPE, pIdCompositeur Chanson.idCompositeur%TYPE);
PROCEDURE ajoutConcert(pidConcert CONCERT.idConcert%TYPE, pnomConcert CONCERT.nomConcert%TYPE, plieuConcert CONCERT.lieuConcert%TYPE, pdateConcert CONCERT.dateConcert%TYPE, pnomArtiste ARTISTE.nomArtiste%TYPE, pprenomArtiste ARTISTE.prenomArtiste%TYPE);
PROCEDURE MAJPiste(pidPiste PISTE.idPiste%TYPE,pnoPiste PISTE.nopiste%TYPE);
PROCEDURE AfficheAuteur (pidArtiste ARTISTE.idArtiste%TYPE);

FUNCTION dureeAlbum(ptitreAlbum ALBUM.titreAlbum%TYPE) RETURN NUMBER;


END MUSIQUE;
/

CREATE OR REPLACE
PACKAGE BODY MUSIQUE AS

PROCEDURE afficheSupport(pidSupport SUPPORT.NOMSUPPORT%TYPE) IS

vcompteur NUMBER :=0;

BEGIN

    FOR c1_ligne IN (SELECT A.TITREALBUM,A.LABEL,A.ANNEEALBUM
	FROM ALBUM A, DisponibleSurSupport D, SUPPORT S
	WHERE A.idAlbum = D.idAlbum
	AND D.idSupport = S.IDSUPPORT
	AND S.NOMSUPPORT = pidSupport
	ORDER BY A.AnneeAlbum DESC
	)LOOP
        DBMS_OUTPUT.PUT_LINE ('L album '|| c1_ligne.titrealbum ||' est sorti en ' || c1_ligne.anneealbum ||' chez '|| c1_ligne.label);
        vcompteur := vcompteur+1;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE(vcompteur || ' albums');
END;

PROCEDURE AjoutChanson(pIdChanson Chanson.idChanson%TYPE, pTitreChanson Chanson.titreChanson%TYPE, pAnneeChanson Chanson.anneeChanson%TYPE, pIdAuteur Chanson.idAuteur%TYPE, pIdCompositeur Chanson.idCompositeur%TYPE) IS

EXCEPTION_CLE_ETRANGERE EXCEPTION;
PRAGMA EXCEPTION_INIT(EXCEPTION_CLE_ETRANGERE, -2291);

EXCEPTION_PARAM_NULL EXCEPTION;
PRAGMA EXCEPTION_INIT(EXCEPTION_PARAM_NULL, -2290);

BEGIN
INSERT INTO Chanson
(idChanson, titreChanson, anneeChanson, idAuteur, idCompositeur)
VALUES
(pIdChanson, pTitreChanson, pAnneeChanson, pIdAuteur, pIdCompositeur);

EXCEPTION

WHEN DUP_VAL_ON_INDEX THEN DBMS_OUTPUT.PUT_LINE('Identifiant de chanson déjà existant');

WHEN EXCEPTION_CLE_ETRANGERE THEN
IF sqlerrm LIKE '%(GWJ1654A.FK_CHANSON_AUTEUR)%'
THEN DBMS_output.put_line('L''ID auteur rentré (' || pIdAuteur || ') n''existe pas veuillez entrer un idAuteur connu.');
  ELSIF sqlerrm LIKE '%(GWJ1654A.FK_CHANSON_COMPOSITEUR)%'
  THEN DBMS_output.put_line('L''ID compositeur rentré (' || pIdCompositeur || ') n''existe pas veuillez entrer un idCompositeur connu.');
END IF;

WHEN EXCEPTION_PARAM_NULL THEN
  IF sqlerrm LIKE '%(GWJ1654A.NN_TITRECHANSON)%'
  THEN DBMS_output.put_line('Le titre de chanson ne peux pas être vide!');
  ELSIF sqlerrm LIKE '%(GWJ1654A.NN_IDAUTEUR)%'
    THEN DBMS_output.put_line('Il faut préciser un ID auteur!');
      ELSIF sqlerrm LIKE '%(GWJ1654A.NN_IDCOMPOSITEUR)%'
        THEN DBMS_output.put_line('Il faut préciser un ID compositeur!');
END IF;

WHEN OTHERS THEN DBMS_output.put_line(sqlerrm || sqlcode);

END;



PROCEDURE ajoutConcert(pidConcert CONCERT.idConcert%TYPE, pnomConcert CONCERT.nomConcert%TYPE, plieuConcert CONCERT.lieuConcert%TYPE, pdateConcert CONCERT.dateConcert%TYPE, pnomArtiste ARTISTE.nomArtiste%TYPE, pprenomArtiste ARTISTE.prenomArtiste%TYPE) IS

vidArtiste Artiste.idArtiste%TYPE;
vnbconcert NUMBER:=0;
vNombreChansonArtiste NUMBER:=0;

DISCRIMINATION_EXCEPTION EXCEPTION;

BEGIN

SELECT idArtiste INTO vidArtiste
FROM Artiste
WHERE pnomArtiste = nomArtiste
AND pprenomArtiste = prenomArtiste;

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

IF vNombreChansonArtiste = 0 THEN RAISE DISCRIMINATION_EXCEPTION;END IF;

SELECT count(idConcert)
INTO vnbconcert
FROM Concert;

DBMS_OUTPUT.PUT_LINE('Il y a :'||vnbconcert||'concerts dans la table');

INSERT INTO Concert
VALUES(
pidConcert,
pnomConcert,
plieuConcert,
pdateConcert);

FOR c1_ligne IN(SELECT Chanson.idChanson
    FROM Chanson,Interpreter,Piste,Album,Artiste
    WHERE Interpreter.idArtiste = vidArtiste
    AND Interpreter.idArtiste = Artiste.idArtiste
    AND Interpreter.idPiste = Piste.idPiste
    AND Chanson.idChanson = Piste.idChanson
    AND Piste.idAlbum = Album.idAlbum
    AND Album.anneeAlbum < to_number(to_char(to_date(pdateConcert),'YYYY')))LOOP

INSERT INTO InterpreterEnConcert
VALUES(
pidConcert,
c1_ligne.idChanson,
vidArtiste);

END LOOP;

EXCEPTION

WHEN NO_DATA_FOUND THEN DBMS_output.put_line('nomArtiste ou prenomArtiste inexistant.');
-- 2 gestion du DUP_VAL_ON_INDEX
WHEN DUP_VAL_ON_INDEX THEN DBMS_output.put_line('Identifiant de concert (idConcert) déjà existant!');
-- 3 gestion du nombre de chanson de l'artiste
WHEN DISCRIMINATION_EXCEPTION THEN DBMS_output.put_line('Mec wtf tu peux pas faire de concert sans avoir de chanson!');

END;


PROCEDURE MAJPiste(pidPiste PISTE.idPiste%TYPE,pnoPiste PISTE.nopiste%TYPE) IS

vtitreChanson Chanson.titreChanson%TYPE;
vtitreAlbum Album.titreAlbum%TYPE;
vNumPiste NUMBER:=0;

NUM_PISTE_INVALIDE EXCEPTION;
NUM_ENSEMBLE_EXCEPTION EXCEPTION ;
PRAGMA EXCEPTION_INIT(NUM_ENSEMBLE_EXCEPTION, -2290);

BEGIN

SELECT COUNT(noPiste) INTO vNumPiste
FROM Piste
WHERE IDALBUM=(SELECT ALbum.idAlbum FROM Piste,Album
WHERE Piste.idAlbum = Album.idAlbum
AND Piste.idPiste = pidPiste)
AND NOPISTE = pnoPiste;

IF vNumPiste!=0 THEN RAISE NUM_PISTE_INVALIDE ; END IF;


SELECT titreChanson,titreAlbum INTO vtitreChanson,vtitreAlbum
FROM Chanson,Piste,Album
WHERE Chanson.idChanson = Piste.idChanson
AND Piste.idAlbum = Album.idAlbum
AND Piste.idPiste = pidPiste;

DBMS_OUTPUT.PUT_LINE('Piste n°'||pnoPiste||', Titre chanson : '||vtitreChanson||', Titre album'||vtitreAlbum);

UPDATE PISTE SET  nopiste = pnoPiste WHERE idPiste = pidPiste;

EXCEPTION

WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('id concert n existe pas');
WHEN NUM_PISTE_INVALIDE THEN DBMS_OUTPUT.PUT_LINE('Numéro de piste déjà existante');
WHEN NUM_ENSEMBLE_EXCEPTION THEN DBMS_OUTPUT.PUT_LINE('No Piste non compris entre 1 et 40');

END;

FUNCTION dureeAlbum(ptitreAlbum ALBUM.titreAlbum%TYPE) RETURN NUMBER IS

DureeTotal NUMBER:=0;

BEGIN

FOR c1_ligne IN(SELECT duree
	FROM Piste,Album
	WHERE Piste.idAlbum = Album.idAlbum
	AND Album.titreAlbum = ptitreAlbum) LOOP

	DureeTotal :=  DureeTotal + c1_ligne.duree;

END LOOP;
RETURN DureeTotal;
END;


FUNCTION nbChansonsAuteur(pidArtiste ARTISTE.idArtiste%TYPE) RETURN NUMBER IS

vnbChansonA NUMBER:=0;

BEGIN

SELECT COUNT(*) INTO vnbChansonA
FROM Chanson
WHERE idAuteur = pidArtiste;

RETURN vnbChansonA;
END;


FUNCTION nbChansonsCompositeur(pidArtiste ARTISTE.idArtiste%TYPE) RETURN NUMBER IS
vnbChansonC NUMBER:=0;

BEGIN
SELECT COUNT(*) INTO vnbChansonC
FROM Chanson
WHERE idCompositeur = pidArtiste;

RETURN vnbChansonC;
END;

FUNCTION nbChansonsInterprete(pidArtiste ARTISTE.idArtiste%TYPE) RETURN NUMBER IS

vnbChansonI NUMBER:=0;

BEGIN

SELECT COUNT(*) INTO vnbChansonI
FROM Interpreter
WHERE idArtiste = pidArtiste;

RETURN vnbChansonI;
END;


PROCEDURE AfficheAuteur (pidArtiste ARTISTE.idArtiste%TYPE) IS

vnomArtiste ARTISTE.nomArtiste%TYPE;
vprenomArtiste ARTISTE.prenomArtiste%TYPE;

BEGIN

SELECT nomArtiste, prenomArtiste INTO vnomArtiste, vprenomArtiste
FROM ARTISTE
WHERE idArtiste = pidArtiste;

DBMS_OUTPUT.put_line(vnomArtiste || ' ' || vprenomArtiste);
DBMS_OUTPUT.put_line('- est l''auteur de ' ||MUSIQUE.nbChansonsAuteur(pidArtiste)|| ' chanson(s)');
DBMS_OUTPUT.put_line('- est le compositeur de ' ||MUSIQUE.nbChansonsCompositeur(pidArtiste)|| ' chanson(s)');
DBMS_OUTPUT.put_line('- est l''interprete de ' ||MUSIQUE.nbChansonsInterprete(pidArtiste)|| ' chanson(s)');
DBMS_OUTPUT.put_LINE('Liste des chansons dont il/elle est le compositeur');
FOR c1_ligne IN(SELECT Chanson.titreChanson, Chanson.anneeChanson
				FROM Chanson
				WHERE idCompositeur = pidArtiste)LOOP

				DBMS_OUTPUT.put_line('Titre : '||c1_ligne.titreChanson||' , '||c1_ligne.anneeChanson);

				FOR c2_ligne IN(SELECT Album.titreAlbum, Album.anneeAlbum, Piste.noPiste,Album.idAlbum
FROM Album,Piste,Chanson
WHERE Chanson.idCompositeur = pidArtiste
AND Chanson.titreChanson = c1_ligne.titreChanson
AND Chanson.anneeChanson = c1_ligne.anneeChanson
AND Chanson.idchanson = Piste.idchanson
AND Piste.idAlbum = Album.idAlbum)LOOP

								DBMS_OUTPUT.PUT_LINE('	Album : '||c2_ligne.titreAlbum||' , '||c2_ligne.anneeAlbum||' , piste no '||c2_ligne.noPiste||' interprété par : ');


								FOR c3_ligne IN(SELECT DISTINCT Artiste.nomArtiste,Artiste.prenomArtiste
FROM Artiste, Interpreter, Piste, Album
WHERE Album.idAlbum = c2_ligne.idAlbum
AND Piste.nopiste = c2_ligne.noPiste
AND Album.IDALBUM = Piste.IDALBUM
AND Piste.idPiste = Interpreter.IDPISTE
AND Interpreter.idArtiste = Artiste.idArtiste
)LOOP

												DBMS_OUTPUT.PUT_LINE('       - '||c3_ligne.prenomArtiste||' '||c3_ligne.nomArtiste);

								END LOOP;
				END LOOP;
END LOOP;

END ;


END MUSIQUE;
/

-- Q4

CREATE OR REPLACE PROCEDURE insertionPiste(pidPiste Piste.idPiste%TYPE,pnoPiste Piste.noPiste%TYPE,pduree Piste.duree%TYPE,pIdChanson Piste.idChanson%TYPE,pidAlbum Piste.idAlbum%TYPE) IS

EXCEPTION_CLE_ETRANGERE EXCEPTION;
PRAGMA EXCEPTION_INIT(EXCEPTION_CLE_ETRANGERE, -2291);

EXCEPTION_PARAM_NULL EXCEPTION;
PRAGMA EXCEPTION_INIT(EXCEPTION_PARAM_NULL, -2290);

EXCEPTION_DATE EXCEPTION;

vanneeChanson Chanson.anneeChanson%TYPE;
vanneealbum Album.anneeAlbum%TYPE;

BEGIN

SELECT anneeChanson INTO vanneeChanson FROM Chanson WHERE idChanson = pIdChanson;
SELECT anneealbum INTO vanneealbum FROM Album WHERE idAlbum = pidAlbum;

IF (vanneeChanson>vanneealbum) THEN
	RAISE EXCEPTION_DATE;
END IF;

INSERT INTO Piste VALUES (pidPiste,pnoPiste,pduree,pIdChanson,pidAlbum);

EXCEPTION

WHEN DUP_VAL_ON_INDEX THEN DBMS_OUTPUT.PUT_LINE('Identifiant de chanson déjà existant');

WHEN EXCEPTION_CLE_ETRANGERE THEN
IF sqlerrm LIKE '%(GWJ1654A.FK_PISTE_CHANSON)%'
THEN DBMS_output.put_line('L''ID chanson rentré (' || pIdChanson || ') n''existe pas veuillez entrer un idChanson connu.');
  ELSIF sqlerrm LIKE '%(GWJ1654A.FK_PISTE_ALBUM)%'
  THEN DBMS_output.put_line('L''ID album rentré (' || pIdAlbum || ') n''existe pas veuillez entrer un idAlbum connu.');
END IF;

WHEN EXCEPTION_PARAM_NULL THEN
  IF sqlerrm LIKE '%(GWJ1654A.NN_IDALBUM)%'
  THEN DBMS_output.put_line('ID Album ne peux pas être vide!');
  ELSIF sqlerrm LIKE '%(GWJ1654A.NN_IDCHANSON)%'
    THEN DBMS_output.put_line('ID Chanson ne peux pas être vide!');
  ELSIF sqlerrm LIKE '%(GWJ1654A.NOPISTE)%'
    THEN DBMS_output.put_line('No piste entre 1 et 40 !');
END IF;

WHEN EXCEPTION_DATE THEN DBMS_OUTPUT.PUT_LINE('Chanson non existante à la date de parution de l album');

WHEN OTHERS THEN DBMS_output.put_line(sqlerrm || sqlcode);

END;
/
