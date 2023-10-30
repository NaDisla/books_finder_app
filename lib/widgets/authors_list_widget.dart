import 'package:book_finder_app/core/utils.dart';
import 'package:book_finder_app/lang/languages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

class AuthorsListWidget extends StatelessWidget {
  final List<String> currentAuthors;
  final bool isMobile;

  const AuthorsListWidget({
    super.key,
    required this.currentAuthors,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    String finalAuthors = AppLocale.bookAuthor.getString(context);
    int totalAuthors = currentAuthors.length;
    if (totalAuthors > 1) {
      for (int idx = 0; idx < totalAuthors; idx++) {
        String author = currentAuthors[idx];
        if (idx == totalAuthors - 1) {
          finalAuthors += "${AppLocale.authorsConnector.getString(context)} $author.";
        } else if (1 == totalAuthors - 1) {
          finalAuthors += "$author ";
        } else {
          finalAuthors += "$author, ";
        }
      }
      return Text(
        finalAuthors,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        style: isMobile ? Utils.authorMobileDateStyle : Utils.authorTabletDateStyle,
      );
    } else if (currentAuthors.length == 1) {
      return Text(
        "${AppLocale.bookAuthor.getString(context)} ${currentAuthors[0]}.",
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: isMobile ? Utils.authorMobileDateStyle : Utils.authorTabletDateStyle,
      );
    } else {
      return Text(
        AppLocale.bookUnknownAuthor.getString(context),
        style: isMobile ? Utils.authorMobileDateStyle : Utils.authorTabletDateStyle,
      );
    }
  }
}
