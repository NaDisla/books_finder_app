import 'package:book_finder_app/lang/languages.dart';
import 'package:book_finder_app/models/models.dart';
import 'package:book_finder_app/services/services.dart';
import 'package:book_finder_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

class BookSearchWidget extends StatefulWidget {
  const BookSearchWidget({super.key});

  @override
  State<BookSearchWidget> createState() => _BookSearchWidgetState();
}

class _BookSearchWidgetState extends State<BookSearchWidget> {
  final TextEditingController bookTitleController = TextEditingController();
  List<Item> foundBooks = [];
  BookService bookService = BookService();

  void searchBooks() async {
    foundBooks = await bookService.getAllBooks(bookTitleController.text);
    // if (bookTitleController.text.length > 0) {
    //   foundBooks = await bookService.getAllBooks(bookTitleController.text);
    // } else {
    //   foundBooks = [];
    // }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: TextField(
            onChanged: (text) {
              if (text.length > 0) {
                searchBooks();
              } else {
                setState(() => foundBooks = []);
              }
            },
            controller: bookTitleController,
            textCapitalization: TextCapitalization.sentences,
            style: TextStyle(
              color: Color(0xFF786C44),
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
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
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Color(0xFFFFFCF1),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 2.0, horizontal: 20.0),
            ),
          ),
        ),
        foundBooks.isNotEmpty
            ? Container(
                height: MediaQuery.of(context).size.height - 370,
                child: BooksListWidget(bookItems: foundBooks))
            : HomeDescriptionWidget(),
      ],
    );
  }
}
