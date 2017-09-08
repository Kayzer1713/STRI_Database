-- TP1 PL/SQL --
 -- Q1
-- liste des tables crées

SET SERVEROUTPUT ON;


SELECT *
FROM user_tables;

-- description des colonnes (nom et type) de la table Chanson
DESC Chanson;

-- nom et le type des contraintes creees

SELECT *
FROM user_constraints;

-- Q2
 -- nombre d'albums disponibles sur le support 'Vinyl'
 --1

SELECT COUNT(A.idAlbum)
FROM Support S,
     Album A,
     disponibleSurSupport D
WHERE S.idSupport = D.idSupport
  AND D.idAlbum = A.idAlbum
  AND nomSupport = 'Vinyl';

-- liste des albums (titre, annee, label) tries par ordre chronologique decroissant de parution

SELECT titreAlbum,
       anneeAlbum,
       label
FROM Support S,
     Album A,
     disponibleSurSupport D
WHERE S.idSupport = D.idSupport
  AND D.idAlbum = A.idAlbum
  AND nomSupport = 'Vinyl'
ORDER BY anneeAlbum DESC;bum%TYPE;

vAnneeAlbum Album.anneeAlbum%TYPE;

vLabel Album.label%TYPE;

vAlbumNumber NUMBER:=0;

BEGIN OPEN c1;

FETCH c1 INTO vTitreAlbum,
              vAnneeAlbum,
              vLabel;

WHILE c1%FOUND LOOP vAlbumNumber := vAlbumNumber + 1;

DBMS_output.put_line('L''album ' || vTitreAlbum || ' est sorti en Vinyl en ' || vAnneeAlbum || ' sous le label ' || vLabel);

FETCH c1 INTO vTitreAlbum,
              vAnneeAlbum,
              vLabel;

END LOOP;

CLOSE c1;

DBMS_output.put_line('Nombre d''album sur support Vinyl: ' || vAlbumNumber);

END;

-- Procedure avec cuseur semi automatique

CREATE OR REPLACE PROCEDURE afficheSupport IS
CURSOR c1 IS
SELECT titreAlbum,
       anneeAlbum,
       label
FROM Support S,
     Album A,
     disponibleSurSupport D
WHERE S.idSupport = D.idSupport
  AND D.idAlbum = A.idAlbum
  AND nomSupport = 'Vinyl';

vAlbumNumber NUMBER:=0;

BEGIN
FOR c1_ligne IN c1 LOOP vAlbumNumber := vAlbumNumber + 1;

DBMS_output.put_line('L''album ' || c1_ligne.titreAlbum || ' est sorti en Vinyl en ' || c1_ligne.anneeAlbum || ' sous le label ' || c1_ligne.label);

END LOOP;

DBMS_output.put_line('Nombre d''album sur support Vinyl: ' || vAlbumNumber);

END;

-- Procedure avec curseur automatique:

CREATE OR REPLACE PROCEDURE afficheSupport IS vAlbumNumber NUMBER:=0;

BEGIN
FOR r1 IN
  (SELECT titreAlbum,
          anneeAlbum,
          label
   FROM Support S,
        Album A,
        disponibleSurSupport D
   WHERE S.idSupport = D.idSupport
     AND D.idAlbum = A.idAlbum
     AND nomSupport = 'Vinyl'
   ORDER BY anneeAlbum DESC) LOOP DBMS_output.put_line('L''album ' || r1.titreAlbum || ' est sorti en Vinyl en ' || r1.anneeAlbum || ' sous le label ' || r1.label);

vAlbumNumber := vAlbumNumber + 1;

END LOOP;

DBMS_output.put_line('Nombre d''album sur support Vinyl: ' || vAlbumNumber);

END;

-- Q3

-- procédure d'affichage des album avec support en paramètre
CREATE OR REPLACE PROCEDURE afficheSupport (pSupport Support.nomSupport%TYPE) IS vAlbumNumber NUMBER:=0;

BEGIN
FOR c1 IN
  (SELECT titreAlbum,
          anneeAlbum,
          label
   FROM Support S,
        Album A,
        disponibleSurSupport D
   WHERE S.idSupport = D.idSupport
     AND D.idAlbum = A.idAlbum
     AND nomSupport = pSupport
   ORDER BY anneeAlbum DESC) LOOP DBMS_output.put_line('L''album ' || c1.titreAlbum || ' est sorti en ' || pSupport || ' en ' || c1.anneeAlbum || ' sous le label ' || c1.label);

vAlbumNumber := vAlbumNumber + 1;

END LOOP;

DBMS_output.put_line('Nombre d''album sur support ' || pSupport ||': ' || vAlbumNumber);

END;

-- Q4
 --
select * from user_source;
