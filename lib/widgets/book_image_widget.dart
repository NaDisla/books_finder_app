import 'package:book_finder_app/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class BookImageWidget extends StatelessWidget {
  final String thumbnail;
  const BookImageWidget({super.key, required this.thumbnail});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, right: 10.0, bottom: 10.0),
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BookDetailScreen(image: thumbnail),
          ),
        ),
        child: Hero(
          tag: 'book-image',
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: thumbnail,
              fit: BoxFit.fill,
              width: 180,
            ),
          ),
        ),
      ),
    );
  }
}
