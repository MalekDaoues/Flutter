import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuantitySelector extends StatefulWidget {
  @override
  _QuantitySelectorState createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  int quantity = 1;

  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

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
          child: QuantityButton(icon: CupertinoIcons.minus),
        ),
        SizedBox(width: 8),
        Text(
          quantity.toString().padLeft(2, '0'),
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(width: 8),
        GestureDetector(
          onTap: incrementQuantity,
          child: QuantityButton(icon: CupertinoIcons.plus),
        ),
      ],
    );
  }
}
class QuantityButton extends StatelessWidget {
  final IconData icon;

  const QuantityButton({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      padding: EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Color(0xFFF7F8FA),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Icon(
        icon,
        size: 18,
        color: Colors.redAccent,
      ),
    );
  }
}