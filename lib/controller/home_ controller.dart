import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  int selectedIndex = 0; // Index de l'onglet sélectionné dans la page d'accueil
  String selectedCategory = 'All'; // Catégorie sélectionnée dans la page d'accueil
  String cartProductName = ''; // Nom du produit ajouté au panier
  double cartProductPrice = 0.0; // Prix du produit ajouté au panier
  final FirebaseFirestore firestore = FirebaseFirestore.instance; // Instance de Firestore pour interagir avec la base de données
  RxList<Map<String, dynamic>> filteredProducts = <Map<String, dynamic>>[].obs; // Liste observée des produits filtrés

  @override
  void onInit() {
    super.onInit();
    // Cette méthode est appelée lorsque le contrôleur est initialisé
  }

  // Méthode pour obtenir le produit ajouté au panier
  void getCartProduct(String name, double price) {
    cartProductName = name;
    cartProductPrice = price;
    update();
  }

  // Méthode pour changer l'index de l'onglet sélectionné dans la page d'accueil
  void changeSelectedIndex(int index) {
    selectedIndex = index;
    update();
  }
}
