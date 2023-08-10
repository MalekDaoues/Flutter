import 'package:flutter/cupertino.dart';

class CustomDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4, // Hauteur du séparateur
      width: 50, // Largeur du séparateur
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 223, 221, 221), // Couleur du séparateur
        borderRadius: BorderRadius.circular(10), // Bordures arrondies du séparateur
      ),
    );
  }
}