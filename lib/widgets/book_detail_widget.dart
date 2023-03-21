import 'package:book_finder_app/lang/languages.dart';
import 'package:book_finder_app/services/services.dart';
import 'package:book_finder_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:url_launcher/url_launcher_string.dart';

Widget BookDetailWidget(
    {required String volumeInfoTitle,
    required int index,
    required BuildContext context,
    required List<String> authors,
    required String publishedDate,
    required String description,
    required String id}) {
  return Expanded(
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
            volumeInfoTitle,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
            ),
          ),
          AuthorsListWidget(index, context, authors),
          publishedDate != ''
              ? Text(
                  "${AppLocale.bookPublishedDate.getString(context)} ${publishedDate}",
                )
              : Text(AppLocale.bookUnknownPublishedDate.getString(context)),
          description != ''
              ? BookDescriptionWidget(
                  context: context,
                  bookTitle: volumeInfoTitle,
                  bookDescription: description,
                  bookId: id,
                  volumeInfoTitle: volumeInfoTitle)
              : TextButton(
                  child: Text(
                    AppLocale.bookMoreDetails.getString(context),
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    Uri bookUrl = Uri.parse(
                      BookService.getBookUrl(id, volumeInfoTitle),
                    );
                    launchUrlString(
                      bookUrl.toString(),
                      mode: LaunchMode.externalApplication,
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.amber[50],
                  ),
                )
        ],
      ),
    ),
  );
}
