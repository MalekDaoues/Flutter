import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  RxBool isLoggedIn = false.obs;

  FirebaseAuth _auth = FirebaseAuth.instance;

  Rx<User?> user = Rx<User?>(null);
  Rx<String?> name = Rx<String?>(null);
  Rx<String?> prename = Rx<String?>(null);
  Rx<String?> phoneNumber = Rx<String?>(null);
  Rx<String?> email = Rx<String?>(null);
  Rx<String?> country = Rx<String?>(null);

  void setName(String value) => name.value = value;
  void setPrename(String value) => prename.value = value;
  void setPhoneNumber(String value) => phoneNumber.value = value;
  void setEmail(String value) => email.value = value;
  void setCountry(String value) => country.value = value;
  final box = GetStorage();



  void saveLoginStatus(bool isLoggedIn) {
    box.write('isLoggedIn', isLoggedIn);
  }

  bool getLoginStatus() {
    return box.read('isLoggedIn') ?? false;
  }

  void loadUserDataLocally() {
    name.value = box.read('name') as String?;
    prename.value = box.read('prename') as String?;
    phoneNumber.value = box.read('phoneNumber') as String?;
    email.value = box.read('email') as String?;
    country.value = box.read('country') as String?;
  }
  void saveUserLocally() {
    box.write('name', name.value);
    box.write('prename', prename.value);
    box.write('phoneNumber', phoneNumber.value);
    box.write('email', email.value);
    box.write('country', country.value);
  }

  void loadUserLocally() {
    name.value = box.read('name') as String?;
    prename.value = box.read('prename') as String?;
    phoneNumber.value = box.read('phoneNumber') as String?;
    email.value = box.read('email') as String?;
    country.value = box.read('country') as String?;
  }
  Future<void> saveUserToFirestore() async {
    try {
      // Make sure the user is logged in
      if (user.value != null) {
        final uid = user.value!.uid;
        // Reference to the Firestore collection where user data will be stored
        final userRef = FirebaseFirestore.instance.collection('users');

        // Create a document with the user's UID and set the data
        await userRef.doc(uid).set({
          'name': name.value,
          'prename': prename.value,
          'phoneNumber': phoneNumber.value,
          'email': email.value,
          'country': country.value,
        });

        saveUserLocally(); // Save user information locally after updating Firestore
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> getUserFromFirestore() async {
    try {
      if (user.value != null) {
        final uid = user.value!.uid;
        final userRef = FirebaseFirestore.instance.collection('users');

        final docSnapshot = await userRef.doc(uid).get();
        if (docSnapshot.exists) {
          name.value = docSnapshot['name'];
          prename.value = docSnapshot['prename'];
          phoneNumber.value = docSnapshot['phoneNumber'];
          email.value = docSnapshot['email'];
          country.value = docSnapshot['country'];
          saveUserLocally(); // Save user information locally after fetching from Firestore
        }
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  void onInit() {
    super.onInit();
    isLoggedIn.value = getLoginStatus();

    _auth.authStateChanges().listen((User? firebaseUser) {
      user.value = firebaseUser;
      isLoggedIn.value = firebaseUser != null;
      if (isLoggedIn.value) {
        getUserFromFirestore(); // Fetch user data from Firestore and update locally on login
      } else {
        // Clear user data locally when the user logs out
        name.value = null;
        prename.value = null;
        phoneNumber.value = null;
        email.value = null;
        country.value = null;
        saveUserLocally();
      }
    });
  }



  // Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      box.erase(); // Clear all data from local storage on sign out
    } catch (e) {
      throw e;
    }
  }
}