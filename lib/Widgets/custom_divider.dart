import 'package:flutter/cupertino.dart';

class CustomDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4,
      width: 50,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 223, 221, 221),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}