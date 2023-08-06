
import 'package:flutter/material.dart';


class ColorOptions extends StatefulWidget {
  @override
  _ColorOptionsState createState() => _ColorOptionsState();
}

class _ColorOptionsState extends State<ColorOptions> {
  Color? selectedColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          "Color:",
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
class ColorOption extends StatelessWidget {
  final Color color;
  final bool isSelected;
  final VoidCallback onSelect;

  const ColorOption({
    required this.color,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        padding: EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.8) : color,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}