import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Screens/product_screen.dart';
import '../controller/Cart_controller.dart';
import '../controller/Favorite_controller.dart';

class ProductCard extends StatefulWidget {
  final String name;
  final double price;

  ProductCard(this.name, this.price);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final FavoritesController favoritesController = Get.put(FavoritesController());
  final CartController cartController = Get.put(CartController());
      bool isFavorite = false;

      @override
      void initState() {
  super.initState();
  isFavorite = favoritesController.isProductInFavorites(widget.name, widget.price);
  }

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });

    if (isFavorite) {
      favoritesController.addToFavorites(widget.name, widget.price);
    } else {
      favoritesController.removeFromFavorites(widget.name, widget.price);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: const Color.fromRGBO(255, 224, 224, 224),
                child: Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(ProductScreen(widget.name, widget.price));
                      },
                      child: Image.asset(
                        "images/${widget.name}.webp",
                        fit: BoxFit.cover,
                        height: 200,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF7F8FA),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Obx(
                                () => IconButton(
                              icon: Icon(
                                favoritesController.isProductInFavorites(widget.name, widget.price)
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                size: 20,
                                color: Colors.red,
                              ),
                              onPressed: toggleFavorite,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 3),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${widget.price}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.red.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

  }
}
