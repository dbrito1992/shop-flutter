import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/Bagdee.dart';
import 'package:shop/components/product_grid.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/utils/app_routes.dart';

enum FavoritiesActions { all, onlyFavorities }

class ProductOverviewPage extends StatefulWidget {
  const ProductOverviewPage({super.key});

  @override
  State<ProductOverviewPage> createState() => _ProductOverviewPageState();
}

class _ProductOverviewPageState extends State<ProductOverviewPage> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Minha Loja"),
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => [
              PopupMenuItem(value: FavoritiesActions.all, child: Text("Todos")),
              PopupMenuItem(
                value: FavoritiesActions.onlyFavorities,
                child: Text("Só os Favoritos"),
              ),
            ],
            onSelected: (FavoritiesActions selectedValue) => {
              setState(() {
                if (selectedValue == FavoritiesActions.onlyFavorities) {
                  _isFavorite = true;
                } else {
                  _isFavorite = false;
                }
              }),
            },
          ),
          Bagdee(
            value: cart.itemCount,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.cartRoute);
              },
              icon: Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ProductGrid(_isFavorite),
      ),
    );
  }
}
