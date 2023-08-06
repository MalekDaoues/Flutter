import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../Screens/cart_screen.dart';
import '../controller/Cart_controller.dart';
import '../controller/home_ controller.dart';

class CheckoutButton extends StatefulWidget {
  final String name;
  final double price;

  CheckoutButton({required this.name, required this.price});

  @override
  _CheckoutButtonState createState() => _CheckoutButtonState();
}

class _CheckoutButtonState extends State<CheckoutButton> {
  final CartController cartController = Get.put(CartController());
  final HomeController homeController = Get.put(HomeController());

  bool isSold = false;

  @override
  void initState() {
    super.initState();

  }

  void toggleSellings() {
    setState(() {
      isSold = cartController.isProductInSellings(widget.name, widget.price);
    });
    if (isSold==false) {
      cartController.addToSellings(widget.name, widget.price);
      Fluttertoast.showToast(
        msg: 'Product added to cart!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } else {
      Fluttertoast.showToast(
        msg: 'Product already in cart',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
     return GetBuilder<CartController>(
        init: CartController(),
         builder: (controller) {
           return InkWell(
             onTap: () {
               setState(() {
                 toggleSellings();
               });
                 Get.to(CartScreen(widget.name, widget.price));
             },
             child: Container(
               padding: EdgeInsets.symmetric(vertical: 20, horizontal: 100),
               decoration: BoxDecoration(
                 color: Color(0xFFFD725A),
                 borderRadius: BorderRadius.circular(30),
               ),
               child: Text(
                 "Pass command",
                 style: TextStyle(
                   fontSize: 17,
                   fontWeight: FontWeight.w600,
                   letterSpacing: 1,
                   color: Colors.white.withOpacity(0.9),
                 ),
               ),
             ),
           );
         });
  }
}
