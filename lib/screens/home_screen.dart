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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Lottie.asset(
              'assets/icon-home.json',
              width: 210.0,
              height: 210.0,
            ),
          ),
          const Text(
            'Search any book',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 25.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 290.0,
                child: TextField(
                  controller: bookTitleController,
                  decoration: const InputDecoration(
                    focusColor: Colors.white,
                    hintText: 'Book title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  Book searchedBook =
                      await bookService.getAllBooks(bookTitleController.text);
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xFFFACF4F)),
                  padding:
                      MaterialStateProperty.all(const EdgeInsets.all(12.0)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
        ],
      ),
      backgroundColor: const Color(0xFF97978D),
    );
  }
}
