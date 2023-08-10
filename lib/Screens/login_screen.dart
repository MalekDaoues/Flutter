import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import '../DataBase/auth_controller.dart';
import 'registration_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Message d'erreur lors de la connexion
  String? errorMessage = '';
  // Variable pour indiquer si l'utilisateur est en mode connexion inscription
  bool isLogin = true;
  // Variable pour indiquer si l'utilisateur est en train de se connecter
  bool isLoggingIn = false;
  // Contrôleur pour la gestion de l'authentification
  final AuthController authController = Get.find<AuthController>();
  // Contrôleurs pour les champs de saisie de l'email et du mot de passe
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Fonction pour la connexion avec l'email et le mot de passe
  Future<void> signInWithEmailAndPassword() async {
    setState(() {
      errorMessage = '';
      isLoggingIn = true;
    });

    try {
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      if (userCredential.user != null) {
        // Récupérer l'utilisateur depuis Firestore et sauvegarder l'état de connexion localement
        await authController.getUserFromFirestore();
        authController.saveLoginStatus(true);
      }

      Get.back(); // Retourner à l'écran précédent
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoggingIn = false;
        if (e.code == 'user-not-found') {
          // L'email n'existe pas dans la base de données
          errorMessage = "No account found with this email.";
        } else if (e.code == 'wrong-password') {
          // Le mot de passe est incorrect
          errorMessage =  "Incorrect password";
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: const Color(0xFFFD725A),
      ),
      body: KeyboardDismisser(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController, // Contrôleur pour le champ de saisie de l'email
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: passwordController, // Contrôleur pour le champ de saisie du mot de passe
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true, // Masquer le texte saisi (mot de passe)
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: isLoggingIn ? null : signInWithEmailAndPassword,
                // Désactiver le bouton lors de la connexion en cours
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(const Color(0xFFFD725A)),
                ),
                child: isLoggingIn
                    ? CircularProgressIndicator()
                    : const Text('Login'),
              ),
              if (errorMessage != null && errorMessage!.isNotEmpty)
                Text(
                  errorMessage!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              TextButton(
                onPressed: () {
                  setState(() {
                    isLogin = !isLogin; // Changer le mode entre connexion et inscription
                  });
                  Get.to(RegistrationScreen()); // Naviguer vers l'écran d'inscription
                },
                child: const Text(
                  'register', // Texte pour passer à l'inscription
                  style: TextStyle(
                    color: Color(0xFFFD725A),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
