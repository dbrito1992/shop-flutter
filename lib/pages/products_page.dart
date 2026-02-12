import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/drawer.dart';
import 'package:shop/components/product_item.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/utils/app_routes.dart';

class ProdcutsWidget extends StatelessWidget {
  const ProdcutsWidget({super.key});

  Future<void> _refreshProducts(BuildContext context) {
    return Provider.of<ProdcutList>(context, listen: false).loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    final ProdcutList products = Provider.of<ProdcutList>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Gerenciar Produtos"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.producFormRoute);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: ListView.builder(
          itemCount: products.itemCount,
          itemBuilder: (ctx, i) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [ProductItem(products.items[i]), Divider()],
              ),
            );
          },
        ),
      ),
    );
  }
}
