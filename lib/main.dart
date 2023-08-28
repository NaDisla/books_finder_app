import 'dart:io';

import 'package:book_finder_app/lang/languages.dart';
import 'package:book_finder_app/screens/screens.dart';
import 'package:book_finder_app/services/custom_http_overrides.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

void main() {
  HttpOverrides.global = CustomHttpOverrides();
  runApp(BookFinderApp());
}

class BookFinderApp extends StatefulWidget {
  BookFinderApp({super.key});

  @override
  State<BookFinderApp> createState() => _BookFinderAppState();
}

class _BookFinderAppState extends State<BookFinderApp> {
  final FlutterLocalization _localization = FlutterLocalization.instance;

  @override
  void initState() {
    _localization.init(
      mapLocales: [
        const MapLocale('en', AppLocale.EN),
        const MapLocale('es', AppLocale.ES),
      ],
      initLanguageCode: 'en',
    );
    _localization.onTranslatedLanguage = _onTranslatedLanguage;
    super.initState();
  }

  void _onTranslatedLanguage(Locale? locale) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        fontFamily: 'Gentium Book Basic',
      ),
      supportedLocales: _localization.supportedLocales,
      localizationsDelegates: _localization.localizationsDelegates,
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
