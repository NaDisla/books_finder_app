import 'package:animate_do/animate_do.dart';
import 'package:book_finder_app/models/models.dart';
import 'package:book_finder_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class BooksListWidget extends StatefulWidget {
  final List<Item> bookItems;
  const BooksListWidget({super.key, required this.bookItems});

  @override
  State<BooksListWidget> createState() => _BooksListWidgetState();
}

class _BooksListWidgetState extends State<BooksListWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
      child: ListView.builder(
        padding: const EdgeInsets.all(0.0),
        itemCount: widget.bookItems.length,
        itemBuilder: ((context, index) {
          return Stack(
            children: [
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: BookImageWidget(
                  thumbnail:
                      widget.bookItems[index].volumeInfo.imageLinks!.thumbnail,
                ),
              ),
              Positioned(
                top: 50.0,
                left: 9.0,
                bottom: 50.0,
                child: SizedBox(
                  width: 220.0,
                  height: 150.0,
                  child: Card(
                    color: Colors.white.withOpacity(0.8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(17.0),
                      child: BookDetailWidget(
                        volumeInfoTitle:
                            widget.bookItems[index].volumeInfo.title,
                        index: index,
                        authors: widget.bookItems[index].volumeInfo.authors,
                        publishedDate:
                            widget.bookItems[index].volumeInfo.publishedDate,
                        description:
                            widget.bookItems[index].volumeInfo.description,
                        id: widget.bookItems[index].id,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
