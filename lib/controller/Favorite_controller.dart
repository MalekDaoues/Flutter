import 'package:get/get.dart';

class FavoritesController extends GetxController {
  final favorites = <Map<String, dynamic>>[].obs; // Liste observée des produits favoris

  // Méthode pour ajouter un produit aux favoris
  void addToFavorites(String name, double price) {
    favorites.add({'name': name, 'price': price});
    update();
  }

  // Méthode pour supprimer un produit des favoris
  void removeFromFavorites(String name, double price) {
    favorites.removeWhere(
          (item) => item['name'] == name && item['price'] == price,
    );
    update();
  }

  // Vérifier si un produit spécifique est dans la liste des favoris
  bool isProductInFavorites(String name, double price) {
    return favorites.any((item) => item['name'] == name && item['price'] == price);
  }
}
