import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  RxBool isLoggedIn = false.obs; // Variable observable pour vérifier si l'utilisateur est connecté
  final box = GetStorage(); // Instance de GetStorage pour gérer le stockage local des données utilisateur
  FirebaseAuth _auth = FirebaseAuth.instance; // Instance de Firebase Auth pour gérer l'authentification de l'utilisateur

  // Variables observables pour stocker les informations de l'utilisateur
  Rx<User?> user = Rx<User?>(null);
  Rx<String?> name = Rx<String?>(null);
  Rx<String?> prename = Rx<String?>(null);
  Rx<String?> phoneNumber = Rx<String?>(null);
  Rx<String?> email = Rx<String?>(null);
  Rx<String?> country = Rx<String?>(null);

  // Méthodes pour mettre à jour les variables observables avec les informations de l'utilisateur
  void setName(String value) => name.value = value;
  void setPrename(String value) => prename.value = value;
  void setPhoneNumber(String value) => phoneNumber.value = value;
  void setEmail(String value) => email.value = value;
  void setCountry(String value) => country.value = value;


  // Méthode pour enregistrer l'état de connexion de l'utilisateur localement
  void saveLoginStatus(bool isLoggedIn) {
    box.write('isLoggedIn', isLoggedIn);
  }

  // Méthode pour obtenir l'état de connexion de l'utilisateur localement
  bool getLoginStatus() {
    return box.read('isLoggedIn') ?? false;
  }

  // Méthode pour charger les données utilisateur localement
  void loadUserDataLocally() {
    name.value = box.read('name') as String?;
    prename.value = box.read('prename') as String?;
    phoneNumber.value = box.read('phoneNumber') as String?;
    email.value = box.read('email') as String?;
    country.value = box.read('country') as String?;
  }

  // Méthode pour sauvegarder les données utilisateur localement
  void saveUserLocally() {
    box.write('name', name.value);
    box.write('prename', prename.value);
    box.write('phoneNumber', phoneNumber.value);
    box.write('email', email.value);
    box.write('country', country.value);
  }

  // Méthode pour charger les données utilisateur depuis Firestore
  Future<void> getUserFromFirestore() async {
    try {
      if (user.value != null) {
        final uid = user.value!.uid;
        final userRef = FirebaseFirestore.instance.collection('users');

        final docSnapshot = await userRef.doc(uid).get();
        if (docSnapshot.exists) {
          // Mettre à jour les variables observables avec les données utilisateur de Firestore
          name.value = docSnapshot['name'];
          prename.value = docSnapshot['prename'];
          phoneNumber.value = docSnapshot['phoneNumber'];
          email.value = docSnapshot['email'];
          country.value = docSnapshot['country'];
          saveUserLocally(); // Sauvegarder les données utilisateur localement après avoir récupéré depuis Firestore
        }
      }
    } catch (e) {
      throw e;
    }
  }

  // Méthode pour sauvegarder les données utilisateur dans Firestore
  Future<void> saveUserToFirestore() async {
    try {
      // Assurez-vous que l'utilisateur est connecté
      if (user.value != null) {
        final uid = user.value!.uid;
        // Référence à la collection Firestore où les données utilisateur seront stockées
        final userRef = FirebaseFirestore.instance.collection('users');

        // Créer un document avec l'UID de l'utilisateur et définir les données
        await userRef.doc(uid).set({
          'name': name.value,
          'prename': prename.value,
          'phoneNumber': phoneNumber.value,
          'email': email.value,
          'country': country.value,
        });

        saveUserLocally(); // Sauvegarder les données utilisateur localement après la mise à jour de Firestore
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  void onInit() {
    super.onInit();
    isLoggedIn.value = getLoginStatus(); // Charger l'état de connexion de l'utilisateur

    // Écouter les modifications de l'état d'authentification de Firebase
    _auth.authStateChanges().listen((User? firebaseUser) {
      user.value = firebaseUser; // Mettre à jour la variable observable 'user' avec l'utilisateur actuel
      isLoggedIn.value = firebaseUser != null; // Mettre à jour l'état de connexion de l'utilisateur

      if (isLoggedIn.value) {
        getUserFromFirestore(); // Récupérer les données utilisateur depuis Firestore et mettre à jour localement à la connexion
      } else {
        // Effacer les données utilisateur localement lorsque l'utilisateur se déconnecte
        name.value = null;
        prename.value = null;
        phoneNumber.value = null;
        email.value = null;
        country.value = null;
        saveUserLocally();
      }
    });
  }

  // Méthode pour déconnecter l'utilisateur
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      box.erase(); // Effacer toutes les données du stockage local à la déconnexion
    } catch (e) {
      throw e;
    }
  }
}