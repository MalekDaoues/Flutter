import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


// Classe représentant le sélecteur de quantité
class QuantitySelector extends StatefulWidget {
  @override
  _QuantitySelectorState createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  int quantity = 1; // Quantité sélectionnée

  // Fonction pour augmenter la quantité
  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  // Fonction pour diminuer la quantité
  void decrementQuantity() {
    setState(() {
      if (quantity > 1) {
        quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          "Quantité",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 30),
        GestureDetector(
          onTap: decrementQuantity,
          child: QuantityButton(icon: CupertinoIcons.minus), // Bouton de diminution de quantité
        ),
        SizedBox(width: 8),
        Text(
          quantity.toString().padLeft(2, '0'), // Affichage de la quantité actuelle
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(width: 8),
        GestureDetector(
          onTap: incrementQuantity,
          child: QuantityButton(icon: CupertinoIcons.plus), // Bouton d'augmentation de quantité
        ),
      ],
    );
  }
}

// Classe représentant le bouton de quantité
class QuantityButton extends StatelessWidget {
  final IconData icon;

  const QuantityButton({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      padding: EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Color(0xFFF7F8FA), // Couleur de fond du bouton
        borderRadius: BorderRadius.circular(20), // Bordures arrondies du bouton
      ),
      child: Icon(
        icon,
        size: 18,
        color: Colors.redAccent, // Couleur de l'icône du bouton
      ),
    );
  }
}