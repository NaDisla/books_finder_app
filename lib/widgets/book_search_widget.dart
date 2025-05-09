import 'dart:async';

import 'package:book_finder_app/lang/languages.dart';
import 'package:book_finder_app/models/models.dart';
import 'package:book_finder_app/responsive/responsive.dart';
import 'package:book_finder_app/services/services.dart';
import 'package:book_finder_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:lottie/lottie.dart';

class BookSearchWidget extends StatefulWidget {
  const BookSearchWidget({super.key});

  @override
  State<BookSearchWidget> createState() => _BookSearchWidgetState();
}

class _BookSearchWidgetState extends State<BookSearchWidget> {
  final TextEditingController searchController = TextEditingController();
  List<Item> foundBooks = [];
  BookService bookService = BookService();
  Timer? debounce;
  bool isLoading = false;

  void searchBooks(String query) async {
    if (debounce?.isActive ?? false) debounce?.cancel();
    if (query.isEmpty) {
      setState(() {
        foundBooks = [];
        isLoading = false;
      });
      return;
    }
    debounce = Timer(const Duration(milliseconds: 400), () async {
      setState(() => isLoading = true);
      final response = await bookService.getAllBooks(query);
      setState(() {
        isLoading = false;
        foundBooks = response;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double customPadding = deviceWidth * 0.017;
    return Column(
      children: [
        SizedBox(
          width: deviceWidth < 500 ? deviceWidth * 0.9 : deviceWidth * 0.95,
          child: TextField(
            onChanged: searchBooks,
            controller: searchController,
            textCapitalization: TextCapitalization.sentences,
            style: TextStyle(
              color: const Color(0xFF786C44),
              fontWeight: FontWeight.bold,
              fontSize: deviceWidth < 500 ? 20.0 : 24.0,
            ),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: const Color.fromRGBO(120, 108, 68, 0.7),
                size: deviceWidth < 500 ? 28.0 : 35.0,
              ),
              hintText: AppLocale.hintText.getString(context),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              hintStyle: TextStyle(
                color: const Color.fromRGBO(120, 108, 68, 0.7),
                fontWeight: FontWeight.bold,
                fontSize: deviceWidth < 500 ? 20.0 : 24.0,
              ),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: const Color(0xFFFFFCF1),
              contentPadding: EdgeInsets.symmetric(
                  vertical: deviceWidth < 500 ? 10.0 : 12.0, horizontal: 20.0),
            ),
          ),
        ),
        if (isLoading)
          AlertDialog(
            backgroundColor: Colors.white,
            title: Text(AppLocale.alertSearchingBook.getString(context)),
            content: Lottie.asset(
              'assets/book-search.json',
              width: 100.0,
              height: 100.0,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          )
        else if (foundBooks.isNotEmpty)
          SizedBox(
            height: MediaQuery.of(context).size.height - 370,
            child: ResponsiveLayout(
              mobileScaffold: MobileScaffold(bookItems: foundBooks),
              tabletScaffold: TabletScaffold(bookItems: foundBooks),
            ),
          )
        else
          Padding(
            padding: EdgeInsets.only(left: customPadding, right: customPadding),
            child: EmptyResultsWidget(
              message: AppLocale.homeEmptyResults.getString(context),
            ),
          )
      ],
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    debounce?.cancel();
    super.dispose();
  }
}
