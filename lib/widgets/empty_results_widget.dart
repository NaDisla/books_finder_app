import 'package:flutter/material.dart';

class EmptyResultsWidget extends StatelessWidget {
  final String message;

  const EmptyResultsWidget({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      height: MediaQuery.of(context).size.height - 370,
      alignment: Alignment.center,
      child: Text(
        message,
        style: TextStyle(
          fontSize: deviceWidth < 500 ? 18.0 : 24.0,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
