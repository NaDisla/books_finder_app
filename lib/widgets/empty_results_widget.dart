import 'package:flutter/material.dart';

class EmptyResultsWidget extends StatelessWidget {
  final String message;

  const EmptyResultsWidget({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2.0),
      height: 500,
      alignment: Alignment.center,
      child: Text(
        message,
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
