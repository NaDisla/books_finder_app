import 'package:book_finder_app/models/models.dart';
import 'package:book_finder_app/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class BookImageWidget extends StatelessWidget {
  final Item book;

  const BookImageWidget({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, right: 10.0, bottom: 10.0),
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => BookDetailScreen(
                book: book,
              ),
            ),
          );
        },
        child: Hero(
          tag: book,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: book.volumeInfo.imageLinks!.thumbnail,
              fit: BoxFit.fill,
              width: 180.0,
              height: 250.0,
            ),
          ),
        ),
      ),
    );
  }
}
