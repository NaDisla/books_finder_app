import 'dart:async';
import 'dart:ui';

import 'package:book_finder_app/lang/languages.dart';
import 'package:book_finder_app/models/models.dart';
import 'package:book_finder_app/services/services.dart';
import 'package:book_finder_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController bookTitleController = TextEditingController();
  BookService bookService = BookService();
  bool hasBooks = false;
  List<Item> obtainedBooks = [];
  Timer timer = Timer(const Duration(seconds: 2), () {});
  bool isEnglish = true;
  final FlutterLocalization _localization = FlutterLocalization.instance;

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
          obtainedBooks = searchResults;
          setState(() => hasBooks = true);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.webp'),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            color: const Color(0xFF8D8364).withOpacity(0.5),
            child: Column(
              children: [
                const SizedBox(
                  height: 55,
                ),
                SizedBox(
                  height: 120,
                  child: OverflowBox(
                    minHeight: 170,
                    maxHeight: 220,
                    child: Lottie.asset(
                      'assets/icon-home.json',
                      width: 210.0,
                      height: 210.0,
                    ),
                  ),
                ),
                Text(
                  AppLocale.homeTitle.getString(context),
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontStyle: FontStyle.normal),
                ),
                const SizedBox(height: 25.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: TextField(
                        controller: bookTitleController,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          hintText: AppLocale.hintText.getString(context),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 20.0),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        searchBook(bookTitleController.text);
                        FocusScope.of(context).unfocus();
                        bookTitleController.clear();
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xFFFACF4F)),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.all(12.0)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
                    ),
                  ],
                ),
                hasBooks
                    ? BooksListWidget(bookItems: obtainedBooks)
                    : Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(2.0),
                          height: 500,
                          alignment: Alignment.center,
                          child: Text(
                            AppLocale.homeDescription.getString(context),
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        height: 70,
        child: FittedBox(
          fit: BoxFit.fill,
          child: Switch(
            onChanged: (bool value) {
              setState(() {
                isEnglish = value;
                if (isEnglish) {
                  _localization.translate('en');
                } else {
                  _localization.translate('es');
                }
              });
            },
            value: isEnglish,
            activeColor: Colors.white,
            inactiveTrackColor: Colors.white54,
            activeThumbImage:
                Image.asset('assets/images/us_icon.png', scale: 17.0).image,
            inactiveThumbImage:
                Image.asset('assets/images/es_icon.png', scale: 17.0).image,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
