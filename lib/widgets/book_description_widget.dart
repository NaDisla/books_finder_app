import 'package:book_finder_app/lang/languages.dart';
import 'package:book_finder_app/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:url_launcher/url_launcher_string.dart';

Widget BookDescriptionWidget(
    {required BuildContext context,
    required String bookTitle,
    required String bookDescription,
    required String bookId,
    required String volumeInfoTitle}) {
  return TextButton(
    onPressed: () {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: Text(
                bookTitle,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              content: Text(
                bookDescription,
                maxLines: 15,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.justify,
                style: TextStyle(),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK'),
                ),
                TextButton(
                  onPressed: () {
                    Uri bookUrl = Uri.parse(
                      BookService.getBookUrl(bookId, volumeInfoTitle),
                    );
                    launchUrlString(
                      bookUrl.toString(),
                      mode: LaunchMode.externalApplication,
                    );
                  },
                  child: Text(AppLocale.bookMoreDetails.getString(context)),
                )
              ],
            );
          });
    },
    style: TextButton.styleFrom(
      backgroundColor: Colors.amber[50],
    ),
    child: Text(
      AppLocale.bookDescription.getString(context),
      style: TextStyle(color: Colors.black),
    ),
  );
}
