import 'package:flutter/material.dart';
import 'package:shop/pages/product_overview_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
          titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          centerTitle: true,
        ),
      ),
      home: ProductOverviewPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
