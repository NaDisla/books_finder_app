import 'dart:async';

import 'package:book_finder_app/lang/languages.dart';
import 'package:book_finder_app/models/models.dart';
import 'package:book_finder_app/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:lottie/lottie.dart';

Widget SearchButtonWidget(BuildContext context,
    TextEditingController bookTitleController, Function hasBooks) {
  BookService bookService = BookService();
  Timer timer = Timer(const Duration(seconds: 2), () {});

  void searchBook(String book) async {
    if (book.isEmpty) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(AppLocale.alertEmptyTitleHeader.getString(context)),
              content: Text(AppLocale.alertEmptyTitleDesc.getString(context)),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("OK"))
              ],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            );
          });
    } else {
      try {
        showDialog(
            context: context,
            builder: (context) {
              timer = Timer(const Duration(seconds: 2), () {
                Navigator.of(context).pop();
              });
              return AlertDialog(
                backgroundColor: Colors.white,
                title: Text(AppLocale.alertSearchingBook.getString(context)),
                content: Lottie.asset(
                  'assets/book-search.json',
                  width: 180.0,
                  height: 180.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              );
            }).then((val) {
          if (timer.isActive) {
            timer.cancel();
          }
        });
        List<Item> searchResults = await bookService.getAllBooks(book);
        if (searchResults.isNotEmpty) {
          hasBooks(searchResults);
        }
      } catch (e) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title:
                    Text(AppLocale.alertSearchErrorHeader.getString(context)),
                content:
                    Text("${AppLocale.alertSearchErrorDesc} ${e.toString()}."),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("OK"))
                ],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              );
            });
      }
    }
  }

  return TextButton(
    onPressed: () {
      searchBook(bookTitleController.text);
      FocusScope.of(context).unfocus();
      bookTitleController.clear();
    },
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(const Color(0xFFFACF4F)),
      padding: MaterialStateProperty.all(const EdgeInsets.all(12.0)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      )),
    ),
    child: Text(
      AppLocale.buttonTitle.getString(context),
      style: TextStyle(
        fontSize: 17.0,
        fontWeight: FontWeight.bold,
        color: Color(0xFF7E6923),
      ),
    ),
  );
}
