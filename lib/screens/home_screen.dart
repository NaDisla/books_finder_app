import 'dart:async';
import 'dart:ui';
import 'package:book_finder_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:book_finder_app/models/models.dart';
import 'package:book_finder_app/services/services.dart';

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

  void searchBook(String book) async {
    if (book.isEmpty) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Empty title"),
              content: const Text("Please, provide the book title."),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("OK"))
              ],
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

              return const AlertDialog(
                backgroundColor: Colors.white,
                title: Text('Searching book'),
                content: SingleChildScrollView(
                  child: Text('Please wait...🔍'),
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
                title: const Text("An error occurred"),
                content: Text("An error occurred 🙁 ${e.toString()}"),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("OK"))
                ],
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
                const Text(
                  'Search any book',
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
                        decoration: const InputDecoration(
                          hintText: 'Book title',
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
                      child: const Text(
                        'Search',
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
                          child: const Text(
                            "Your results will appear here. Let's start searching! 🙂",
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
      //backgroundColor: const Color(0xFF97978D),
    );
  }
}
