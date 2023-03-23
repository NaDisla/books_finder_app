import 'dart:async';
import 'dart:ui';

import 'package:book_finder_app/lang/languages.dart';
import 'package:book_finder_app/models/models.dart';
import 'package:book_finder_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController bookTitleController = TextEditingController();
  bool hasBooks = false, isEnglish = true, isVisible = false;
  List<Item> obtainedBooks = [];
  final FlutterLocalization _localization = FlutterLocalization.instance;

  void changeHasBooks(List<Item> _obtainedBooks) {
    obtainedBooks = _obtainedBooks;
    setState(() => hasBooks = true);
  }

  void translate(bool value) {
    setState(() {
      isEnglish = value;
      if (isEnglish) {
        _localization.translate('en');
      } else {
        _localization.translate('es', save: false);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 50), () {
      if (this.mounted) {
        setState(() => isVisible = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.webp'),
              fit: BoxFit.cover,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              color: const Color(0xFF8D8364).withOpacity(0.5),
              child: Column(
                children: [
                  const SizedBox(
                    height: 55,
                  ),
                  SizedBox(
                    height: 120,
                    child: OverflowBox(
                      minHeight: 170,
                      maxHeight: 220,
                      child: Visibility(
                        visible: isVisible,
                        child: Lottie.asset(
                          'assets/icon-home.json',
                          width: 210.0,
                          height: 210.0,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    AppLocale.homeTitle.getString(context),
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  const SizedBox(height: 25.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SearchFieldWidget(
                          context: context,
                          bookTitleController: bookTitleController),
                      SearchButtonWidget(
                          context: context,
                          bookTitleController: bookTitleController,
                          hasBooks: changeHasBooks),
                    ],
                  ),
                  hasBooks
                      ? BooksListWidget(bookItems: obtainedBooks)
                      : HomeDescriptionWidget(context: context),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton:
            SwitchLanguageWidget(translate: translate, isEnglish: isEnglish),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      ),
      onWillPop: () async {
        if (hasBooks) {
          setState(() => hasBooks = false);
          return false;
        } else {
          return true;
        }
      },
    );
  }
}
