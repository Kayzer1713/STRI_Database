-- creabase.sql

drop table disponibleSurSupport;
drop table Interpreter;
drop table InterpreterEnConcert;
drop table AppartenirGroupe;
drop table Piste;
drop table Chanson;
drop table Artiste;
drop table Album;
drop table Support;
drop table Concert;


create table Concert (
  idConcert number,
  nomConcert varchar2(40),
  lieuConcert varchar2(50),
  dateConcert date,
  constraint pk_concert primary key(idConcert)
  );

create table Support (
  idSupport number(2),
  nomSupport varchar2(40),
  TVA number (4,2),
  constraint pk_support primary key(idSupport)
  );


create table Album (
  idAlbum number,
  titreAlbum varchar2(100),
  anneeAlbum number(4),
  label varchar2(40),
  constraint pk_album primary key(idAlbum),
  constraint nn_titreAlbum check (titreAlbum is not null)
  );

create table Artiste (
  idArtiste number,
  nomArtiste varchar2(100),
  prenomArtiste varchar2(100),
  constraint pk_artiste primary key(idArtiste)
  );


create table Chanson (
  idChanson number,
  titreChanson varchar2(100),
  anneeChanson number(4),
  idAuteur number,
  idCompositeur number,
  constraint pk_chanson primary key(idChanson),
  constraint nn_titreChanson check (titreChanson is not null),
  constraint nn_idAuteur check (idAuteur is not null),
  constraint nn_idCompositeur check (idCompositeur is not null),
  constraint fk_chanson_auteur foreign key (idAuteur) references Artiste(idArtiste),
  constraint fk_chanson_compositeur foreign key (idCOmpositeur) references Artiste(idArtiste)
  );

create table Piste (
  idPiste number,
  nopiste number(2),
  duree number(4),
  idChanson number,
  idAlbum number,
  constraint pk_piste primary key(idPiste),
  constraint nn_idalbum check (idAlbum is not null),
  constraint fk_piste_album foreign key(idAlbum) references Album(idAlbum),
  constraint nn_idChanson check (idChanson is not null),
  constraint fk_piste_chanson foreign key(idChanson) references Chanson(idChanson),
  constraint nopiste check (nopiste between 1 and 40)
  );

create table AppartenirGroupe (
  idArtiste number,
  idGroupe number,
  dateDebut date,
  dateFin date,
  constraint pk_AppartenirA primary key(idArtiste, idGroupe, dateDebut),
  constraint fk_appartenirA_artiste foreign key(idArtiste) references Artiste(idArtiste),
  constraint fk_appartenirA_groupe foreign key(idGroupe) references Artiste(idArtiste),
  constraint ck_dates_appartenirA check (dateFin > dateDebut)
  );


create table Interpreter (
  idPiste number,
  idArtiste number,
  constraint pk_interpreter primary key(idPiste, idArtiste),
  constraint fk_interpreter_piste foreign key(idPiste) references Piste(idPiste),
  constraint fk_interpreter_artiste foreign key(idArtiste) references Artiste(idArtiste)
  );


create table InterpreterEnConcert (
  idConcert number,
  idChanson number,
  idArtiste number,
  constraint pk_interpreterConcert primary key(idConcert, idChanson, idArtiste),
  constraint fk_interpreterConcert_concert foreign key(idConcert) references Concert(idConcert),
  constraint fk_interpreterConcert_chanson foreign key(idChanson) references Chanson(idChanson),
  constraint fk_interpreterConcert_artiste foreign key(idArtiste) references Artiste(idArtiste)
  );

create table disponibleSurSupport(
  idAlbum number,
  idSupport number(2),
  prixDeVente number(5,2),
  constraint pk_disponibleSurSupport primary key(idAlbum, idSupport),
  constraint fk_disponible_album foreign key (idAlbum) references Album(idAlbum),
  constraint fk_disponible_support foreign key (idSupport) references Support(idSupport)
);
