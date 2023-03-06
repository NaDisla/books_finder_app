import 'package:animate_do/animate_do.dart';
import 'package:book_finder_app/lang/languages.dart';
import 'package:book_finder_app/models/models.dart';
import 'package:book_finder_app/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher_string.dart';

class BooksListWidget extends StatefulWidget {
  final List<Item> bookItems;
  const BooksListWidget({super.key, required this.bookItems});

  @override
  State<BooksListWidget> createState() => _BooksListWidgetState();
}

class _BooksListWidgetState extends State<BooksListWidget> {
  BookService bookService = BookService();
  late Future<List<Item>> futureBooks;
  bool hasBooks = false;

  @override
  void initState() {
    super.initState();
    futureBooks = bookService.getAllBooks("title");
  }

  Widget authorsList(int idx) {
    List<String> authors = widget.bookItems[idx].volumeInfo.authors;
    String finalAuthors = AppLocale.bookAuthors.getString(context);
    if (authors.length > 1) {
      for (var author in widget.bookItems[idx].volumeInfo.authors) {
        finalAuthors += "$author,";
      }
      return Text(finalAuthors, overflow: TextOverflow.ellipsis);
    } else if (authors.length == 1) {
      return Text("${AppLocale.bookAuthor.getString(context)} ${authors[0]}",
          overflow: TextOverflow.ellipsis);
    } else {
      return Text(AppLocale.bookUnknownAuthor.getString(context));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 500,
        alignment: Alignment.center,
        margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
        child: FadeInLeft(
          child: ListView.builder(
            padding: const EdgeInsets.all(0.0),
            itemCount: widget.bookItems.length,
            itemBuilder: ((context, index) {
              return SizedBox(
                height: 140,
                child: Card(
                  color: Colors.white60,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: widget.bookItems[index].volumeInfo
                                .imageLinks!.thumbnail,
                            fit: BoxFit.fill,
                            width: 100,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 5.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.bookItems[index].volumeInfo.title,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                ),
                              ),
                              authorsList(index),
                              widget.bookItems[index].volumeInfo
                                          .publishedDate !=
                                      ''
                                  ? Text(
                                      "${AppLocale.bookPublishedDate.getString(context)} ${widget.bookItems[index].volumeInfo.publishedDate}",
                                    )
                                  : Text(AppLocale.bookUnknownPublishedDate
                                      .getString(context)),
                              widget.bookItems[index].volumeInfo.description !=
                                      ''
                                  ? TextButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text(
                                                  widget.bookItems[index]
                                                      .volumeInfo.title,
                                                  textAlign: TextAlign.justify,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.0,
                                                  ),
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                content: Text(
                                                  widget.bookItems[index]
                                                      .volumeInfo.description,
                                                  maxLines: 15,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.justify,
                                                  style: TextStyle(),
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                    child: Text('OK'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      launchUrlString(
                                                          'https://books.google.com.do/books?id=${widget.bookItems[index].id}&dq=${widget.bookItems[index].volumeInfo.title}',
                                                          mode: LaunchMode
                                                              .externalApplication);
                                                    },
                                                    child: Text(AppLocale
                                                        .bookMoreDetails
                                                        .getString(context)),
                                                  )
                                                ],
                                              );
                                            });
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.amber[50],
                                      ),
                                      child: Text(
                                        AppLocale.bookDescription
                                            .getString(context),
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    )
                                  : TextButton(
                                      child: Text(
                                        AppLocale.bookMoreDetails
                                            .getString(context),
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      onPressed: () {
                                        launchUrlString(
                                            'https://books.google.com.do/books?id=${widget.bookItems[index].id}&dq=${widget.bookItems[index].volumeInfo.title}',
                                            mode:
                                                LaunchMode.externalApplication);
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.amber[50],
                                      ),
                                    )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
