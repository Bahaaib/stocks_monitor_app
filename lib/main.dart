import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stock_monitor/bloc/stocks/bloc.dart';
import 'package:stock_monitor/buy_stocks_page/buy_stocks_page.dart';
import 'package:stock_monitor/database/moor_database.dart';
import 'package:stock_monitor/sell_stocks_page/sell_stocks_page.dart';
import 'package:stock_monitor/stock_add_page/stock_add_page.dart';
import 'package:stock_monitor/stocks_page/stocks_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GetIt.instance.registerSingleton<StocksDatabase>(StocksDatabase());
    GetIt.instance.registerSingleton<StocksBloc>(StocksBloc());
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
