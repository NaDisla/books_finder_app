import 'package:book_finder_app/lang/languages.dart';
import 'package:book_finder_app/models/models.dart';
import 'package:book_finder_app/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

class SearchFieldWidget extends StatefulWidget {
  static List<Item> foundBooks = [];
  const SearchFieldWidget({super.key});

  @override
  State<SearchFieldWidget> createState() => _SearchFieldWidgetState();
}

class _SearchFieldWidgetState extends State<SearchFieldWidget> {
  final TextEditingController _bookTitleController = TextEditingController();
  BookService bookService = BookService();
  List<Item> _allBooks = [];

  void _loadBooks() async {
    setState(() => SearchFieldWidget.foundBooks = _allBooks);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: TextField(
        onChanged: (value) => _loadBooks(),
        controller: _bookTitleController,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: Color(0xFF786C44).withOpacity(0.7),
            size: 28,
          ),
          hintText: AppLocale.hintText.getString(context),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          hintStyle: TextStyle(
            color: Color(0xFF786C44).withOpacity(0.7),
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
          labelStyle: TextStyle(
            color: Color(0xFF786C44).withOpacity(0.7),
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Color(0xFFFFFCF1),
          contentPadding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 20.0),
        ),
      ),
    );
  }
}
