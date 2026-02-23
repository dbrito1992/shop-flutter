import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/auth.dart';
import 'package:shop/utils/app_routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text("Bem vindos usuários", textAlign: TextAlign.center),
            automaticallyImplyLeading: false,
            centerTitle: true,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
            onTap: () {
              Navigator.of(
                context,
              ).pushReplacementNamed(AppRoutes.authOrHomeRoute);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text("Pedidos"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.orderRoute);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text("Produtos"),
            onTap: () {
              Navigator.of(
                context,
              ).pushReplacementNamed(AppRoutes.productRoute);
            },
          ),

          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Sair"),
            onTap: () {
              Provider.of<Auth>(context, listen: false).logout();
              Navigator.of(
                context,
              ).pushReplacementNamed(AppRoutes.authOrHomeRoute);
            },
          ),
        ],
      ),
    );
  }
}
