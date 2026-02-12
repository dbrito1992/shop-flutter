import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/models/product.dart';

class ProdcutList with ChangeNotifier {
  final _url = "https://shop-di-default-rtdb.firebaseio.com/products.json";
  final List<Product> _items = [];

  List<Product> get items => [..._items];

  List<Product> get itemsFavorite =>
      _items.where((prod) => prod.isFavorite).toList();

  int get itemCount {
    return _items.length;
  }

  Future<void> loadProducts() async {
    _items.clear();
    final response = await http.get(Uri.parse(_url));
    if (response.body == 'null') return;
    final Map<String, dynamic> products = jsonDecode(response.body);
    products.forEach((productId, items) {
      _items.add(
        Product(
          id: productId,
          name: items['name'],
          description: items['description'],
          price: items['price'],
          imageUrl: items['imageUrl'],
          isFavorite: items['isFavorite'],
        ),
      );
    });
    notifyListeners();
  }

  Future<void> saveProduct(Map<String, Object> data) {
    bool hashId = data['id'] != null;

    final newProduct = Product(
      id: hashId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );

    if (hashId) {
      return updateProduct(newProduct);
    } else {
      return addProduct(newProduct);
    }
  }

  Future<void> addProduct(Product product) async {
    final response = await http.post(
      Uri.parse(_url),
      body: jsonEncode({
        "name": product.name,
        "description": product.description,
        "isFavorite": product.isFavorite,
        "price": product.price,
        "imageUrl": product.imageUrl,
      }),
    );

    final id = jsonDecode(response.body)['name'];
    _items.add(
      Product(
        id: id,
        name: product.name,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      ),
    );
    notifyListeners();
  }

  Future<void> updateProduct(Product product) {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }

    return Future.value();
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