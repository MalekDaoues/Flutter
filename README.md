
# Bienvenue dans **E-shop ** ! 

## Mon Avis sur Flutter
Avant de plonger dans les étapes de développement, j'aimerais partager mon avis personnel sur Flutter.Je le trouve un choix exceptionnel pour construire des applications
multiplateformes, avec sa riche bibliothèque de widgets personnalisables qui permettent de créer des interfaces utilisateurs uniques et de mettre en œuvre des designs 
complexes, aussi sa  fonctionnalité de rechargement à chaud qui permet aux développeurs de voir instantanément les changements effectués dans le code, et J'apprécie 
surtout comment Flutter encourage l'utilisation d'un seul code source pour à la fois iOS et Android, réduisant ainsi le temps de développement et les efforts de maintenance. 

Bien que chaque technologie ait ses points forts et ses limites, mon expérience avec Flutter a été extrêmement positive. Je crois qu'il permet aux développeurs de créer 
des applications visuellement attrayantes, performantes et réactives avec une relative facilité.

Maintenant, explorons les différentes étapes de développement de notre application Flutter


## Table des matières

1. [Introduction]
2. [Pour Commencer]
3. [Étapes de Développement]
    - [Étape 1: Configuration du Projet]
    - [Étape 2: Prototypage de l'Interface]
    - [Étape 3: Intégration des Données]
    - [Étape 4: Implémentation des Fonctionnalités]


## Introduction

Plongez dans une expérience de shopping en ligne inégalée grâce à notre application mobile innovante développée avec Flutter qui permet aux utilisateurs d'explorer, choisir
et acheter  des vêtements.

## Pour Commencer
Pour exécuter cette application Flutter sur votre machine locale, suivez ces étapes :

1.Installer votre éditeur ou IDE préféré.

2.Installer Flutter SDK [https://flutter.dev/docs/get-started/install].

3.Installer Git [https://git-scm.com/downloads].

4.Clonez ce dépôt : `git clone https://github.com/MalekDaoues/Flutter.git`

5.Naviguez vers le répertoire du projet : `cd e-shop`

6.Installez les dépendances : `flutter pub get` 

7.Lancez l'application : `flutter run`


## Étapes de Développement

### Étape 1: Configuration du Projet
Dans cette étape, la structure initiale du projet est mise en place. Cela inclut :

- Créer le projet Flutter.

- Configuration du GitHub pour suivre et gérer les modifications apportées aux fichiers de votre projet au fil du temps : [https://dev.to/learn_flutter_with_smrity/how-to-upload-flutter-project-on-github-bring-remote-repo-locally-a-z-2022-2l3i].

  - Installer les dépendances externes nécessaires pour l'application,dans le fichier pubspec.yaml, ajoutez :
    dependencies:
    'get: ^4.6.5'
    'flutter_rating_bar: ^4.0.1'
    'keyboard_dismisser: ^3.0.0'
    'path: ^1.8.3'
    'fluttertoast: ^8.2.2'
    'firebase_core: ^2.15.0'
    'firebase_auth: ^4.7.2'
    'country_code_picker: ^3.0.0'
    'path_provider: ^2.0.15'
    'intl_phone_number_input: ^0.7.3+1'
    'cloud_firestore: ^4.8.2'
    'get_storage: ^2.1.1'
    Puis, cliquez pub get

### Étape 2: Prototypage de l'Interface
La conception de l'interface utilisateur :
   dashboard.dart
   home_screen.dart
   Product_card.dart
   product_screen.dart
   cart_item.dart
   cart_screen.dart
   check_button.dart
   color_options.dart
   custom_divider.dart
   quantity_options.dart
   size_options.dart
   bottom_sheet.dart
   Favoris_screen.dart
   registration_screen.dart
   login_screen.dart
   Payment_Screen.dart
   Profile_page.dart

### Étape 3: Intégration des Données
Intégrez les sources de données dans l'application :
- Connectez-vous aux bases de données:
    La configuration du Firebase : [https://firebase.google.com/docs/flutter/setup?hl=fr&platform=android].
  
  - Récupérez et affichez les données dans l'interface utilisateur:
       firebase_options.dart
       L'ajout de cette structure dans main:
       [Future<void> main() async{
         WidgetsFlutterBinding.ensureInitialized();
         await Firebase.initializeApp(
         options: DefaultFirebaseOptions.currentPlatform,
       );]


### Étape 4: Implémentation des Fonctionnalités

1.home_ controller.dart
   [Catalogue de produits] : Afficher une liste de vêtements avec des images, des descriptions et des prix .

   [Détails du produit] : Afficher des informations détaillées sur chaque produit, y compris des images supplémentaires, des avis, des informations sur les matériaux, etc.

2.Cart_controller.dart
   [Panier d'achat] : Permettre aux utilisateurs d'ajouter  des articles à leur panier, de gérer les quantités et de voir le total de leur commande.

3.Favorite_controller.dart
[Page de Favoris] : Créer une page distincte où les utilisateurs peuvent consulter tous les articles qu'ils ont ajoutés à leurs Favoris.

4.auth_controller.dart
[Gestion de profil] : Permettre aux utilisateurs de créer et de gérer leurs profils.



Ces fonctionnalités sont en cours de développement et seront ajoutées à l'application dans les prochaines mises à jour:

[Recherche avancée] : [Permettre aux utilisateurs de rechercher des vêtements en fonction de critères spécifiques tels que le type de vêtement, la taille, la couleur, etc.

[Passer à la caisse ]: [Offrir une expérience fluide de passage à la caisse où les utilisateurs peuvent entrer leurs coordonnées de livraison, choisir une méthode de paiement et passer leur commande.

[Suivi des Commandes] : Informer les utilisateurs de l'état de leurs commandes, des mises à jour de livraison et des confirmations de paiement.





