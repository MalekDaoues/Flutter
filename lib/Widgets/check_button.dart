import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../Screens/cart_screen.dart';
import '../controller/Cart_controller.dart';
import '../controller/home_ controller.dart';

class CheckoutButton extends StatefulWidget {
  final String name; // Nom du produit
  final double price; // Prix du produit

  // Constructeur de la classe CheckoutButton
  CheckoutButton({required this.name, required this.price});

  @override
  _CheckoutButtonState createState() => _CheckoutButtonState();
}

class _CheckoutButtonState extends State<CheckoutButton> {
  final CartController cartController = Get.put(CartController()); // Contrôleur de panier via Get.put
  final HomeController homeController = Get.put(HomeController()); // Contrôleur de la page d'accueil via Get.put

  bool isSold = false; // Variable pour vérifier si le produit est vendu

  @override
  void initState() {
    super.initState();
  }

  // Fonction pour basculer la vente du produit
  void toggleSellings() {
    setState(() {
      isSold = cartController.isProductInSellings(widget.name, widget.price); // Vérification si le produit est vendu
    });

    if (isSold == false) {
      // Ajout du produit aux articles vendus via le contrôleur de panier
      cartController.addToSellings(widget.name, widget.price);

      // Affichage d'une notification toast pour indiquer l'ajout au panier
      Fluttertoast.showToast(
        msg: 'Product added to cart!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } else {
      // Affichage d'une notification toast si le produit est déjà dans le panier
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
                toggleSellings(); // Appel de la fonction pour basculer la vente du produit
              });
              Get.to(CartScreen(widget.name, widget.price)); // Navigation vers l'écran du panier
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 100), // Remplissage interne
              decoration: BoxDecoration(
                color: Color(0xFFFD725A), // Couleur du bouton
                borderRadius: BorderRadius.circular(30), // Bordures arrondies
              ),
              child: Text(
                "Pass command", // Texte du bouton
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                  color: Colors.white.withOpacity(0.9), // Couleur du texte
                ),
              ),
            ),
          );
        });
  }
}
