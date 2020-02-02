import 'package:flutter/material.dart';
import 'package:stock_monitor/stock_add_page/stock_add_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stocks Monitor',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      routes: {
        '/': (context) => StockAddPage(),
      },
    );
  }
}

