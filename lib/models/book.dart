import 'models.dart';

class Book {
  int totalItems;
  List<Item> items;

  Book({required this.totalItems, required this.items});

  factory Book.fromApiBooks(Map<String, dynamic> json) {
    return Book(
        totalItems: json['totalItems'],
        items: List<Item>.from(json['items'].map((x) => Item.fromApiItems(x))));
  }
}
