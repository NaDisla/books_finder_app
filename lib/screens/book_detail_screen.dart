import 'dart:convert';

import 'package:book_finder_app/core/utils.dart';
import 'package:book_finder_app/lang/languages.dart';
import 'package:book_finder_app/models/models.dart';
import 'package:book_finder_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:lottie/lottie.dart';
import 'package:transparent_image/transparent_image.dart';

class BookDetailScreen extends StatefulWidget {
  final Item book;
  final bool isMobile;

  const BookDetailScreen({
    super.key,
    required this.book,
    required this.isMobile,
  });

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  bool isFavorite = false;
  List<String> savedFavBooks = [];

  void getFavoritesBooks() async {
    savedFavBooks = await Utils.getFavoritesBooks();
    List<Item> savedFavBooksParsed = savedFavBooks.map((map) => Item.fromApiItems(jsonDecode(map))).toList();
    setState(() => isFavorite = savedFavBooksParsed.any((book) => book.id == widget.book.id));
  }

  @override
  void initState() {
    getFavoritesBooks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool hasNotch = MediaQuery.of(context).viewPadding.top > 24;
    double separation = widget.isMobile ? 10.0 : 30.0, deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: TextButton(
          onPressed: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        title: Padding(
          padding: widget.isMobile ? const EdgeInsets.only(left: 30.0) : EdgeInsets.only(left: deviceWidth * 0.30),
          child: Row(
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
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BackgroundWidget(
        color: Colors.white.withOpacity(0.75),
        child: Padding(
          padding: EdgeInsets.only(
            top: hasNotch ? 120.0 : 90.0,
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
                        width: widget.isMobile ? 180.0 : 250.0,
                        height: widget.isMobile ? 250.0 : 330.0,
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
                            if (widget.book.volumeInfo.title.length > 26 && widget.isMobile)
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
                        SizedBox(height: separation),
                        AuthorsListWidget(currentAuthors: widget.book.volumeInfo.authors, isMobile: widget.isMobile),
                        SizedBox(height: separation),
                        widget.book.volumeInfo.publishedDate != ''
                            ? Text(
                                widget.book.volumeInfo.publishedDate,
                                style: widget.isMobile ? Utils.authorMobileDateStyle : Utils.authorTabletDateStyle,
                              )
                            : Text(
                                AppLocale.bookUnknownPublishedDate.getString(context),
                                style: widget.isMobile ? Utils.authorMobileDateStyle : Utils.authorTabletDateStyle,
                              ),
                        SizedBox(height: separation),
                        isFavorite
                            ? BookButtonInfoWidget(
                                text: AppLocale.removeFavorite.getString(context),
                                onPressedFn: () async {
                                  Utils.setFavoritesBooks(savedFavBooks, widget.book, "remove");
                                  setState(() => isFavorite = false);
                                },
                                icon: Icons.remove_circle_sharp,
                                btnColor: Utils.darkRedColor,
                                isMobile: widget.isMobile,
                              )
                            : BookButtonInfoWidget(
                                text: AppLocale.addToFavorites.getString(context),
                                onPressedFn: () async {
                                  Utils.setFavoritesBooks(savedFavBooks, widget.book, "add");
                                  setState(() => isFavorite = true);
                                },
                                icon: Icons.add_circle_sharp,
                                btnColor: Utils.darkYellowColor,
                                isMobile: widget.isMobile,
                              ),
                        SizedBox(height: separation),
                        BookButtonInfoWidget(
                          text: "Google Books info",
                          onPressedFn: () => Utils.getGoogleBooksInfo(widget.book.id, widget.book.volumeInfo.title),
                          icon: Icons.arrow_forward_ios_rounded,
                          btnColor: Utils.darkYellowColor,
                          isMobile: widget.isMobile,
                        ),
                        SizedBox(height: separation),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.0),
              Divider(
                color: Color(0xFF9C9C9C),
                thickness: 2.0,
              ),
              SizedBox(height: 15.0),
              Text(
                AppLocale.aboutBook.getString(context),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                ),
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 15.0),
              Expanded(
                child: Scrollbar(
                  thickness: 5.0,
                  radius: Radius.circular(5.0),
                  child: SingleChildScrollView(
                    child: Text(
                      widget.book.volumeInfo.description,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        height: 1.5,
                        fontSize: widget.isMobile ? 18.0 : 22.0,
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
