import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/auth.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/order_list.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/pages/auth_or_home.dart';
import 'package:shop/pages/cart_page.dart';
import 'package:shop/pages/order_page.dart';
import 'package:shop/pages/product_form_page.dart';
import 'package:shop/pages/products_page.dart';
import 'package:shop/pages/product_detail_page.dart';
import 'package:shop/utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth()),
        ChangeNotifierProxyProvider<Auth, ProdcutList>(
          create: (_) => ProdcutList(),
          update: (ctx, auth, previus) {
            return ProdcutList(auth.token, previus?.items ?? [], auth.uid);
          },
        ),
        ChangeNotifierProxyProvider<Auth, OrderList>(
          create: (_) => OrderList(),
          update: (ctx, auth, previous) {
            return OrderList(auth.token, previous?.items ?? [], auth.uid);
          },
        ),
        ChangeNotifierProvider(create: (_) => Cart()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Lato',
          colorScheme: .fromSeed(
            seedColor: Colors.white,
            primary: Colors.deepOrange,
            secondary: Colors.yellow,
          ),
          primaryColor: Colors.deepOrange,
          appBarTheme: AppBarTheme(
            elevation: 5,
            foregroundColor: Colors.white,
            backgroundColor: Colors.deepOrange,
            titleTextStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        //home: ProductOverviewPage(),
        routes: {
          AppRoutes.authOrHomeRoute: (ctx) => AuthOrHome(),
          AppRoutes.productDetalRoute: (ctx) => ProductDetailPage(),
          AppRoutes.cartRoute: (ctx) => CartPage(),
          AppRoutes.orderRoute: (ctx) => OrderPage(),
          AppRoutes.productRoute: (ctx) => ProdcutsWidget(),
          AppRoutes.producFormRoute: (ctx) => ProductFormPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
