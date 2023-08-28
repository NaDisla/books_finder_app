import 'package:book_finder_app/services/services.dart';
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

  static Future<List<String>> getFavoritesBooks() async {
    final SharedPreferences localPrefs = await SharedPreferences.getInstance();
    return localPrefs.getStringList("favoritesBooks") ?? [];
  }
}
