import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/Cart_controller.dart';
import '../controller/Favorite_controller.dart';



class CartItemSamples extends StatefulWidget {
  final FavoritesController favoritesController = Get.find<FavoritesController>();
  final String name;
  final double price;
  CartItemSamples(this.name , this.price);

  @override
  _CartItemSamplesState createState() => _CartItemSamplesState();
}

class _CartItemSamplesState extends State<CartItemSamples> {
  final CartController cartController = Get.put(CartController());
  List<Map<String, dynamic>> selectedProducts = [];
  bool selected = false;

  @override
  void initState() {
    super.initState();
    selectedProducts = cartController.selectedProducts;
      selected = cartController.isSelected(widget.name, widget.price);
    }

  void toggleProductSelection(bool? value) {
    setState(() {
      selected =!selected;
      cartController.updateProductSelection(widget.name, selected);

    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
        init: CartController(),
    builder: (controller) {
      return Container(
        height: 110,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
             Checkbox(
              activeColor: Color(0xFFFd725A),
              value: selected,
              onChanged: toggleProductSelection,
            ),

            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 224, 224, 244),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(
                "images/${widget.name}.webp",
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                    Text(
                      '\$${widget.price}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFD725A),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.redAccent,
              ),
              onPressed: () {
                setState(() {
                  cartController.removeFromSellings(widget.name, widget.price);

                });
                // Handle delete action
              },
            ),
          ],
        ),
      );

    });
  }
}
