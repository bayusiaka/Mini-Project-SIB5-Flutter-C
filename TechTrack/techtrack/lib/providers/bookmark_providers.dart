import 'package:flutter/material.dart';
import 'package:techtrack/models/bookmark_model.dart';

class BookmarkProvider extends ChangeNotifier {
  final List<BookmarkProduct> _bookmarkProducts = [];

  List<BookmarkProduct> get bookmarkProducts => _bookmarkProducts;

  void addBookmarkProduct(BookmarkProduct product) {
    _bookmarkProducts.add(product);
    notifyListeners();
  }

  void removeBookmarkProduct(BookmarkProduct product) {
    _bookmarkProducts.remove(product);
    notifyListeners();
  }
}