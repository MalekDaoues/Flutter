
import 'package:e_shop/controller/Favorite_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Widgets/Product_card.dart';

class FavoritesScreen extends StatelessWidget {
  // Contrôleur des favoris pour la gestion des données
  final FavoritesController favoritesController = Get.put(FavoritesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favoris'),
        backgroundColor: Color(0xFFFd725A),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios_new), // Icône de retour
            onPressed: () {
              Get.back(); // Action pour revenir en arrière
            },
          ),
        ],
      ),
      body: GetBuilder<FavoritesController>(
          init: FavoritesController(),
          builder: (controller) {
            // Affiche une liste défilante de produits favoris
            return SingleChildScrollView(
              child: IntrinsicHeight(
                child: SizedBox(
                  height: calculateGridViewHeight(context),
                  child: GridView.builder(
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: calculateAspectRatio(context),
                      mainAxisSpacing: 45,
                      crossAxisSpacing: 15,
                    ),
                    itemCount: favoritesController.favorites.length,
                    itemBuilder: (_, i) {
                      final products = favoritesController.favorites.toList();

                      if (i >= 0 && i < products.length) {
                        final product = products[i];
                        final name = product['name'];
                        final price = product['price'];
                        if (i % 2 == 0) {
                          // Affiche le produit avec ProductCard si l'index est pair
                          return ProductCard(name, price);
                        }

                        // Affiche le produit avec ProductCard dans une boîte débordante si l'index est impair
                        return OverflowBox(
                          maxHeight: 290.0 + 70.0,
                          child: Container(
                            margin: const EdgeInsets.only(top: 70),
                            child: ProductCard(name, price),
                          ),
                        );
                      }

                      // Retourne un widget par défaut pour les éléments hors de la plage
                      return Container();
                    },
                  ),
                ),
              ),
            );
          }),
    );
  }

  // Calcule le ratio hauteur / largeur des éléments de la grille en fonction de la largeur de l'écran
  double calculateAspectRatio(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = screenWidth - 30 - 15;
    return itemWidth / (2 * 290);
  }

  // Calcule la hauteur de la grille de produits en fonction de la hauteur de l'écran et de l'app bar
  double calculateGridViewHeight(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    // Ajustez cette hauteur selon vos besoins de mise en page
    return screenHeight - kToolbarHeight - 16;
  }
}