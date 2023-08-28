import 'dart:convert';

import 'package:book_finder_app/core/utils.dart';
import 'package:book_finder_app/models/models.dart';
import 'package:book_finder_app/widgets/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FavoritesBooksWidget extends StatefulWidget {
  final ValueListenable<int>? number;
  const FavoritesBooksWidget({
    super.key,
    this.number,
  });

  @override
  State<FavoritesBooksWidget> createState() => FavoritesBooksWidgetState();
}

class FavoritesBooksWidgetState extends State<FavoritesBooksWidget> {
  List<Item> favoritesBooks = [];

  void getFavoritesBooks() async {
    List<String> savedBooks = await Utils.getFavoritesBooks();
    setState(() => favoritesBooks =
        savedBooks.map((map) => Item.fromApiItems(jsonDecode(map))).toList());
  }

  @override
  void initState() {
    getFavoritesBooks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BooksListWidget(bookItems: favoritesBooks);
    // return Center(
    //   child: Text(widget.number.toString()),
    // );
  }
}
