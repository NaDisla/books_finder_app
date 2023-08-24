import 'package:book_finder_app/core/utils.dart';
import 'package:flutter/material.dart';

class BookButtonInfoWidget extends StatelessWidget {
  final String text;
  final Function() onPressedFn;
  final IconData icon;

  const BookButtonInfoWidget({
    super.key,
    required this.text,
    required this.onPressedFn,
    required this.icon,
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
                  color: Utils.darkYellowColor,
                ),
              ),
            ),
            Icon(icon, color: Utils.darkYellowColor),
          ],
        ),
      ),
      color: Colors.transparent,
    );
    // return TextButton(
    //   onPressed: () => onPressedFn,
    //   style: TextButton.styleFrom(padding: EdgeInsets.zero),
    //   child: Row(
    //     children: [
    //       Expanded(
    //         child: Text(
    //           text,
    //           style: TextStyle(
    //             fontWeight: FontWeight.bold,
    //             fontSize: 16,
    //             fontStyle: FontStyle.italic,
    //             color: Utils.darkYellowColor,
    //           ),
    //         ),
    //       ),
    //       Icon(icon, color: Utils.darkYellowColor),
    //     ],
    //   ),
    // );
  }
}
