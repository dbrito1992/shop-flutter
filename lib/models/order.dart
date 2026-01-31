import 'package:shop/models/cart_item.dart';

class Order {
  final String id;
  final List<CartItem> product;
  final double total;
  final DateTime date;

  Order({
    required this.id,
    required this.product,
    required this.date,
    required this.total,
  });
}
