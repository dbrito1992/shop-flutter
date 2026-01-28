import 'package:flutter/material.dart';
import 'package:shop/components/product_grid.dart';

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
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ProductGrid(_isFavorite),
      ),
    );
  }
}
