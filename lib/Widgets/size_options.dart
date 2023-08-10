import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Classe représentant les options de taille
class SizeOptions extends StatefulWidget {
  final List<String> sizes; // Liste des tailles disponibles

  const SizeOptions({required this.sizes});

  @override
  _SizeOptionsState createState() => _SizeOptionsState();
}

class _SizeOptionsState extends State<SizeOptions> {
  String? selectedSize; // Taille sélectionnée

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          "Taille", // Titre des options de taille
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 30),
        for (int i = 0; i < widget.sizes.length; i++)
          GestureDetector(
            onTap: () {
              setState(() {
                selectedSize = widget.sizes[i]; // Met à jour la taille sélectionnée
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: selectedSize == widget.sizes[i]
                    ? Colors.blue // Change la couleur pour la taille sélectionnée
                    : Color(0xFFF7F8FA), // Couleur par défaut des options de taille
                borderRadius: BorderRadius.circular(30), // Bordures arrondies du conteneur
              ),
              child: Text(widget.sizes[i]), // Affiche la taille
            ),
          ),
      ],
    );
  }
}