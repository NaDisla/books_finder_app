import 'dart:convert';

import 'package:book_finder_app/core/utils.dart';
import 'package:book_finder_app/lang/languages.dart';
import 'package:book_finder_app/models/models.dart';
import 'package:book_finder_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent_image/transparent_image.dart';

class BookDetailScreen extends StatefulWidget {
  final Item book;

  const BookDetailScreen({
    super.key,
    required this.book,
  });

  @override
  State<BookDetailScreen> createState() => BookDetailScreenState();
}

class BookDetailScreenState extends State<BookDetailScreen> {
  bool isFavorite = false;
  List<String> savedFavBooks = [];
  static final favMethod = new ValueNotifier(() {});

  void getFavoritesBooks() async {
    savedFavBooks = await Utils.getFavoritesBooks();
    List<Item> savedFavBooksParsed =
        savedFavBooks.map((map) => Item.fromApiItems(jsonDecode(map))).toList();
    setState(() => isFavorite =
        savedFavBooksParsed.any((book) => book.id == widget.book.id));
  }

  @override
  void initState() {
    getFavoritesBooks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        title: Row(
          children: [
            Lottie.asset(
              'assets/icon-home.json',
              width: 90.0,
              height: 90.0,
            ),
            Text(
              'BooksFinder',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF786C44),
                fontStyle: FontStyle.normal,
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBody: true,
      body: BackgroundWidget(
        color: Colors.white.withOpacity(0.75),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 90.0,
            bottom: 20.0,
            left: 20.0,
            right: 20.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Hero(
                    tag: widget.book,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: widget.book.volumeInfo.imageLinks!.thumbnail,
                        fit: BoxFit.fill,
                        width: 180.0,
                        height: 250.0,
                      ),
                    ),
                  ),
                  SizedBox(width: 20.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Text(
                              widget.book.volumeInfo.title,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30.0,
                              ),
                            ),
                            if (widget.book.volumeInfo.title.length > 26)
                              Positioned(
                                top: 52,
                                bottom: 0,
                                right: 0,
                                child: Material(
                                  child: InkWell(
                                    onTap: () => showDialog(
                                      context: context,
                                      builder: ((context) => AlertDialog(
                                            title: Text(
                                              widget.book.volumeInfo.title,
                                              textAlign: TextAlign.center,
                                            ),
                                          )),
                                    ),
                                    child: Icon(
                                      Icons.remove_red_eye,
                                      size: 20.5,
                                      color: Utils.darkYellowColor,
                                    ),
                                  ),
                                  color: Colors.transparent,
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        AuthorsListWidget(
                            currentAuthors: widget.book.volumeInfo.authors),
                        SizedBox(height: 10.0),
                        widget.book.volumeInfo.publishedDate != ''
                            ? Text(
                                widget.book.volumeInfo.publishedDate,
                                style: Utils.authorDateStyle,
                              )
                            : Text(
                                AppLocale.bookUnknownPublishedDate
                                    .getString(context),
                                style: Utils.authorDateStyle,
                              ),
                        SizedBox(height: 10.0),
                        isFavorite
                            ? BookButtonInfoWidget(
                                text:
                                    AppLocale.removeFavorite.getString(context),
                                onPressedFn: () async {
                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  var bookMap = Item.toMap(widget.book);
                                  var jsonBook = jsonEncode(bookMap);
                                  savedFavBooks.remove(jsonBook);
                                  await prefs.setStringList(
                                      "favoritesBooks", savedFavBooks);
                                  setState(() => isFavorite = false);
                                },
                                icon: Icons.remove_circle_sharp,
                                btnColor: Utils.darkRedColor,
                              )
                            : BookButtonInfoWidget(
                                text:
                                    AppLocale.addToFavorites.getString(context),
                                onPressedFn: () async {
                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  var bookMap = Item.toMap(widget.book);
                                  var jsonBook = jsonEncode(bookMap);
                                  savedFavBooks.add(jsonBook);
                                  await prefs.setStringList(
                                      "favoritesBooks", savedFavBooks);
                                  setState(() => isFavorite = true);
                                  //favMethod.value = ;
                                },
                                icon: Icons.add_circle_sharp,
                                btnColor: Utils.darkYellowColor,
                              ),
                        SizedBox(height: 10.0),
                        BookButtonInfoWidget(
                          text: "Google Books info",
                          onPressedFn: () => Utils.getGoogleBooksInfo(
                              widget.book.id, widget.book.volumeInfo.title),
                          icon: Icons.arrow_forward_ios_rounded,
                          btnColor: Utils.darkYellowColor,
                        ),
                        SizedBox(height: 10.0),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(
                color: Color(0xFF9C9C9C),
                thickness: 2.0,
              ),
              Text(
                AppLocale.aboutBook.getString(context),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                ),
                textAlign: TextAlign.start,
              ),
              Expanded(
                child: Scrollbar(
                  thickness: 5.0,
                  radius: Radius.circular(5.0),
                  child: SingleChildScrollView(
                    child: Text(
                      widget.book.volumeInfo.description,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF646053),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
