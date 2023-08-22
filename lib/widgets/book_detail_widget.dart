import 'package:book_finder_app/lang/languages.dart';
import 'package:book_finder_app/services/services.dart';
import 'package:book_finder_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:url_launcher/url_launcher_string.dart';

class BookDetailWidget extends StatelessWidget {
  final String volumeInfoTitle;
  final int index;
  final List<String> authors;
  final String publishedDate;
  final String description;
  final String id;

  const BookDetailWidget({
    super.key,
    required this.volumeInfoTitle,
    required this.index,
    required this.authors,
    required this.publishedDate,
    required this.description,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle dateTextstyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Color(0xFF6A6A6A),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          volumeInfoTitle,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        SizedBox(height: 5.0),
        AuthorsListWidget(index, context, authors),
        SizedBox(height: 5.0),
        publishedDate != ''
            ? Text(
                publishedDate,
                style: dateTextstyle,
              )
            : Text(
                AppLocale.bookUnknownPublishedDate.getString(context),
                style: dateTextstyle,
              ),
        SizedBox(height: 5.0),
        description != ''
            ? Expanded(
                child: BookDescriptionWidget(
                    bookTitle: volumeInfoTitle,
                    bookDescription: description,
                    bookId: id,
                    volumeInfoTitle: volumeInfoTitle),
              )
            : Expanded(
                child: TextButton(
                  child: BookButtonInfoWidget(
                    text: AppLocale.bookMoreDetails.getString(context),
                  ),
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  onPressed: () {
                    Uri bookUrl = Uri.parse(
                      BookService.getBookUrl(id, volumeInfoTitle),
                    );
                    launchUrlString(
                      bookUrl.toString(),
                      mode: LaunchMode.externalApplication,
                    );
                  },
                ),
              )
      ],
    );
  }
}
