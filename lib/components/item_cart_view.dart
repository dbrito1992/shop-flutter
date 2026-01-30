import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/cart_item.dart';

class ItemCartView extends StatelessWidget {
  final CartItem item;
  const ItemCartView({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(item.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        color: Theme.of(context).colorScheme.error,
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Icon(Icons.delete, color: Colors.white, size: 26),
      ),
      onDismissed: (_) {
        Provider.of<Cart>(context, listen: false).removeItem(item.productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        color: Colors.white,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: FittedBox(
                child: Text(
                  item.price.toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          title: Text(item.nameProd),
          subtitle: Text("R\$ ${item.price * item.quantity}"),
          trailing: Text("${item.quantity}X", style: TextStyle(fontSize: 16)),
        ),
      ),
    );
  }
}
