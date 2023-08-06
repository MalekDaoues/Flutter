import 'package:e_shop/Widgets/quantity_options.dart';
import 'package:e_shop/Widgets/size_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import '../controller/Cart_controller.dart';
import 'check_button.dart';
import 'color_options.dart';
import 'custom_divider.dart';

class CustomBottomSheet extends StatelessWidget {
  final String name;
  final double price;
  CustomBottomSheet(this.name, this.price);

  List<String> sizes = ['S', 'M', 'L', 'XL'];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
        init: CartController(),
        builder: (controller) {
          return Container(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 50),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10),
                CustomDivider(),
                SizedBox(height: 20),
                SizeOptions(sizes: sizes),
                SizedBox(height: 10),
                ColorOptions(),
                SizedBox(height: 10),
                QuantitySelector(),
                SizedBox(height: 30),
                CheckoutButton(name: name, price: price),
              ],
            ),
          );
        });
  }
}
















