import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/models/cart.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/models/order.dart';
import 'package:shop/utils/constants.dart';

class OrderList with ChangeNotifier {
  final String _token;
  final String _uId;
  final List<Order> _items;

  List<Order> get items {
    return [..._items.reversed];
  }

  int get itemCount {
    return _items.length;
  }

  OrderList([this._token = '', this._items = const [], this._uId = '']);

  Future<void> loadOrders() async {
    _items.clear();
    final response = await http.get(
      Uri.parse('${Constants.baseUrlOrders}/$_uId.json?auth=$_token'),
    );
    if (response.body == 'null') return;
    final Map<String, dynamic> orders = jsonDecode(response.body);
    orders.forEach((orderId, items) {
      _items.add(
        Order(
          id: orderId,
          date: DateTime.parse(items['date']),
          total: items['total'],
          product: (items['product'] as List<dynamic>).map((item) {
            return CartItem(
              id: item['id'],
              productId: item['productId'],
              nameProd: item['nameProd'],
              quantity: item['quantity'],
              price: item['price'],
            );
          }).toList(),
        ),
      );
    });
    notifyListeners();
  }

  Future<void> addOrder(Cart cart) async {
    final date = DateTime.now();

    final response = await http.post(
      Uri.parse('${Constants.baseUrlOrders}/$_uId.json?auth=$_token'),
      body: jsonEncode({
        'total': cart.totalAmount,
        'date': date.toIso8601String(),
        'product': cart.items.values
            .map(
              (cartItem) => {
                'id': cartItem.id,
                'productId': cartItem.productId,
                'nameProd': cartItem.nameProd,
                'quantity': cartItem.quantity,
                'price': cartItem.price,
              },
            )
            .toList(),
      }),
    );

    final id = jsonDecode(response.body)['name'];

    _items.insert(
      0,
      Order(
        id: id,
        product: cart.items.values.toList(),
        date: date,
        total: cart.totalAmount,
      ),
    );

    notifyListeners();
  }
}
