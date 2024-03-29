import 'dart:ui';

import 'package:book_finder_app/lang/languages.dart';
import 'package:book_finder_app/screens/screens.dart';
import 'package:book_finder_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  State<BottomNavigationBarWidget> createState() => _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  bool isSearchPressed = true, isFavoritesPressed = false;

  @override
  Widget build(BuildContext context) {
    final List<Shadow> shadowList = const <Shadow>[Shadow(color: Color(0xFF967509), blurRadius: 20.0, offset: Offset(0, 5))];
    return ClipRRect(
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
                    overlayColor: MaterialStateColor.resolveWith((states) => Color(0xFF967509).withOpacity(0.1)),
                  ),
                  onPressed: () {
                    setState(() {
                      HomeScreenState.navBarIndex.value = 0;
                      if (isSearchPressed == false) {
                        isSearchPressed = true;
                        isFavoritesPressed = false;
                      }
                    });
                  },
                  child: isSearchPressed
                      ? BottomNavigationBarButtonWidget(
                          icon: Icons.search,
                          btnColor: Color(0xFF967509),
                          btnText: AppLocale.btnSearch.getString(context),
                          isImageButton: false,
                          isImageButtonSelected: false,
                          shadowList: shadowList,
                        )
                      : BottomNavigationBarButtonWidget(
                          icon: Icons.search,
                          btnColor: Colors.black,
                          btnText: AppLocale.btnSearch.getString(context),
                          isImageButton: false,
                          isImageButtonSelected: false,
                        ),
                ),
                SizedBox(width: 88.0),
                TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateColor.resolveWith((_) => Color(0xFF967509).withOpacity(0.1)),
                  ),
                  onPressed: () {
                    setState(() {
                      HomeScreenState.navBarIndex.value = 1;
                      if (isFavoritesPressed == false) {
                        isFavoritesPressed = true;
                        isSearchPressed = false;
                      }
                    });
                  },
                  child: isFavoritesPressed
                      ? BottomNavigationBarButtonWidget(
                          imagePath: 'assets/images/favorite_orange_icon.png',
                          btnColor: Color(0xFF967509),
                          btnText: AppLocale.btnFavorites.getString(context),
                          isImageButton: false,
                          isImageButtonSelected: true,
                          shadowList: shadowList,
                        )
                      : BottomNavigationBarButtonWidget(
                          btnColor: Colors.black,
                          btnText: AppLocale.btnFavorites.getString(context),
                          isImageButton: true,
                          isImageButtonSelected: false,
                          imagePath: 'assets/images/favorite_black_icon.png',
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
