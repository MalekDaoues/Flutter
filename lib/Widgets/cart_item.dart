import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/Cart_controller.dart';
import '../controller/Favorite_controller.dart';



// Classe représentant un échantillon d'article dans le panier
class CartItemSamples extends StatefulWidget {
  // Récupération du contrôleur de favoris via Get.find
  final FavoritesController favoritesController = Get.find<FavoritesController>();
  final String name; // Nom de l'article
  final double price; // Prix de l'article

  // Constructeur de la classe CartItemSamples
  CartItemSamples(this.name , this.price);

  @override
  _CartItemSamplesState createState() => _CartItemSamplesState();
}

class _CartItemSamplesState extends State<CartItemSamples> {
  // Initialisation du contrôleur de panier via Get.put
  final CartController cartController = Get.put(CartController());
  List<Map<String, dynamic>> selectedProducts = []; // Liste des produits sélectionnés
  bool selected = false; // Variable pour déterminer si l'article est sélectionné

  @override
  void initState() {
    super.initState();
    // Récupération des produits sélectionnés à partir du contrôleur de panier
    selectedProducts = cartController.selectedProducts;
    // Vérification si l'article est sélectionné
    selected = cartController.isSelected(widget.name, widget.price);
  }

  // Fonction pour basculer la sélection de l'article
  void toggleProductSelection(bool? value) {
    setState(() {
      selected = !selected; // Inversion de la valeur de sélection
      // Mise à jour de la sélection du produit dans le contrôleur de panier
      cartController.updateProductSelection(widget.name, selected);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
        init: CartController(),
        builder: (controller) {
          return Container(
            height: 110, // Hauteur du conteneur de l'article
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15), // Marges extérieures
            padding: EdgeInsets.all(10), // Remplissage intérieur
            decoration: BoxDecoration(
              color: Colors.white, // Couleur de fond du conteneur
              borderRadius: BorderRadius.circular(10), // Bordures arrondies
            ),
            child: Row(
              children: [
                // Checkbox pour la sélection de l'article
                Checkbox(
                  activeColor: Color(0xFFFd725A), // Couleur de la checkbox active
                  value: selected, // État de la sélection
                  onChanged: toggleProductSelection, // Action de basculement de la sélection
                ),
                // Conteneur pour l'image de l'article
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 224, 224, 244), // Couleur de fond du conteneur
                    borderRadius: BorderRadius.circular(10), // Bordures arrondies
                  ),
                  child: Image.asset(
                    "images/${widget.name}.webp", // Chemin vers l'image de l'article
                  ),
                ),
                // Colonne contenant le nom et le prix de l'article
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10), // Marge horizontale
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // Alignement à gauche
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Espacement entre les éléments
                      children: [
                        Text(
                          widget.name, // Nom de l'article
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(0.7), // Couleur du texte
                          ),
                        ),
                        Text(
                          '\$${widget.price}', // Prix de l'article
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFD725A), // Couleur du texte
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(), // Espaceur pour pousser l'icône à droite
                // Icône de suppression de l'article
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.redAccent, // Couleur de l'icône
                  ),
                  onPressed: () {
                    setState(() {
                      // Suppression de l'article du panier via le contrôleur de panier
                      cartController.removeFromSellings(widget.name, widget.price);
                    });
                  },
                ),
              ],
            ),
          );
        });
  }
}