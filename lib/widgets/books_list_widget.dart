import 'package:animate_do/animate_do.dart';
import 'package:book_finder_app/models/models.dart';
import 'package:book_finder_app/services/services.dart';
import 'package:book_finder_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class BooksListWidget extends StatefulWidget {
  final List<Item> bookItems;
  const BooksListWidget({super.key, required this.bookItems});

  @override
  State<BooksListWidget> createState() => _BooksListWidgetState();
}

class _BooksListWidgetState extends State<BooksListWidget> {
  BookService bookService = BookService();
  bool hasBooks = false;

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
                      BookImageWidget(
                          thumbnail: widget.bookItems[index].volumeInfo
                              .imageLinks!.thumbnail),
                      BookDetailWidget(
                        volumeInfoTitle:
                            widget.bookItems[index].volumeInfo.title,
                        index: index,
                        context: context,
                        authors: widget.bookItems[index].volumeInfo.authors,
                        publishedDate:
                            widget.bookItems[index].volumeInfo.publishedDate,
                        description:
                            widget.bookItems[index].volumeInfo.description,
                        id: widget.bookItems[index].id,
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
