import 'package:book_finder_app/lang/languages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

Widget AuthorsListWidget(
    int idx, BuildContext context, List<String> currentAuthors) {
  String finalAuthors = AppLocale.bookAuthor.getString(context);
  TextStyle style = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Color(0xFF6A6A6A),
  );
  if (currentAuthors.length > 1) {
    for (var author in currentAuthors) {
      finalAuthors += "$author,";
    }
    return Text(
      finalAuthors,
      overflow: TextOverflow.ellipsis,
      style: style,
    );
  } else if (currentAuthors.length == 1) {
    return Text(
      "${AppLocale.bookAuthor.getString(context)} ${currentAuthors[0]}",
      overflow: TextOverflow.ellipsis,
      style: style,
    );
  } else {
    return Text(AppLocale.bookUnknownAuthor.getString(context), style: style);
  }
}
