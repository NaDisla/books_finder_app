import 'package:book_finder_app/core/utils.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
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
        AuthorsListWidget(currentAuthors: authors),
        SizedBox(height: 5.0),
        publishedDate != ''
            ? Text(
                publishedDate,
                style: Utils.authorDateStyle,
              )
            : Text(
                AppLocale.bookUnknownPublishedDate.getString(context),
                style: Utils.authorDateStyle,
              ),
        SizedBox(height: 5.0),
        description != ''
            ? BookButtonInfoWidget(
                text: AppLocale.bookDescription.getString(context),
                onPressedFn: () {},
                icon: Icons.arrow_forward_ios_rounded,
              )
            : BookButtonInfoWidget(
                text: AppLocale.bookMoreDetails.getString(context),
                icon: Icons.arrow_forward_ios_rounded,
                onPressedFn: () {
                  Uri bookUrl = Uri.parse(
                    BookService.getBookUrl(id, volumeInfoTitle),
                  );
                  launchUrlString(
                    bookUrl.toString(),
                    mode: LaunchMode.externalApplication,
                  );
                },
              ),
      ],
    );
  }
}
