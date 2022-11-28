import 'package:http/http.dart' as http;
import 'package:book_finder_app/models/models.dart';
import 'dart:convert';

class BookService {
  http.Client client = http.Client();
  String baseUrl = "https://www.googleapis.com/books/v1/volumes?q=";

  Future<Book> getAllBooks(String title) async {
    Book parsedBooks;
    Uri baseUrlParsed = Uri.parse("$baseUrl$title");
    http.Response booksResponse = await client.get(baseUrlParsed);

    if (booksResponse.statusCode == 200) {
      String jsonBooks = booksResponse.body;
      parsedBooks = Book.fromApiBooks(json.decode(jsonBooks));
      //Book.from(json.decode(jsonBooks).map((b) => Book.fromApiBooks(b)));
      return parsedBooks;
    } else {
      throw "Failed getting books";
    }
  }
}
