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

### Q1

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
