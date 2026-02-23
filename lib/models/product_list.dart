import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/http_exception/http_exception.dart';
import 'package:shop/models/product.dart';
import 'package:shop/utils/constants.dart';

class ProdcutList with ChangeNotifier {
  final String _token;
  final String _uId;
  final List<Product> _items;

  List<Product> get items => [..._items];

  List<Product> get itemsFavorite =>
      _items.where((prod) => prod.isFavorite).toList();

  ProdcutList([this._token = '', this._items = const [], this._uId = '']);

  int get itemCount {
    return _items.length;
  }

  Future<void> loadProducts() async {
    _items.clear();
    final response = await http.get(
      Uri.parse('${Constants.baseUrlProducts}.json?auth=$_token'),
    );
    if (response.body == 'null') return;

    final favResponse = await http.get(
      Uri.parse(
        '${Constants.baseUrlProductsFavorities}/$_uId.json?auth=$_token',
      ),
    );

    Map<String, dynamic> favData = favResponse.body == 'null'
        ? {}
        : jsonDecode(favResponse.body);

    final Map<String, dynamic> products = jsonDecode(response.body);
    products.forEach((productId, items) {
      final isFavorite = favData[productId] ?? false;
      _items.add(
        Product(
          id: productId,
          name: items['name'],
          description: items['description'],
          price: items['price'],
          imageUrl: items['imageUrl'],
          isFavorite: isFavorite,
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
      Uri.parse('${Constants.baseUrlProducts}.json?auth=$_token'),
      body: jsonEncode({
        "name": product.name,
        "description": product.description,
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

  Future<void> updateProduct(Product product) async {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      await http.patch(
        Uri.parse(
          '${Constants.baseUrlProducts}/${product.id}.json?auth=$_token',
        ),
        body: jsonEncode({
          "name": product.name,
          "description": product.description,
          "price": product.price,
          "imageUrl": product.imageUrl,
        }),
      );
      _items[index] = product;
      notifyListeners();
    }

    return Future.value();
  }

  Future<void> removeProduct(Product product) async {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      final product = _items[index];
      notifyListeners();

      _items.remove(product);

      final response = await http.delete(
        Uri.parse(
          '${Constants.baseUrlProducts}/${product.id}.json?auth=$_token',
        ),
      );

      if (response.statusCode >= 400) {
        _items.insert(index, product);
        notifyListeners();

        throw HttpException(
          msg: "Não foi possivel deletar o produto!",
          statusCode: response.statusCode,
        );
      }
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