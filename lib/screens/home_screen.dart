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
  bool hasBooks = false, isEnglish = true;
  List<Item> obtainedBooks = [];
  Timer timer = Timer(const Duration(seconds: 2), () {});
  final FlutterLocalization _localization = FlutterLocalization.instance;
  //ImageProvider backgroundImage = AssetImage('assets/images/background.webp');

  // @override
  // void initState() {
  //   super.initState();
  //   backgroundImage = Image.asset("assets/images/background.webp");
  // }

  // @override
  // void didChangeDependencies() {
  //   precacheImage(backgroundImage.image, context);
  //   super.didChangeDependencies();
  // }

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
  Widget build(BuildContext context) {
    return Scaffold(
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
                    child: Lottie.asset(
                      'assets/icon-home.json',
                      width: 210.0,
                      height: 210.0,
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
                    SearchFieldWidget(context, bookTitleController),
                    SearchButtonWidget(
                        context, bookTitleController, changeHasBooks)
                  ],
                ),
                hasBooks
                    ? BooksListWidget(bookItems: obtainedBooks)
                    : Expanded(
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
                      ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: SwitchLanguageWidget(translate, isEnglish),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
