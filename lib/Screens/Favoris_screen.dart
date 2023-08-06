
import 'package:e_shop/controller/Favorite_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Widgets/Product_card.dart';

class FavoritesScreen extends StatelessWidget {
  final FavoritesController favoritesController = Get.put(FavoritesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
        backgroundColor: Color(0xFFFd725A),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
      body: GetBuilder<FavoritesController>(
        init: FavoritesController(),
          builder: (controller) {
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
                          return ProductCard(name, price);
                        }

                        return OverflowBox(
                          maxHeight: 290.0 + 70.0,
                          child: Container(
                            margin: const EdgeInsets.only(top: 70),
                            child: ProductCard(name, price),
                          ),
                        );
                      }

                      // Return a default widget for out of range items
                      return Container();
                    },
                  ),
                ),
              ),
            );
          }),
    );
  }

  double calculateAspectRatio(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = screenWidth - 30 - 15;
    return itemWidth / (2 * 290);
  }

  double calculateGridViewHeight(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    // Adjust this height according to your layout requirements
    return screenHeight - kToolbarHeight - 16;
  }
}
