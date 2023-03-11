import 'package:book_finder_app/lang/languages.dart';
import 'package:book_finder_app/models/models.dart';
import 'package:book_finder_app/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:lottie/lottie.dart';

Widget SearchButtonWidget(
    {required BuildContext context,
    required TextEditingController bookTitleController,
    required Function hasBooks}) {
  BookService bookService = BookService();

  void searchBook(String book) async {
    if (book.isEmpty) {
      showDialog(
          context: context,
          barrierDismissible: false,
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
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
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
          });
      Future.delayed(Duration(seconds: 1), () async {
        try {
          List<Item> searchResults = await bookService.getAllBooks(book);
          if (searchResults.isNotEmpty) {
            hasBooks(searchResults);
            Navigator.of(context).pop();
          }
        } catch (e) {
          Navigator.of(context).pop();
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title:
                      Text(AppLocale.alertSearchErrorHeader.getString(context)),
                  content: Text(
                      "${AppLocale.alertSearchErrorDesc.getString(context)} ${e.toString()}."),
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
      });
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
