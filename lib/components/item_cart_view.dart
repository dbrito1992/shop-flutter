import 'package:flutter/material.dart';
import 'package:shop/models/cart_item.dart';

class ItemCartView extends StatelessWidget {
  final CartItem item;
  const ItemCartView({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Text(item.nameProd);
  }
}
