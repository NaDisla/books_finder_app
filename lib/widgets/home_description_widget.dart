import 'package:book_finder_app/lang/languages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

Widget HomeDescriptionWidget({required BuildContext context}) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.all(2.0),
      height: 500,
      alignment: Alignment.center,
      child: Text(
        AppLocale.homeDescription.getString(context),
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    ),
  );
}
