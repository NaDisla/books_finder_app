import 'dart:async';

import 'package:book_finder_app/services/services.dart';
import 'package:book_finder_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  bool isEnglish = true, isVisible = false;
  BookService bookService = BookService();
  final FlutterLocalization localization = FlutterLocalization.instance;
  static ValueNotifier<int> navBarIndex = ValueNotifier(0);

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
      if (mounted) {
        setState(() => isVisible = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
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
            color: const Color.fromRGBO(141, 131, 100, 0.5),
            child: Column(
              children: [
                const SizedBox(height: 55),
                SizedBox(
                  height: 120.0,
                  child: OverflowBox(
                    minHeight: 170.0,
                    maxHeight: deviceWidth < 500 ? 220 : 270.0,
                    child: Visibility(
                      visible: isVisible,
                      child: Lottie.asset(
                        'assets/icon-home.json',
                        width: deviceWidth < 500 ? 210.0 : 270.0,
                        height: deviceWidth < 500 ? 210.0 : 270.0,
                      ),
                    ),
                  ),
                ),
                const Text(
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
                        offset: Offset(0, 4),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 25.0),
                Expanded(
                  child: ValueListenableBuilder(
                      valueListenable: navBarIndex,
                      builder:
                          (BuildContext context, int navIndex, Widget? child) {
                        return IndexedStack(
                          index: navIndex,
                          children: const [
                            BookSearchWidget(),
                            FavoritesBooksWidget(),
                          ],
                        );
                      }),
                ),
              ],
            ),
          ),
          floatingActionButton:
              SwitchLanguageWidget(translate: translate, isEnglish: isEnglish),
          floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
          bottomNavigationBar: const BottomNavigationBarWidget(),
        ),
      ),
    );
  }
}
