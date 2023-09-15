import 'dart:convert';

import 'package:book_finder_app/core/utils.dart';
import 'package:book_finder_app/lang/languages.dart';
import 'package:book_finder_app/models/models.dart';
import 'package:book_finder_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

class FavoritesBooksWidget extends StatefulWidget {
  const FavoritesBooksWidget({super.key});

  @override
  State<FavoritesBooksWidget> createState() => FavoritesBooksWidgetState();
}

class FavoritesBooksWidgetState extends State<FavoritesBooksWidget> {
  static ValueNotifier<List<Item>> favoritesBooks = ValueNotifier([]);

  void getFavoritesBooks() async {
    List<String> savedBooks = await Utils.getFavoritesBooks();
    setState(() => favoritesBooks.value = savedBooks.map((map) => Item.fromApiItems(jsonDecode(map))).toList());
  }

  @override
  void initState() {
    getFavoritesBooks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double customPadding = MediaQuery.of(context).size.width * 0.03;
    return ValueListenableBuilder(
      valueListenable: favoritesBooks,
      builder: (BuildContext context, List<Item> favBooks, Widget? child) {
        if (favBooks.isEmpty) {
          return Padding(
            padding: EdgeInsets.only(left: customPadding, right: customPadding),
            child: EmptyResultsWidget(
              message: AppLocale.favoritesEmptyResults.getString(context),
            ),
          );
        } else {
          return BooksListWidget(bookItems: favBooks);
        }
      },
    );
  }
}
