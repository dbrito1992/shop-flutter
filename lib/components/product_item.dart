import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/utils/app_routes.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(product.imageUrl)),
      title: Text(product.name),
      trailing: Column(
        children: [
          SizedBox(
            width: 100,
            child: Row(
              children: [
                IconButton(
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).pushNamed(AppRoutes.producFormRoute, arguments: product);
                  },
                  icon: Icon(Icons.edit),
                ),
                IconButton(
                  color: Colors.red,
                  onPressed: () async {
                    await showDialog<bool>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text("Deseja excluir este item?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: Text("Não"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                            child: Text("Sim"),
                          ),
                        ],
                      ),
                    ).then((value) {
                      if (value ?? false) {
                        Provider.of<ProdcutList>(
                          context,
                          listen: false,
                        ).removeProduct(product);
                      }
                    });
                  },
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
