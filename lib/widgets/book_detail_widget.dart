import 'package:book_finder_app/core/utils.dart';
import 'package:book_finder_app/lang/languages.dart';
import 'package:book_finder_app/models/models.dart';
import 'package:book_finder_app/screens/book_detail_screen.dart';
import 'package:book_finder_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

class BookDetailWidget extends StatelessWidget {
  final Item book;
  final bool isMobile;

  const BookDetailWidget({
    super.key,
    required this.book,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          book.volumeInfo.title,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: isMobile ? 20.0 : 24.0,
          ),
        ),
        const SizedBox(height: 5.0),
        AuthorsListWidget(
          currentAuthors: book.volumeInfo.authors,
          isMobile: isMobile,
        ),
        const SizedBox(height: 5.0),
        book.volumeInfo.publishedDate != ''
            ? Text(
                book.volumeInfo.publishedDate,
                style: isMobile
                    ? Utils.authorMobileDateStyle
                    : Utils.authorTabletDateStyle,
              )
            : Text(
                AppLocale.bookUnknownPublishedDate.getString(context),
                style: isMobile
                    ? Utils.authorMobileDateStyle
                    : Utils.authorTabletDateStyle,
              ),
        const SizedBox(height: 5.0),
        BookButtonInfoWidget(
          text: AppLocale.bookDescription.getString(context),
          onPressedFn: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => BookDetailScreen(
                book: book,
                isMobile: isMobile,
              ),
            ),
          ),
          icon: Icons.arrow_forward_ios_rounded,
          btnColor: Utils.darkYellowColor,
          isMobile: isMobile,
        ),
      ],
    );
  }
}
