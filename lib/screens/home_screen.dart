import 'dart:async';
import 'dart:ui';
import 'package:book_finder_app/lang/languages.dart';
import 'package:book_finder_app/models/models.dart';
import 'package:book_finder_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:lottie/lottie.dart';
import 'package:simple_shadow/simple_shadow.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController bookTitleController = TextEditingController();
  bool hasBooks = false,
      isEnglish = true,
      isVisible = false,
      _isSearchPressed = true,
      _isFavoritesPressed = false;
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
        extendBody: true,
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
                      ? Container(
                          height: 322,
                          child: BooksListWidget(bookItems: obtainedBooks))
                      : HomeDescriptionWidget(context: context),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton:
            SwitchLanguageWidget(translate: translate, isEnglish: isEnglish),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              height: 90,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateColor.resolveWith(
                            (states) => Color(0xFF967509).withOpacity(0.1)),
                      ),
                      onPressed: () {
                        setState(() {
                          if (_isFavoritesPressed) {
                            _isSearchPressed = true;
                            _isFavoritesPressed = false;
                          }
                        });
                      },
                      child: _isSearchPressed
                          ? Column(
                              children: [
                                Icon(
                                  Icons.search,
                                  size: 30,
                                  color: Color(0xFF967509),
                                  shadows: <Shadow>[
                                    Shadow(
                                        color: Color(0xFF967509),
                                        blurRadius: 20.0,
                                        offset: Offset(0, 5))
                                  ],
                                ),
                                Text(
                                  'Search',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Color(0xFF967509),
                                    shadows: <Shadow>[
                                      Shadow(
                                          color: Color(0xFF967509),
                                          blurRadius: 20.0,
                                          offset: Offset(0, 5))
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                Icon(
                                  Icons.search,
                                  size: 30,
                                  color: Colors.black,
                                ),
                                Text(
                                  'Search',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                    ),
                    SizedBox(width: 88.0),
                    TextButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateColor.resolveWith(
                            (states) => Color(0xFF967509).withOpacity(0.1)),
                      ),
                      onPressed: () {
                        setState(() {
                          if (_isSearchPressed) {
                            _isFavoritesPressed = true;
                            _isSearchPressed = false;
                          }
                        });
                      },
                      child: _isFavoritesPressed
                          ? Column(
                              children: [
                                SimpleShadow(
                                  child: Image.asset(
                                    filterQuality: FilterQuality.high,
                                    'assets/images/favorite_orange_icon.png',
                                    width: 28,
                                    height: 28,
                                  ),
                                  opacity: 0.6,
                                  color: Color(0xFF967509),
                                  offset: Offset(0, 5),
                                  sigma: 7,
                                ),
                                Text(
                                  'Favorites',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Color(0xFF967509),
                                    shadows: <Shadow>[
                                      Shadow(
                                        color: Color(0xFF967509),
                                        blurRadius: 20.0,
                                        offset: Offset(0, 5),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                Image.asset(
                                  'assets/images/favorite_black_icon.png',
                                  width: 28,
                                  height: 28,
                                ),
                                Text(
                                  'Favorites',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
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
