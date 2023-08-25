import 'dart:async';

import 'package:book_finder_app/services/services.dart';
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
  bool isEnglish = true, isVisible = false;
  BookService bookService = BookService();
  final FlutterLocalization localization = FlutterLocalization.instance;
  int navBarIndex = 0;
  bool isSearchPressed = true, isFavoritesPressed = false;

  void translate(bool value) {
    setState(() {
      isEnglish = value;
      if (isEnglish) {
        localization.translate('en');
      } else {
        localization.translate('es', save: false);
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

  void controlNavBarButton() {
    setState(() {
      if (isFavoritesPressed) {
        navBarIndex = 0;
        isSearchPressed = true;
        isFavoritesPressed = false;
      } else if (isSearchPressed) {
        navBarIndex = 1;
        isFavoritesPressed = true;
        isSearchPressed = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          extendBody: true,
          resizeToAvoidBottomInset: false,
          body: BackgroundWidget(
            color: Color(0xFF8D8364).withOpacity(0.5),
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
                  'BooksFinder',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontStyle: FontStyle.normal,
                    shadows: <Shadow>[
                      Shadow(
                          color: Colors.black,
                          blurRadius: 4.0,
                          offset: Offset(0, 4))
                    ],
                  ),
                ),
                const SizedBox(height: 25.0),
                Expanded(
                  child: IndexedStack(
                    index: navBarIndex,
                    children: [
                      BookSearchWidget(),
                      FavoritesBooksWidget(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton:
              SwitchLanguageWidget(translate: translate, isEnglish: isEnglish),
          floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
          bottomNavigationBar: BottomNavigationBarWidget(
            isSearchPressed: isSearchPressed,
            isFavoritesPressed: isFavoritesPressed,
            onPressedFn: controlNavBarButton,
          ),
        ),
      ),
    );
  }
}
