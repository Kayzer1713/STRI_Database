# Database
STRI database practical work

## TP1: PL/SQL
### Q0:
Initialiser la base de données avec les fichier createbase.sql et insert.sql
### Q1:
En utilisant le Dictionnaire des Données :
• donner la requête permettant d’obtenir la liste des tables créées
• donner la requête permettant d’obtenir une description des colonnes (nom et type) de
la table Chanson
• donner la requête permettant d’obtenir le nom et le type des contraintes créées
### Q2:
Pour les besoins d’une application, on souhaite connaître le nombre d’albums disponibles sur le support ‘Vinyl’, ainsi que la liste de ces albums (titre, année, label) trié par ordre chronologique décroissant de parution.
A – Ecrire les deux requêtes SQL permettant d’afficher ces caractéristiques.
B – « Encapsulez » ces deux requêtes dans une procédure stockée PL/SQL afficheSupport
effectuant la même chose. Vous coderez trois versions différentes de la procédure :
- en utilisant un curseur manuel
- en utilisant un curseur semi-automatique
- en utilisant un curseur automatique
Attention, on n’utilisera un curseur que quand cela est nécessaire !
Tester l’appel de cette procédure.
Remarque : On rappelle l’intérêt de la procédure PL/SQL dans ce cas :
- simplicité d’utilisation pour l’utilisateur : uniquement appel à la procédure, pas
d’exécution de requêtes
- l’utilisateur ne « voit » pas le code.
### Q3:
Créer une nouvelle procédure stockée reprenant la précédente mais permettant de paramétrer le nom du support pour lequel on veut le nombre d’albums et la liste de ces albums.
### Q4:
A l’aide du dictionnaire des données, affichez le code source de vos programmes stockés.
## TP2 Procédures PL/SQL : gestion des curseurs
