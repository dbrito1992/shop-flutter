import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(product.imageUrl)),
      title: Text(product.title),
      trailing: Column(
        children: [
          SizedBox(
            width: 100,
            child: Row(
              children: [
                IconButton(
                  color: Colors.blue,
                  onPressed: () {},
                  icon: Icon(Icons.edit),
                ),
                IconButton(
                  color: Colors.red,
                  onPressed: () {},
                  icon: Icon(Icons.delete),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
