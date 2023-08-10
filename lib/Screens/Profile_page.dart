import 'package:e_shop/Screens/login_screen.dart';
import 'package:e_shop/Widgets/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../DataBase/auth_controller.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Initialisation du contrôleur d'authentification (AuthController)
  final AuthController authController = Get.find<AuthController>();

  // Méthode pour afficher une boîte de dialogue d'édition avec un champ de texte
  void _showEditDialog(String fieldTitle, String initialValue, Function(String) onSave) {
    String editedValue = initialValue;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Edit $fieldTitle'), // Titre de la boîte de dialogue
        content: TextField(
          onChanged: (value) {
            editedValue = value;
          },
          controller: TextEditingController(text: initialValue),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              onSave(editedValue); // Appel de la fonction onSave avec la nouvelle valeur éditée
              Get.back(); // Fermeture de la boîte de dialogue
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFFD725A),
            ),
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back(); // Fermeture de la boîte de dialogue sans sauvegarder
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: Color(0xFFFD725A)),
            ),
          ),
        ],
      ),
    );
  }

  // Méthodes pour gérer l'édition de différentes informations (nom, numéro de téléphone, e-mail, pays)
  void handleEditName() {
    _showEditDialog('Name', '${authController.name.value} ${authController.prename.value}', (newValue) {
      final names = newValue.split(' ');
      authController.setName(names[0]); // Mise à jour du nom de l'utilisateur
      if (names.length > 1) {
        authController.setPrename(names[1]); // Mise à jour du prénom de l'utilisateur s'il est fourni
      }
      authController.saveUserToFirestore(); // Sauvegarde des informations de l'utilisateur dans Firestore
      authController.saveUserLocally(); // Sauvegarde des informations de l'utilisateur localement
    });
  }

  void handleEditPhoneNumber() {
    _showEditDialog('Phone Number', authController.phoneNumber.value ?? '', (newValue) {
      authController.setPhoneNumber(newValue); // Mise à jour du numéro de téléphone de l'utilisateur
      authController.saveUserToFirestore(); // Sauvegarde des informations de l'utilisateur dans Firestore
      authController.saveUserLocally(); // Sauvegarde des informations de l'utilisateur localement
    });
  }

  void handleEditEmail() {
    _showEditDialog('Email', authController.email.value ?? '', (newValue) {
      authController.setEmail(newValue); // Mise à jour de l'e-mail de l'utilisateur
      authController.saveUserToFirestore(); // Sauvegarde des informations de l'utilisateur dans Firestore
      authController.saveUserLocally(); // Sauvegarde des informations de l'utilisateur localement
    });
  }

  void handleEditCountry() {
    _showEditDialog('Country', authController.country.value ?? '', (newValue) {
      authController.setCountry(newValue); // Mise à jour du pays de l'utilisateur
      authController.saveUserToFirestore(); // Sauvegarde des informations de l'utilisateur dans Firestore
      authController.saveUserLocally(); // Sauvegarde des informations de l'utilisateur localement
    });
  }

  // Méthode pour se déconnecter de l'application
  Future<void> signOut() async {
    try {
      await authController.signOut(); // Déconnexion de l'utilisateur en utilisant le contrôleur d'authentification
      authController.isLoggedIn.value = false; // Met à jour l'état de connexion de l'utilisateur à false
      authController.saveLoginStatus(false); // Sauvegarde l'état de connexion localement
      // Après la déconnexion, navigue vers l'écran de connexion (LoginScreen)
      Get.to(LoginScreen());
    } catch (e) {
      // Gère les erreurs de déconnexion
      print('Error signing out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
        backgroundColor: Color(0xFFFD725A),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Get.to(Dashboard()); // Navigue vers l'écran du tableau de bord lorsque l'icône est cliquée
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Liste  pour afficher le nom de l'utilisateur et un bouton d'édition
            ListTile(
              title: Row(
                children: [
                  Text('Name'),
                  Spacer(),
                  IconButton(
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.redAccent,
                    ),
                    onPressed: handleEditName, // Appelle la méthode handleEditName lorsque l'icône d'édition est cliquée
                  ),
                ],
              ),
              subtitle: Obx(() => Text('${authController.name.value} ${authController.prename.value}')), // Affiche le nom complet de l'utilisateur en utilisant des observables (Obx)
            ),
            // Liste de carreaux pour afficher le numéro de téléphone de l'utilisateur et un bouton d'édition
            ListTile(
              title: Row(
                children: [
                  Text('Phone Number'), // Texte "Phone Number"
                  Spacer(),
                  IconButton(
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.redAccent,
                    ),
                    onPressed: handleEditPhoneNumber, // Appelle la méthode handleEditPhoneNumber lorsque l'icône d'édition est cliquée
                  ),
                ],
              ),
              subtitle: Obx(() => Text('${authController.phoneNumber.value}')), // Affiche le numéro de téléphone de l'utilisateur en utilisant un observable (Obx)
            ),
            // Liste pour afficher l'e-mail de l'utilisateur et un bouton d'édition
            ListTile(
              title: Row(
                children: [
                  Text('Email'),
                  Spacer(),
                  IconButton(
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.redAccent,
                    ),
                    onPressed: handleEditEmail, // Appelle la méthode handleEditEmail lorsque l'icône d'édition est cliquée
                  ),
                  SizedBox(width: 8),
                ],
              ),
              subtitle: Obx(() => Text('${authController.email.value}')), // Affiche l'e-mail de l'utilisateur en utilisant un observable (Obx)
            ),
            // Liste de carreaux pour afficher le pays de l'utilisateur et un bouton d'édition
            ListTile(
              title: Row(
                children: [
                  Text('Country'),
                  Spacer(),
                  IconButton(
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.redAccent,
                    ),
                    onPressed: handleEditCountry, // Appelle la méthode handleEditCountry lorsque l'icône d'édition est cliquée
                  ),
                ],
              ),
              subtitle: Obx(() => Text('${authController.country.value}')), // Affiche le pays de l'utilisateur en utilisant un observable (Obx)
            ),
          ],
        ),
      ),
      // Bouton flottant pour se déconnecter de l'application
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          signOut(); // Appelle la méthode signOut lorsque le bouton flottant est cliqué
        },
        child: Icon(Icons.exit_to_app),
        backgroundColor: Colors.redAccent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, // Position du bouton flottant (centré et ancré)
    );
  }
}
