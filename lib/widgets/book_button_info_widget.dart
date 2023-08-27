import 'package:flutter/material.dart';

class BookButtonInfoWidget extends StatelessWidget {
  final String text;
  final Function() onPressedFn;
  final IconData icon;
  final Color btnColor;

  const BookButtonInfoWidget({
    super.key,
    required this.text,
    required this.onPressedFn,
    required this.icon,
    required this.btnColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onPressedFn,
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: btnColor,
                ),
              ),
            ),
            Icon(icon, color: btnColor),
          ],
        ),
      ),
      color: Colors.transparent,
    );
  }
}
