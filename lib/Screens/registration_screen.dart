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
  String? errorMessage = '';
  final TextEditingController nameController = TextEditingController();
  final TextEditingController prenameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final AuthController authController = Get.find<AuthController>();
  CountryCode? selectedCountry;
  String? selectedCountryName;

  @override
  void initState() {
    super.initState();
    countryController.text = selectedCountryName ?? '';
  }

  Future<void> createUserWithEmailAndPassword(BuildContext context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      authController.setName(nameController.text);
      authController.setPrename(prenameController.text);
      authController.setPhoneNumber(phoneNumberController.text);
      authController.setEmail(emailController.text);
      authController.setCountry(countryController.text);
      authController.isLoggedIn.value=true;


      await authController.saveUserToFirestore();
      authController.saveUserLocally();

      Get.off(ProfilePage());
    } catch (e) {
      // Handle error
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
                            selectedCountry = code;
                            selectedCountryName = code?.name;
                            countryController.text = selectedCountryName ?? '';
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
                        keyboardType: TextInputType.phone,
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
                  readOnly: true, // Make the text field read-only
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
                    labelText: 'Password',
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    createUserWithEmailAndPassword(context);
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
