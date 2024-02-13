# ActivityMan

ActivityMan est une application Flutter conçue pour offrir aux utilisateurs une plateforme pour explorer, ajouter au panier et gérer des activités personnelles. Grâce à une intégration étroite avec Firebase, elle offre une authentification sécurisée, la possibilité de stocker et de récupérer des détails d'activités, et une gestion de profil d'utilisateur.

## Fonctionnalités

- **Authentification Firebase:** Connexion et inscription des utilisateurs.
- **Gestion des Activités:** Ajoutez de nouvelles activités à la plateforme via une interface utilisateur dédiée.
- **Détails des Activités:** Visualisez des détails sur chaque activité, y compris une image, un titre, un lieu, et un prix.
- **Cart:** Ajoutez des activités à votre panier et ajustez les quantités selon vos besoins.
- **Profil Utilisateur:** Visualisez et éditez les informations de votre profil.
- **Navigation:** Utilisez une barre de navigation inférieure pour naviguer entre les différentes sections de l'application.

## Pages

L'application est composée des pages suivantes :

- `ActivitiesScreen`: L'écran principal qui affiche les activités disponibles.
- `ActivityDetailPage`: Une page qui montre les détails d'une activité spécifique.
- `AddActivityScreen`: Un formulaire pour ajouter de nouvelles activités à la base de données.
- `LoginScreen`: Un écran pour que les utilisateurs puissent se connecter ou s'inscrire.
- `YourProfilePageWidget`: Affiche le profil de l'utilisateur actuel avec des options pour se déconnecter ou modifier le profil.
- `YourCartPageWidget`: Montre les activités que l'utilisateur a ajoutées à son panier.
- `NextPage`: Une page de transition après certaines actions de l'utilisateur.

## Test de l'Application

Pour tester l'application, vous pouvez utiliser les identifiants suivants ou créer votre propre compte :
Email: salim2@gmail.com
Mot de Passe: Salim2001
ou sinon une inscription puis se connecter. 

Veuillez noter que ces informations sont fournies uniquement à des fins de test.

## Installation

Pour exécuter l'application, vous aurez besoin de Flutter installé sur votre système. Après avoir cloné le dépôt, exécutez les commandes suivantes dans le répertoire de votre projet :

```sh
flutter pub get
flutter run
