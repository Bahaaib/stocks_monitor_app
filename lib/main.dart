import 'package:flutter/material.dart';
import 'package:stock_monitor/buy_stocks_page/buy_stocks_page.dart';
import 'package:stock_monitor/sell_stocks_page/sell_stocks_page.dart';
import 'package:stock_monitor/stock_add_page/stock_add_page.dart';
import 'package:stock_monitor/stocks_page/stocks_page.dart';

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
        '/': (context) => SellStocksPage(),
      },
    );
  }
}

