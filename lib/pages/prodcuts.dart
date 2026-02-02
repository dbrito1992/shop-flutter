import 'package:flutter/material.dart';
import 'package:shop/components/drawer.dart';

class ProdcutsWidget extends StatelessWidget {
  const ProdcutsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Gerenciar Produtos")),
      drawer: AppDrawer(),
    );
  }
}
