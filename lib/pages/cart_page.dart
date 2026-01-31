import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/item_cart_view.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/order_list.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of<Cart>(context);
    final items = cart.items.values.toList();
    return Scaffold(
      appBar: AppBar(title: Text("Carrinho")),
      body: cart.itemCount > 0
          ? Column(
              children: [
                Card(
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  elevation: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total: ", style: TextStyle(fontSize: 20)),
                        SizedBox(width: 10),
                        Chip(
                          color: WidgetStatePropertyAll(
                            Theme.of(context).colorScheme.primary,
                          ),
                          label: Text(
                            "R\$${cart.totalAmount.toStringAsFixed(2)}",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Spacer(),
                        TextButton(
                          onPressed: () {
                            Provider.of<OrderList>(
                              context,
                              listen: false,
                            ).addOrder(cart);

                            cart.clear();
                          },
                          child: Text(
                            "COMPRAR",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (ctx, i) {
                      return ItemCartView(item: items[i]);
                    },
                  ),
                ),
              ],
            )
          : Center(child: Text("Sem itens no carrinho...")),
    );
  }
}
