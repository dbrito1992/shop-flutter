import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/auth.dart';
import 'package:shop/pages/auth_page.dart';
import 'package:shop/pages/product_overview_page.dart';

class AuthOrHome extends StatelessWidget {
  const AuthOrHome({super.key});

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of(context);
    //return auth.isAuth ? ProductOverviewPage() : AuthPage();
    return FutureBuilder(
      future: auth.tryAutoLogin(),
      builder: (ctx, snapShot) {
        if (snapShot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapShot.error != null) {
          return Center(child: Text("Ocorreu um erro!"));
        } else {
          return auth.isAuth ? ProductOverviewPage() : AuthPage();
        }
      },
    );
  }
}
