import 'package:book_finder_app/lang/languages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

Widget SearchFieldWidget(
    {required BuildContext context,
    required TextEditingController bookTitleController}) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.7,
    child: TextField(
      controller: bookTitleController,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        hintText: AppLocale.hintText.getString(context),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
          borderSide: BorderSide(color: Colors.black),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 20.0),
      ),
    ),
  );
}
