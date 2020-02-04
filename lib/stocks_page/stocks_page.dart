import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stock_monitor/bloc/stocks/bloc.dart';
import 'package:stock_monitor/bloc/stocks/stocks_bloc.dart';
import 'package:stock_monitor/database/moor_database.dart';

class StocksPage extends StatefulWidget {
  @override
  _StocksPageState createState() => _StocksPageState();
}

class _StocksPageState extends State<StocksPage> {
  final _stocksBloc = GetIt.instance<StocksBloc>();
  final _stocksList = List<Stock>();
  final _orderedStockSymbols = List<String>();

  @override
  void initState() {
    _stocksBloc.stocksStateSubject.listen((receivedState) {
      if (receivedState is StocksAreFetched) {
        setState(() {
          _stocksList.clear();
          _stocksList.addAll(receivedState.stocksList);

          _stocksList.forEach((stock) {
            _orderedStockSymbols.add(stock.symbol);
          });
          _sortSymbolsAlphabetically();
        });
      }
    });
    super.initState();

    _stocksBloc.dispatch(AllStocksRequested());
  }

  void _sortSymbolsAlphabetically() {
    _orderedStockSymbols.sort((a, b) => a.compareTo(b));
  }

  @override
  Widget build(BuildContext context) {
    _sortSymbolsAlphabetically();
    return Scaffold(
      appBar: AppBar(
        title: Text('Stocks List'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Table(
              children: [
                TableRow(
                  children: [
                    Container(
                      height: 30.0,
                      child: Center(
                        child: Text('Symbol'),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.grey),
                    ),
                    Container(
                      height: 30.0,
                      child: Center(
                        child: Text('Price'),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.grey),
                    ),
                    Container(
                      height: 30.0,
                      child: Center(
                        child: Text('Change'),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.grey),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 2.0, right: 2.0),
                      height: 30.0,
                      child: Center(
                        child: FittedBox(child: Text('Change%')),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.grey),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 2.0, right: 2.0),
                      height: 30.0,
                      child: Center(
                        child: FittedBox(child: Text('Buy T.Diff.')),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.grey),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 2.0, right: 2.0),
                      height: 30.0,
                      child: Center(
                        child: FittedBox(child: Text('Sell T.Diff.')),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            Table(
              children: _stocksList.map((stock) {
                return TableRow(
                  children: [
                    InkWell(
                      child: Container(
                        height: 30.0,
                        child: Center(
                          child: Text(stock.symbol),
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            color: Colors.grey),
                      ),
                      onTap: () {
                        print('SELECTED STOCK SYMBOL: ${stock.symbol} ==> ${stock.id}');
                        Navigator.pushNamed(context, '/add_stock_page',
                            arguments: {'stock': stock});
                      },
                    ),
                    Container(
                      height: 30.0,
                      child: Center(
                        child: Text('50'),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.white),
                    ),
                    Container(
                      height: 30.0,
                      child: Center(
                        child: Text('100'),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.white),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 2.0, right: 2.0),
                      height: 30.0,
                      child: Center(
                        child: FittedBox(child: Text('13%')),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.white),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 2.0, right: 2.0),
                      height: 30.0,
                      child: Center(
                        child: FittedBox(child: Text('-20')),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.white),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 2.0, right: 2.0),
                      height: 30.0,
                      child: Center(
                        child: FittedBox(child: Text('+40')),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.white),
                    ),
                  ],
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
