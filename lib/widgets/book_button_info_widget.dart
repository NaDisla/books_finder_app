import 'package:flutter/material.dart';

class BookButtonInfoWidget extends StatelessWidget {
  final String text;
  const BookButtonInfoWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              fontStyle: FontStyle.italic,
              color: Color(0xFF786C44),
            ),
          ),
        ),
        Icon(Icons.arrow_forward_ios_rounded, color: Color(0xFF786C44)),
      ],
    );
  }
}
