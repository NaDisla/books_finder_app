import 'dart:convert';

import 'package:book_finder_app/models/models.dart';
import 'package:http/http.dart' as http;

class BookService {
  http.Client client = http.Client();
  String baseUrl = "https://www.googleapis.com/books/v1/volumes?q=";
  String maxResults = "&maxResults=40";

  Future<List<Item>> getAllBooks(String title) async {
    Book parsedBooks;
    Uri baseUrlParsed = Uri.parse("$baseUrl$title$maxResults");
    http.Response booksResponse = await client.get(baseUrlParsed);

    if (booksResponse.statusCode == 200) {
      String jsonBooks = booksResponse.body;
      parsedBooks = Book.fromApiBooks(json.decode(jsonBooks));
      return parsedBooks.items;
    } else {
      throw Exception("Failed getting books");
    }
  }

  static String getBookUrl(String id, String volumeInfoTitle) {
    String launchUrlBook =
        "https://books.google.com.do/books?id=${id}&dq=${volumeInfoTitle}";
    return launchUrlBook;
  }
}
