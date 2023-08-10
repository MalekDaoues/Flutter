import 'package:e_shop/Widgets/quantity_options.dart';
import 'package:e_shop/Widgets/size_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import '../controller/Cart_controller.dart';
import 'check_button.dart';
import 'color_options.dart';
import 'custom_divider.dart';

// Classe représentant le bas de page personnalisé
class CustomBottomSheet extends StatelessWidget {
  final String name; // Nom du produit
  final double price; // Prix du produit

  // Constructeur de la classe CustomBottomSheet
  CustomBottomSheet(this.name, this.price);

  // Liste des tailles disponibles pour le produit
  List<String> sizes = ['S', 'M', 'L', 'XL'];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>( // Utilisation de GetBuilder pour accéder à l'état du contrôleur de panier
        init: CartController(), // Initialisation du contrôleur de panier
        builder: (controller) { // Fonction de génération de widgets basée sur l'état du contrôleur
          return Container(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 50),
            decoration: const BoxDecoration(
              color: Colors.white, // Couleur de fond du conteneur
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), // Bord supérieur gauche arrondi
                topRight: Radius.circular(30), // Bord supérieur droit arrondi
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Ajustement de la hauteur de la colonne en fonction de son contenu
              children: [
                SizedBox(height: 10), // Espace vide de 10 pixels
                CustomDivider(), // Utilisation du widget de séparation personnalisé
                SizedBox(height: 20),
                SizeOptions(sizes: sizes), // Utilisation du widget de sélection de taille avec la liste des tailles
                SizedBox(height: 10),
                ColorOptions(), // Utilisation du widget de sélection de couleur
                SizedBox(height: 10),
                QuantitySelector(), // Utilisation du widget de sélection de quantité
                SizedBox(height: 30),
                CheckoutButton(name: name, price: price), // Utilisation du bouton de vérification avec le nom et le prix du produit
              ],
            ),
          );
        });
  }
}















