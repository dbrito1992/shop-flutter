import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/order_list.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/pages/cart_page.dart';
import 'package:shop/pages/order_page.dart';
import 'package:shop/pages/prodcuts.dart';
import 'package:shop/pages/product_detail_page.dart';
import 'package:shop/pages/product_overview_page.dart';
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
        ChangeNotifierProvider(create: (_) => ProdcutList()),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => OrderList()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Lato',
          colorScheme: .fromSeed(
            seedColor: Colors.yellow,
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
          AppRoutes.homeRoute: (ctx) => ProductOverviewPage(),
          AppRoutes.productDetalRoute: (ctx) => ProductDetailPage(),
          AppRoutes.cartRoute: (ctx) => CartPage(),
          AppRoutes.orderRoute: (ctx) => OrderPage(),
          AppRoutes.productRoute: (ctx) => ProdcutsWidget(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
