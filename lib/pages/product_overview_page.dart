import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/product_grid.dart';
import 'package:shop/models/product_list.dart';

enum FavoritiesActions { all, onlyFavorities }

class ProductOverviewPage extends StatelessWidget {
  const ProductOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProdcutList>(context);
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
              if (selectedValue == FavoritiesActions.onlyFavorities)
                {provider.showIsFavoriteOnly()}
              else
                {provider.showAll()},
            },
          ),
        ],
      ),
      body: Padding(padding: const EdgeInsets.all(10), child: ProductGrid()),
    );
  }
}
