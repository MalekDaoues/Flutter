
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
  String? errorMessage = '';
  bool isLogin = true;
  bool isLoggingIn = false;
  final AuthController authController = Get.find<AuthController>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


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
        await authController.getUserFromFirestore();
        authController.saveLoginStatus(true); // Save login status locally
      }

      Get.back();
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoggingIn = false;
        if (e.code == 'user-not-found') {
          // The email does not exist
          errorMessage = "No account found with this email.";
        } else if (e.code == 'wrong-password') {
          // The password is incorrect
          errorMessage = "Incorrect password.";
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
                controller: emailController, // Added controller here
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: passwordController, // Added controller here
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: isLoggingIn ? null : signInWithEmailAndPassword,
                // Disable button when logging in
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
                    isLogin = !isLogin;
                  });
                  Get.to(RegistrationScreen()); // Navigate to the RegistrationScreen
                },
                child: const Text(
                  'Register instead',
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