
-- inserbase.sql

delete from disponibleSurSupport;
delete from Interpreter;
delete from InterpreterEnConcert;
delete from AppartenirGroupe;
delete from Piste;
delete from Chanson;
delete from Artiste;
delete from Album;
delete from Support;
delete from Concert;

-- concert
insert into Concert values (1,'Main Square Festival', 'Arras, France', '03/07/2015');
insert into Concert values (2,'Sur la route des enfoirés', 'Montpellier, France', '21/01/2015');


-- support
insert into Support values (1,'CD',20);
insert into Support values (2,'MP3',15);
insert into Support values (3,'Vinyl',20);

-- album
insert into Album values (1,'The Resistance',2009,'Warner Bros');
insert into Album values (2,'Sur la route des enfoirés',2015,'Columbia');
insert into Album values (3,'Troisième sexe',1985, 'BMG Ariola');
insert into Album values (4,'L''aventurier',1982, 'BMG Ariola');
insert into Album values (5,'G I R L', 2013,'Columbia');
insert into Album values (6,'The 2nd law',2012,'Warner Bros');
insert into Album values (7,'Black star',2016, 'Sony');


-- artiste
insert into Artiste values (1,'Muse',null);
insert into Artiste values (2, 'Bellamy','Matthew');
insert into Artiste values (3, 'Howard','Dominic');
insert into Artiste values (4, 'Wolstenholme','Christopher');

insert into Artiste values (5,'Fiori','Patrick');
insert into Artiste values (6,'Jenifer',null);
insert into Artiste values (7,'Lââm',null);
insert into Artiste values (8,'Merad','Kad');
insert into Artiste values (9,'Moire','Emmanuel');
insert into Artiste values (10,'Tal',null);
insert into Artiste values (11,'Indochine',null);
insert into Artiste values (12,'Boon','Dany');
insert into Artiste values (13, 'Grégoire', null);
insert into Artiste values (14, 'Maunier','Jean-Baptiste');
insert into Artiste values (15, 'Corneille',null);
insert into Artiste values (16, 'St Pier','Natasha');
insert into Artiste values (17, 'Tal',null);
insert into Artiste values (18, 'Willem','Christophe');
insert into Artiste values (19,'Williams','Pharrell');

insert into Artiste values (20, 'Sirkis',	'Nicola');
insert into Artiste values (21, 'Marco',null);
insert into Artiste values (22, 'Jardel','Boris');
insert into Artiste values (23, 'de Sat','Oli');
insert into Artiste values (24, 'Dahlberg','Ludwig');
insert into Artiste values (25, 'Sirkis','Stéphane');
insert into Artiste values (26, 'Nicolas','Dominique');
insert into Artiste values (27, 'Lopez','Robert');

insert into Artiste values (28,'Bowie','David');
insert into Artiste values (29, 'Eno', 'Brian');




-- AppartenirGroupe
insert into AppartenirGroupe values (2,1,'01/01/1984',null);
insert into AppartenirGroupe values (3,1,'01/01/1984',null);
insert into AppartenirGroupe values (4,1,'01/01/1984',null);
insert into AppartenirGroupe values (20,11,'01/01/1981',null);
insert into AppartenirGroupe values (21,11,'01/01/1992',null);
insert into AppartenirGroupe values (22,11,'01/01/1998',null);
insert into AppartenirGroupe values (23,11,'01/01/2002',null);
insert into AppartenirGroupe values (24,11,'01/01/2015',null);
insert into AppartenirGroupe values (25,11,'01/01/1982','24/02/1999');
insert into AppartenirGroupe values (26,11,'01/01/1981','27/08/1995');




-- Chanson (idChanson, titreChanson, anneeChanson, idAuteur, idCompositeur)
insert into Chanson values (1,'Uprising',2009,1,2);
insert into Chanson values (2,'Resistance',2009,1,2);
insert into Chanson values (3,'Undisclosed Desires',2009,1,2);
insert into Chanson values (4,'United States of Eurasia',2009,1,2);
insert into Chanson values (5,'Trois nuits par semaine',1985, 20,26);
insert into Chanson values (6,'L''aventurier',1982, 20,26);
insert into Chanson values (7,'Libérée, délivrée',2013,27,27);
insert into Chanson values (8,'Happy',2013, 19,19);
insert into Chanson values (9, 'Supremacy',2012,1,2);
insert into Chanson values (10, 'Madness', 2012,1,2);
insert into Chanson values (11, 'Panic Station',2012,1,2);
insert into Chanson values (12, 'Prelude', 2012,1,3);
insert into Chanson values (13, 'Survival',2012,1,2);
insert into Chanson values (14, 'Follow Me',2012,1,2);
insert into Chanson values (15, 'Introduction to Main Square',2015,1,1);

