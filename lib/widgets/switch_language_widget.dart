import 'package:flutter/material.dart';

Widget SwitchLanguageWidget(
    {required Function translate, required bool isEnglish}) {
  ImageProvider usIcon =
      Image.asset('assets/images/us_icon.png', scale: 17.0).image;
  return SizedBox(
    height: 70,
    child: FittedBox(
      fit: BoxFit.fill,
      child: Switch(
        onChanged: (bool value) {
          translate(value);
        },
        value: isEnglish,
        activeColor: Colors.white,
        inactiveTrackColor: Colors.white54,
        activeThumbImage: usIcon,
        inactiveThumbImage:
            Image.asset('assets/images/es_icon.png', scale: 17.0).image,
      ),
    ),
  );
}
