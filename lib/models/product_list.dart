import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

class ProdcutList with ChangeNotifier {
  final List<Product> _items = dummyProduct;

  List<Product> get items => [..._items];

  List<Product> get itemsFavorite =>
      _items.where((prod) => prod.isFavorite).toList();

  int get itemCount {
    return _items.length;
  }

  void saveProduct(Map<String, Object> data) {
    bool hashId = data['id'] != null;

    final newProduct = Product(
      id: hashId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );

    if (hashId) {
      updateProduct(newProduct);
    } else {
      addProduct(newProduct);
    }
    notifyListeners();
  }

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void updateProduct(Product product) {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }

  void removeProduct(Product product) {
    int index = _items.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      _items.removeWhere((p) => p.id == product.id);
      notifyListeners();
    }
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