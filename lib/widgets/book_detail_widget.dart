import 'package:book_finder_app/core/utils.dart';
import 'package:book_finder_app/lang/languages.dart';
import 'package:book_finder_app/models/models.dart';
import 'package:book_finder_app/screens/book_detail_screen.dart';
import 'package:book_finder_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

class BookDetailWidget extends StatelessWidget {
  final Item book;

  const BookDetailWidget({
    super.key,
    required this.book,
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
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        SizedBox(height: 5.0),
        AuthorsListWidget(currentAuthors: book.volumeInfo.authors),
        SizedBox(height: 5.0),
        book.volumeInfo.publishedDate != ''
            ? Text(
                book.volumeInfo.publishedDate,
                style: Utils.authorDateStyle,
              )
            : Text(
                AppLocale.bookUnknownPublishedDate.getString(context),
                style: Utils.authorDateStyle,
              ),
        SizedBox(height: 5.0),
        book.volumeInfo.description != ''
            ? BookButtonInfoWidget(
                text: AppLocale.bookDescription.getString(context),
                onPressedFn: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BookDetailScreen(book: book),
                  ),
                ),
                icon: Icons.arrow_forward_ios_rounded,
                btnColor: Utils.darkYellowColor,
              )
            : BookButtonInfoWidget(
                text: AppLocale.bookMoreDetails.getString(context),
                icon: Icons.arrow_forward_ios_rounded,
                onPressedFn: () =>
                    Utils.getGoogleBooksInfo(book.id, book.volumeInfo.title),
                btnColor: Utils.darkYellowColor,
              ),
      ],
    );
  }
}
