import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SizeOptions extends StatefulWidget {
  final List<String> sizes;

  const SizeOptions({required this.sizes});

  @override
  _SizeOptionsState createState() => _SizeOptionsState();
}

class _SizeOptionsState extends State<SizeOptions> {
  String? selectedSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          "Size",
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
                selectedSize = widget.sizes[i];
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: selectedSize == widget.sizes[i]
                    ? Colors.blue // Change the color for the selected size
                    : Color(0xFFF7F8FA),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(widget.sizes[i]),
            ),
          ),
      ],
    );
  }
}