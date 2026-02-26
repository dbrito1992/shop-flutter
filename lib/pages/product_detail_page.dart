import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop/models/product.dart';

class ProductDetailPage extends StatelessWidget {
  final _formater = NumberFormat.currency(locale: "pt_BR", name: "R\$");
  ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 300,
            foregroundColor: Colors.black,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(product.name, style: TextStyle(color: Colors.white)),
              centerTitle: true,
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: product.id,
                    child: Image.network(
                      product.imageUrl,
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0, 0.8),
                        end: Alignment(0, 0.0),
                        colors: [
                          Color.fromRGBO(0, 0, 0, 0.6),
                          Color.fromRGBO(0, 0, 0, 0.0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Column(
                children: [
                  SizedBox(height: 10),
                  Text(
                    _formater.format(product.price),
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                  SizedBox(height: 10),
                  Text(product.description, style: TextStyle(fontSize: 18)),
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
