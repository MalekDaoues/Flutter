
import 'package:flutter/material.dart';


class ColorOptions extends StatefulWidget {
  @override
  _ColorOptionsState createState() => _ColorOptionsState();
}

class _ColorOptionsState extends State<ColorOptions> {
  Color? selectedColor; // Couleur sélectionnée

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          "Couleur:",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 30),
        ColorOption(
          color: Color(0xFF031C3C),
          isSelected: selectedColor == Color(0xFF031C3C),
          onSelect: () {
            setState(() {
              selectedColor = Color(0xFF031C3C);
            });
          },
        ),
        ColorOption(
          color: Color(0xFF3BA48D),
          isSelected: selectedColor == Color(0xFF3BA48D),
          onSelect: () {
            setState(() {
              selectedColor = Color(0xFF3BA48D);
            });
          },
        ),
        ColorOption(
          color: Colors.redAccent,
          isSelected: selectedColor == Colors.redAccent,
          onSelect: () {
            setState(() {
              selectedColor = Colors.redAccent;
            });
          },
        ),
      ],
    );
  }
}

// Classe représentant une option de couleur individuelle
class ColorOption extends StatelessWidget {
  final Color color; // Couleur de l'option
  final bool isSelected; // Indique si l'option est sélectionnée
  final VoidCallback onSelect; // Callback appelé lors de la sélection de l'option

  const ColorOption({
    required this.color,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect, // Définir le callback onTap pour déclencher la sélection
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8), // Marge horizontale
        padding: EdgeInsets.all(13), // Remplissage interne
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.8) : color, // Couleur de fond de l'option
          borderRadius: BorderRadius.circular(20), // Bordures arrondies
        ),
      ),
    );
  }
}