import 'package:flutter/material.dart';

class BookButtonInfoWidget extends StatelessWidget {
  final String text;
  final Function() onPressedFn;
  final IconData icon;
  final Color btnColor;
  final bool isMobile;

  const BookButtonInfoWidget({
    super.key,
    required this.text,
    required this.onPressedFn,
    required this.icon,
    required this.btnColor,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onPressedFn,
        child: Row(
          children: [
            isMobile
                ? Expanded(
                    child: Text(
                      text,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: isMobile ? 16.0 : 20.0,
                        fontStyle: FontStyle.italic,
                        color: btnColor,
                      ),
                    ),
                  )
                : Row(
                    children: [
                      Text(
                        text,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: isMobile ? 16.0 : 20.0,
                          fontStyle: FontStyle.italic,
                          color: btnColor,
                        ),
                      ),
                      SizedBox(width: 10.0),
                    ],
                  ),
            Icon(icon, color: btnColor),
          ],
        ),
      ),
      color: Colors.transparent,
    );
  }
}
