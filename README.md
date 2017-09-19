# Database

STRI database practical work

## TP1: PL/SQL

### Q0:

Initialiser la base de données avec les fichier createbase.sql et insert.sql

### Q1:

En utilisant le Dictionnaire des Données : • donner la requête permettant d'obtenir la liste des tables créées • donner la requête permettant d'obtenir une description des colonnes (nom et type) de la table Chanson • donner la requête permettant d'obtenir le nom et le type des contraintes créées

### Q2:

Pour les besoins d'une application, on souhaite connaître le nombre d'albums disponibles sur le support 'Vinyl', ainsi que la liste de ces albums (titre, année, label) trié par ordre chronologique décroissant de parution. A – Ecrire les deux requêtes SQL permettant d'afficher ces caractéristiques. B – « Encapsulez » ces deux requêtes dans une procédure stockée PL/SQL afficheSupport effectuant la même chose. Vous coderez trois versions différentes de la procédure :

- en utilisant un curseur manuel
- en utilisant un curseur semi-automatique
- en utilisant un curseur automatique

Attention, on n'utilisera un curseur que quand cela est nécessaire ! Tester l'appel de cette procédure.

Remarque : On rappelle l'intérêt de la procédure PL/SQL dans ce cas :

- simplicité d'utilisation pour l'utilisateur : uniquement appel à la procédure, pas d'exécution de requêtes
- l'utilisateur ne « voit » pas le code.

### Q3:

Créer une nouvelle procédure stockée reprenant la précédente mais permettant de paramétrer le nom du support pour lequel on veut le nombre d'albums et la liste de ces albums.

### Q4:

A l'aide du dictionnaire des données, affichez le code source de vos programmes stockés.

## TP2 Procédures PL/SQL : gestion des curseurs

### Q1:

Ecrire une procédure PL/SQL ajoutConcert prenant en paramètre des valeurs de idConcert, nomConcert, lieuConcert, dateConcert , nomArtiste et prenomArtiste, et permettant :

- d'indiquer combien de concerts sont déjà présents dans la table Concert,
- d'insérer dans la table Concert et la table InterpreterEnConcert le concert correspondant aux données passées en paramètre. Pour la table InterpreterEnConcert , il s'agira d'insérer toutes les chansons enregistrées par l'artiste l'année du concert et les années précédentes (c'est-à-dire toutes les chansons interprétées par l'artiste sur des albums de l'année du concert et antérieurs). Attention :
- ne faites pas de curseur systématiquement s'il n'y en a pas besoin !
- to_number(to_char(to_date('JJ/MM/YYYY'),'YYYY')) permet de récupérer l'année d'une date
- n'oubliez pas de gérer le concept de transaction!

### Q2:

Ecrire une fonction dureeAlbum permettant de renvoyer pour un titreAlbum passé en paramètre la durée totale de l'album.

### Q3:

Donner la requête permettant d'obtenir les titres d'albums et leur durée totale, par ordre décroissant de durée :

- en utilisant la fonction de la question [Q2]
- sans utiliser la fonction de la question [Q2]

### Q4:

Ecrire une procédure stockée MAJPiste qui, pour un identifiant et un numéro de piste passés en paramètre :

- affiche les titres de la chanson et de l'album associés
- effectue la mise à jour du numéro de piste de la piste (remplacer l'ancien numéro de piste par celui passé en paramètre, pour l'identifiant de piste donné).

Que se passe-t-il si l'identifiant de piste n'existe pas ? et si le numéro de piste n'est pas compris entre 1 et 40 ? et si le numéro de piste existe déjà pour l'album concerné ? Tester les différents cas et expliquer les résultats.

## TP3: Gestion des exceptions

### Q1:

On reprend la procédure PL/SQL de la question Q1 du TP précédent (ajoutConcert).
Il s’agissait d’insérer dans la table Concert et la table InterpreterEnConert un concert
et son contenu (en paramètre : idConcert, nomConcert, lieuConcert,
dateConcert et nomArtiste, prenomArtiste).
Vous traiterez les exceptions suivantes, en donnant dans l’exception un message d’erreur
clair à l’utilisateur :
1. nomArtiste et prenomArtiste ne correspondant à aucun artiste existant (erreur
SQL prédéfinie : NO_DATA_FOUND dans la table Artiste)
2. identifiant de concert (idConcert) déjà existant (erreur SQL pré-définie :
DUP_VAL_ON_INDEX)
3. aucune chanson ne correspond à ce concert (erreur applicative : tester la présence d’au
moins une chanson interprétée par le groupe sur un album de l’année du concert ou
antérieur).
Aide : pensez à utiliser un select… count(\*)
Aucune insertion ne doit être faite dans les tables Concert et InterpreterEnConcert si
l’une des exceptions précédente est levée.
Vous testerez bien entendu votre programme pour ‘lever’ toutes les exceptions possibles.

### Q2:

Reprendre la procédure stockée MAJPiste de la question Q4 du TP précédent. Cette
procédure, pour un identifiant et un numéro de piste passés en paramètre :
- affiche les titres de la chanson et de l’album associés
- effectue la mise à jour du numéro de piste de la piste (remplacer l’ancien numéro de
piste par celui passé en paramètre, pour l’identifiant de piste donné).
Vous traiterez les exceptions suivantes, en donnant dans l’exception un message d’erreur
clair à l’utilisateur :
1. l’identifiant de piste n’existe pas (erreur SQL pré-définie)
2. le nouveau numéro de piste existe déjà pour cet album (erreur applicative). En d’autres
termes, il ne peut par exemple pas y avoir deux fois la piste no 2 pour l’album 1.
3. numéro de piste non compris dans l’ensemble [1,40] (erreur SQL non-prédéfinie).
Remarques :
- Pour récupérer le code erreur de la troisième exception, pensez à mettre une exception
OTHERS qui affichera le SQLCODE et le SQLERRM de l’exception que vous voulez
traiter (il suffira de provoquer l’exception).
- La deuxième exception aurait pu être gérée via une contrainte UNIQUE sur le couple
(noPiste, idAlbum) de la table Piste. Si une telle contrainte avait existé, il
aurait fallu gérer l’exception comme la troisième, en récupérant le code erreur généré.
- La mise à jour de la table Piste ne doit pas être faite si l’une des exceptions est levée

### Q3:

Ecrire une procédure stockée AjoutChanson permettant d’insérer un tuple dans la table
Chanson. Cette procédure prendra en paramètre tous les champs de la table Chanson.
Vous gèrerez toutes les exceptions liées aux clés primaires et étrangères, en indiquant un
message d’erreur clair à l’utilisateur.
Remarque importante : les exceptions de clés étrangères peuvent être gérées soit en utilisant
l’exception NO_DATA_FOUND, soit avec l’erreur Oracle SQL non-prédéfinie -2291 (largement
préférable). Dans ce dernier cas, afin de différencier les messages d’erreur, il est possible
d’utiliser la syntaxe suivante :
if sqlerrm like
'%(votre_nom_utilisateur.nom_de_la_contrainte_qui_est_transgressee)%'
then ….
elsif sqlerrm like …
end if ;
