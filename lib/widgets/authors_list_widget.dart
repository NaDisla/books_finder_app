import 'package:book_finder_app/core/utils.dart';
import 'package:book_finder_app/lang/languages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

class AuthorsListWidget extends StatelessWidget {
  final List<String> currentAuthors;
  const AuthorsListWidget({super.key, required this.currentAuthors});

  @override
  Widget build(BuildContext context) {
    String finalAuthors = AppLocale.bookAuthor.getString(context);
    if (currentAuthors.length > 1) {
      for (var author in currentAuthors) {
        finalAuthors += "$author,";
      }
      return Text(
        finalAuthors,
        overflow: TextOverflow.ellipsis,
        style: Utils.authorDateStyle,
      );
    } else if (currentAuthors.length == 1) {
      return Text(
        "${AppLocale.bookAuthor.getString(context)} ${currentAuthors[0]}",
        overflow: TextOverflow.ellipsis,
        style: Utils.authorDateStyle,
      );
    } else {
      return Text(AppLocale.bookUnknownAuthor.getString(context),
          style: Utils.authorDateStyle);
    }
  }
}
