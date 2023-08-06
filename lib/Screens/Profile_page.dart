
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

  final AuthController authController = Get.find<AuthController>();



    void _showEditDialog(String fieldTitle, String initialValue, Function(String) onSave) {
      String editedValue = initialValue;

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Edit $fieldTitle'),
          content: TextField(
            onChanged: (value) {
              editedValue = value;
            },
            controller: TextEditingController(text: initialValue),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                onSave(editedValue);
                Get.back();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFD725A), // Set the background color of the "Save" button
              ),
              child: const Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Color(0xFFFD725A)), // Set the text color of the "Cancel" button
              ),
            ),
          ],
        ),
      );
    }

  void handleEditName() {
    _showEditDialog('Name', '${authController.name.value} ${authController.prename.value}', (newValue) {
      final names = newValue.split(' ');
      authController.setName(names[0]);
      if (names.length > 1) {
        authController.setPrename(names[1]);
      }
      authController.saveUserToFirestore();
      authController.saveUserLocally();
    });
  }

  void handleEditPhoneNumber() {
    _showEditDialog('Phone Number', authController.phoneNumber.value ?? '', (newValue) {
      authController.setPhoneNumber(newValue);
      authController.saveUserToFirestore();
      authController.saveUserLocally();
    });
  }

  void handleEditEmail() {
    _showEditDialog('Email', authController.email.value ?? '', (newValue) {
      authController.setEmail(newValue);
      authController.saveUserToFirestore();
      authController.saveUserLocally();
    });
  }

  void handleEditCountry() {
    _showEditDialog('Country', authController.country.value ?? '', (newValue) {
      authController.setCountry(newValue);
      authController.saveUserToFirestore();
      authController.saveUserLocally();
    });
  }





  Future<void> signOut() async {
    try {
      await authController.signOut();
      authController.isLoggedIn.value = false;
      authController.saveLoginStatus(false);
      authController.saveUserLocally();// Save login status locally
      // After signing out, navigate to the home screen
      Get.to(LoginScreen());
    } catch (e) {
      // Handle sign out error
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
            Get.to(Dashboard());
          },
        ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
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
                    onPressed: handleEditName,
                  ),
                ],
              ),
              subtitle: Obx(() => Text('${authController.name.value} ${authController.prename.value}')),
            ),
            ListTile(
              title: Row(
                children: [
                  Text('Phone Number'),
                  Spacer(),
                  IconButton(
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.redAccent,
                    ),
                    onPressed: handleEditPhoneNumber,
                  ),
                ],
              ),
              subtitle: Obx(() => Text('${authController.phoneNumber.value}')),
            ),
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
                    onPressed: handleEditEmail,
                  ),
                  SizedBox(width: 8),
                ],
              ),
              subtitle: Obx(() => Text('${authController.email.value}')),
            ),
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
                    onPressed: handleEditCountry,
                  ),
                ],
              ),
              subtitle: Obx(() => Text('${authController.country.value}')),
            ),
          ],
        ),
      ),

          floatingActionButton: FloatingActionButton(
            onPressed: () {
            signOut();
            },
            child: Icon(Icons.exit_to_app),
            backgroundColor: Colors.redAccent,
            ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
