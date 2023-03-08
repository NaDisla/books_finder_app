import 'package:book_finder_app/lang/languages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

Widget AuthorsListWidget(
    int idx, BuildContext context, List<String> currentAuthors) {
  String finalAuthors = AppLocale.bookAuthors.getString(context);
  if (currentAuthors.length > 1) {
    for (var author in currentAuthors) {
      finalAuthors += "$author,";
    }
    return Text(finalAuthors, overflow: TextOverflow.ellipsis);
  } else if (currentAuthors.length == 1) {
    return Text(
        "${AppLocale.bookAuthor.getString(context)} ${currentAuthors[0]}",
        overflow: TextOverflow.ellipsis);
  } else {
    return Text(AppLocale.bookUnknownAuthor.getString(context));
  }
}
