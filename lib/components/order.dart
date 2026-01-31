import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop/models/order.dart';

class OrderView extends StatefulWidget {
  final Order order;
  const OrderView({super.key, required this.order});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  bool expanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 0.5,
          color: Colors.white,
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
          child: ListTile(
            title: Text("R\$ ${widget.order.total.toStringAsFixed(2)}"),
            subtitle: Text(
              DateFormat("dd/MM/yyyy hh:mm").format(widget.order.date),
            ),
            trailing: IconButton(
              onPressed: () => {
                setState(() {
                  expanded = !expanded;
                }),
              },
              icon: Icon(expanded ? Icons.expand_less : Icons.expand_more),
            ),
          ),
        ),
        if (expanded)
          Container(
            height: (widget.order.product.length * 24) + 10,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              color: Colors.white,
            ),
            child: ListView(
              children: widget.order.product.map((product) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(product.nameProd, style: TextStyle(fontSize: 18)),
                    Text(
                      "R\$${product.price.toStringAsFixed(2)}X${product.quantity}",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
