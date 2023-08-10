
import 'package:country_code_picker/country_code_picker.dart';
import 'package:e_shop/Screens/Profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import '../DataBase/auth_controller.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String? errorMessage = ''; // Variable pour stocker un message d'erreur éventuel
  final TextEditingController nameController = TextEditingController();
  final TextEditingController prenameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final AuthController authController = Get.find<AuthController>();
  CountryCode? selectedCountry; // Variable pour stocker le code du pays sélectionné
  String? selectedCountryName; // Variable pour stocker le nom du pays sélectionné

  @override
  void initState() {
    super.initState();
    countryController.text = selectedCountryName ?? ''; // Initialisation du contrôleur du champ de texte du pays avec le nom du pays sélectionné (s'il existe)
  }

  // Méthode pour créer un utilisateur avec une adresse e-mail et un mot de passe
  Future<void> createUserWithEmailAndPassword(BuildContext context) async {
    try {
      // Crée un utilisateur avec l'adresse e-mail et le mot de passe fournis
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Met à jour les informations de l'utilisateur dans le contrôleur d'authentification (AuthController)
      authController.setName(nameController.text);
      authController.setPrename(prenameController.text);
      authController.setPhoneNumber(phoneNumberController.text);
      authController.setEmail(emailController.text);
      authController.setCountry(countryController.text);
      authController.isLoggedIn.value = true;

      // Sauvegarde les informations de l'utilisateur dans Firestore et localement
      await authController.saveUserToFirestore();
      authController.saveUserLocally();

      // Navigue vers la page du profil (ProfilePage)
      Get.off(ProfilePage());
    } catch (e) {
      // Gère les erreurs éventuelles
      // Vous pouvez utiliser la variable errorMessage pour afficher un message d'erreur à l'utilisateur
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
        backgroundColor: Color(0xFFFD725A),
      ),
      body: KeyboardDismisser(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: prenameController,
                  decoration: const InputDecoration(
                    labelText: 'Prename',
                  ),
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: CountryCodePicker(
                        onChanged: (CountryCode? code) {
                          setState(() {
                            selectedCountry = code; // Met à jour le code du pays sélectionné
                            selectedCountryName = code?.name; // Met à jour le nom du pays sélectionné
                            countryController.text = selectedCountryName ?? ''; // Met à jour le contrôleur du champ de texte du pays avec le nom du pays sélectionné
                          });
                        },
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller: phoneNumberController,
                        decoration: const InputDecoration(
                          labelText: 'Phone Number',
                        ),
                        keyboardType: TextInputType.phone, // Type de clavier du champ de texte pour le numéro de téléphone
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16.0),
                TextFormField(
                  controller: countryController,
                  decoration: const InputDecoration(
                    labelText: 'Country',
                  ),
                  readOnly: true, // Rend le champ de texte en lecture seule pour empêcher l'édition directe
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password', // Étiquette du champ de texte "Password"
                  ),
                  obscureText: true, // Cache le texte du champ de texte pour afficher les caractères spéciaux sous forme de points
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                  ),
                  obscureText: true, // Cache le texte du champ de texte pour afficher les caractères spéciaux sous forme de points
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    createUserWithEmailAndPassword(context); // Appelle la méthode createUserWithEmailAndPassword
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFFD725A)),
                  ),
                  child: Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
