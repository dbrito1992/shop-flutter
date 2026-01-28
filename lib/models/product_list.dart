import 'package:flutter/material.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

class ProdcutList with ChangeNotifier {
  final List<Product> _items = dummyProduct;

  List<Product> get items => [..._items];

  List<Product> get itemsFavorite =>
      _items.where((prod) => prod.isFavorite).toList();

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }
}


// bool _isFavoriteOnly = false;

//   List<Product> get items {
//     if (_isFavoriteOnly) {
//       return _items.where((prod) => prod.isFavorite).toList();
//     }
//     return [..._items];
//   }

//   void showIsFavoriteOnly() {
//     _isFavoriteOnly = true;
//     notifyListeners();
//   }

//   void showAll() {
//     _isFavoriteOnly = false;
//     notifyListeners();
//   }