insert into Chanson values (16,'Blackstar',2015,28,28);
insert into Chanson values (17,'Lazarus',2015,28,28);
insert into Chanson values (18,'Sue (Or In A Season Of Crime)',2016,28,28);
insert into Chanson values (19,'Girl Loves Me',2016,28,28);
insert into Chanson values (20,'''Tis A Pity She Was A Whore',2016,28,28);
insert into Chanson values (21,'Dollar days',2016,28,28);
insert into Chanson values (22,'I Can''t Give Everything Away',2016,28,28);




-- Piste (idPiste, nopiste, duree, idChanson, idAlbum)
-- Interpreter (idPiste, idArtiste)
insert into Piste values (1,1, 304,1,1);
insert into Interpreter values (1,1);
insert into Piste values (2,2,546,2,1);
insert into Interpreter values (2,1);
insert into Piste values (3,3,237,3,1);
insert into Interpreter values (3,1);
insert into Piste values (4,4,547,4,1);
insert into Interpreter values (4,1);

insert into Piste values (5,13,387, 5,3);
insert into Interpreter values (5, 11);
insert into Piste values (6,1,243,6,4);
insert into Interpreter values (6, 11);
insert into Piste values (7,1,253,8,5);
insert into Interpreter values (7, 19);

insert into Piste values (8, 15,183, 5, 2);
insert into Interpreter values (8,5);
insert into Interpreter values (8,6);
insert into Interpreter values (8,7);
insert into Interpreter values (8,8);
insert into Interpreter values (8,9);
insert into Interpreter values (8,10);


insert into Piste values (9, 13,387,6,2);
insert into Interpreter values (9,12);
insert into Interpreter values (9,13);
insert into Interpreter values (9,14);


insert into Piste values (10, 14,152, 7,2);
insert into Interpreter values (10,6);
insert into Interpreter values (10,10);

insert into Piste values (11,16,198,8,2);
insert into Interpreter values (11,15);
insert into Interpreter values (11,16);
insert into Interpreter values (11,17);
insert into Interpreter values (11,18);

insert into Piste values (12,1,295,9,6);
insert into Interpreter values (12,1);
insert into Piste values (13,2,280,10,6);
insert into Interpreter values (13,1);
insert into Piste values (14,3,184,11,6);
insert into Interpreter values (14,1);
insert into Piste values (15,4,58,12,6);
insert into Interpreter values (15,1);
insert into Piste values (16,5,257,13,6);
insert into Interpreter values (16,1);
insert into Piste values (17,6,231,14,6);
insert into Interpreter values (17,1);

insert into Piste values (18,1,592,16,7);
insert into Interpreter values (18,28);
insert into Piste values (19,2,292,17,7);
insert into Interpreter values (19,28);
insert into Piste values (20,3,382,18,7);
insert into Interpreter values (20,28);
insert into Piste values (21,4,280,19,7);
insert into Interpreter values (21,28);
insert into Piste values (22,5,291,20,7);
insert into Interpreter values (22,28);
insert into Piste values (23,6,284,21,7);
insert into Interpreter values (23,28);
insert into Piste values (24,7,347,22,7);
insert into Interpreter values (24,28);


-- InterpreterEnConcert (idConcert, idChanson, idArtiste);
insert into InterpreterEnConcert values (2,5,5);
insert into InterpreterEnConcert values (2,5,6);
insert into InterpreterEnConcert values (2,5,7);
insert into InterpreterEnConcert values (2,5,8);
insert into InterpreterEnConcert values (2,5,9);
insert into InterpreterEnConcert values (2,5,10);
insert into InterpreterEnConcert values (2,6,12);
insert into InterpreterEnConcert values (2,6,13);
insert into InterpreterEnConcert values (2,6,14);
insert into InterpreterEnConcert values (2,7,6);
insert into InterpreterEnConcert values (2,7,10);
insert into InterpreterEnConcert values (2,8,15);
insert into InterpreterEnConcert values (2,8,16);
insert into InterpreterEnConcert values (2,8,17);
insert into InterpreterEnConcert values (2,8,18);

insert into InterpreterEnConcert values (1,15,1);
insert into InterpreterEnConcert values (1,10,1);
insert into InterpreterEnConcert values (1,11,1);
insert into InterpreterEnConcert values (1,14,1);
insert into InterpreterEnConcert values (1,1,1);
insert into InterpreterEnConcert values (1,2,1);

-- disponibleSurSupport (idAlbum, idSupport, prixDeVente)
insert into disponibleSurSupport values (1, 1,21.99);
insert into disponibleSurSupport values (1, 2,11.99);

insert into disponibleSurSupport values (2, 1,26.99);
insert into disponibleSurSupport values (2, 2,20.99);

insert into disponibleSurSupport values (3, 1,14.99);
insert into disponibleSurSupport values (3, 3,15);

insert into disponibleSurSupport values (4, 1,14.99);
insert into disponibleSurSupport values (4, 3,15);

insert into disponibleSurSupport values (5, 1,22.99);
insert into disponibleSurSupport values (5, 2,14);
insert into disponibleSurSupport values (5, 3,12.99);

insert into disponibleSurSupport values (6, 1,21.99);
insert into disponibleSurSupport values (6, 2,11.99);
insert into disponibleSurSupport values (6, 3,21.99);

commit;
