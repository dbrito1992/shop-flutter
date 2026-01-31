import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/drawer.dart';
import 'package:shop/components/order.dart';
import 'package:shop/models/order_list.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderList orders = Provider.of(context);
    return Scaffold(
      appBar: AppBar(title: Text("Meus Pedidos")),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: orders.itemCount,
        itemBuilder: (ctx, i) {
          return OrderView(order: orders.items[i]);
        },
      ),
    );
  }
}
