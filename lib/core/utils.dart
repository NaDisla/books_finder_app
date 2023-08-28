import 'dart:convert';

import 'package:book_finder_app/models/models.dart';
import 'package:book_finder_app/services/services.dart';
import 'package:book_finder_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Utils {
  static TextStyle authorDateStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Color(0xFF6A6A6A),
  );
  static Color darkYellowColor = Color(0xFF786C44);
  static Color darkRedColor = Color(0xFF8B1E1E);

  static void getGoogleBooksInfo(String id, String volumeInfoTitle) {
    Uri bookUrl = Uri.parse(
      BookService.getBookUrl(id, volumeInfoTitle),
    );
    launchUrlString(
      bookUrl.toString(),
      mode: LaunchMode.externalApplication,
    );
  }

  static String bookToMap(Item book) {
    Map<String, dynamic> bookMap = Item.toMap(book);
    String jsonBook = jsonEncode(bookMap);
    return jsonBook;
  }

  static Future<List<String>> getFavoritesBooks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList("favoritesBooks") ?? [];
  }

  static void setFavoritesBooks(List<String> savedFavBooks, Item book, String action) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (action == "add") {
      savedFavBooks.add(bookToMap(book));
    } else {
      savedFavBooks.remove(bookToMap(book));
    }
    await prefs.setStringList("favoritesBooks", savedFavBooks);
    List<Item> favBooks = savedFavBooks.map((map) => Item.fromApiItems(jsonDecode(map))).toList();
    FavoritesBooksWidgetState.favoritesBooks.value = favBooks;
  }
}
