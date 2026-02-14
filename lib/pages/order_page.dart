import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/drawer.dart';
import 'package:shop/components/order.dart';
import 'package:shop/models/order_list.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<OrderList>(context, listen: false).loadOrders().then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final OrderList orders = Provider.of(context);
    return Scaffold(
      appBar: AppBar(title: Text("Meus Pedidos")),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () {
          return Provider.of<OrderList>(context, listen: false).loadOrders();
        },
        child: ListView.builder(
          itemCount: orders.itemCount,
          itemBuilder: (ctx, i) {
            return OrderView(order: orders.items[i]);
          },
        ),
      ),
    );
  }
}
