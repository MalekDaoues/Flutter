
import 'package:get/get.dart';

class FavoritesController extends GetxController {
  final favorites = <Map<String, dynamic>>[].obs;

  void addToFavorites(String name, double price) {
    favorites.add({'name': name, 'price': price});
    update();
  }

  void removeFromFavorites(String name, double price) {
    favorites.removeWhere(
          (item) => item['name'] == name && item['price'] == price,
    );
    update();
  }
  bool isProductInFavorites(String name, double price) {
    return favorites.any((item) => item['name'] == name && item['price'] == price);
  }

}