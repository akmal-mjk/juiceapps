import 'package:flutter/material.dart';
import 'package:juiceapps/pages/product/form_product_page.dart';
import 'package:juiceapps/pages/product/homescreen.dart';
import 'package:juiceapps/pages/reseller/form_reseler_page.dart';
import 'package:juiceapps/pages/reseller/reselerscreen.dart';
import 'package:juiceapps/pages/stock/form_stock_page.dart';
import 'package:juiceapps/pages/stock/stockscreen.dart';
import 'package:juiceapps/pages/welcome_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/product': (context) => productPages(),
        '/add-product': (context) => ProductFormPage(),
        '/stock': (context) => stockPages(),
        '/add-stock': (context) => StockFormPage(),
        '/reseler': (context) => reselerPages(),
        '/add-reseler': (context) => ReselerFormPage(),
      },
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 241, 214, 81),
      ),
      home: const WelcomePage(),
    );
  }
}
