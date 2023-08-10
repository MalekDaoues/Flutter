import 'package:e_shop/controller/Cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../DataBase/auth_controller.dart';
import '../Widgets/cart_item.dart';
import 'Payment_Screen.dart';
import 'login_screen.dart';

class CartScreen extends StatefulWidget {
  final String name;
  final double price;

  CartScreen(this.name, this.price);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartController cartController = Get.put(CartController()); // Instanciation et ajout du contrôleur de panier
  final AuthController authController = Get.find<AuthController>(); // Récupération du contrôleur d'authentification
  bool selectAll = false; // Variable pour suivre l'état de la sélection de tous les produits

  @override
  void initState() {
    super.initState();
    selectAll = cartController.selectAll.value; // Récupérer l'état actuel de la sélection de tous les produits
  }

  // Méthode pour basculer la sélection de tous les produits
  void toggleSelectAll(bool? value) {
    setState(() {
      selectAll = !selectAll; // Inverser l'état de la sélection de tous les produits
      cartController.updateProductSelectAll(selectAll);// Mettre à jour la sélection de tous les produits dans le contrôleur de panier
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        backgroundColor: const Color(0xFFFd725A),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
      body: GetBuilder<CartController>(
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  child: cartController.selectedProducts.isEmpty
                      ? const Center(
                    child: Text("No items in the cart."),
                  )
                      : ListView.builder(
                    itemCount: cartController.selectedProducts.length,
                    itemBuilder: (context, index) {
                      return CartItemSamples(
                        cartController.selectedProducts[index]
                        ['name'],
                        cartController.selectedProducts[index]
                        ['price'],
                      );
                    },
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(0, -2),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Select All",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                         Checkbox(
                          activeColor: const Color(0xFFFd725A),
                          value: cartController.selectAll.value,
                          onChanged:
                              toggleSelectAll,

                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Delivery Cost:",
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "\$${cartController.deliveryCost}",
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFFD725A),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Payment:",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black.withOpacity(0.8),
                          ),
                        ),
                        Text(
                          "\$${cartController.totalPayment.value.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFFD725A),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    InkWell(
                      onTap: () {
                        if (authController.isLoggedIn.value) {
                          Get.to(PaymentScreen()); // Aller à l'écran de paiement si l'utilisateur est connecté
                        } else {
                          Get.to(LoginScreen()); // Aller à l'écran de connexion si l'utilisateur n'est pas connecté
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 130),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFD725A),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          "Command", // Bouton de paiement ou connexion
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
