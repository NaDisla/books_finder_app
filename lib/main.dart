import 'package:book_finder_app/screens/screens.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BookFinderApp());
}

class BookFinderApp extends StatelessWidget {
  const BookFinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
