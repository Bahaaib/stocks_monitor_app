import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:stock_monitor/API/api_manager.dart';
import 'package:stock_monitor/PODO/APIStock.dart';
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
  final _requestedSymbols = List<String>();
  final _remoteStocks = List<APIStock>();
  ProgressDialog _progressDialog;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('SHOWN');
      _progressDialog.show();
    });
    _stocksBloc.stocksStateSubject.listen((receivedState) {
      if (receivedState is StocksAreFetched) {
        if (!_progressDialog.isShowing()) {
          print('SHOWN');
          _progressDialog.show();
        }
        _stocksList.clear();
        _stocksList.addAll(receivedState.stocksList);
        _fillRequestedSymbolsList();
        if (_requestedSymbols.isNotEmpty) {
          _stocksBloc.dispatch(StocksRemoteDataRequested(_requestedSymbols));
        } else {
          _progressDialog.dismiss();
        }
      }

      if (receivedState is StocksDataIsFetched) {
        _progressDialog.dismiss();
        setState(() {
          _remoteStocks.clear();
          _remoteStocks.addAll(receivedState.stocks.stocksList);
          print('DISMISSED');
        });
      }
    });

    _stocksBloc.dispatch(AllStocksRequested());
    super.initState();
  }

  void _fillRequestedSymbolsList() {
    _requestedSymbols.clear();
    _stocksList.forEach((stock) => _requestedSymbols.add(stock.symbol));
  }

  void _initProgressDialog() {
    _progressDialog.style(
      message: 'Fetching data...',
      backgroundColor: Colors.white,
      progressWidget: CircularProgressIndicator(),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w600),
    );
  }

  @override
  Widget build(BuildContext context) {
    _progressDialog = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
    _initProgressDialog();

    return Scaffold(
      appBar: AppBar(
        title: Text('Stocks List'),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/add_stock_page',
                    arguments: {'job': 'add'}).then((_) {
                  _stocksBloc.dispatch(AllStocksRequested());
                });
              })
        ],
      ),
      body: _stocksList.isNotEmpty && _remoteStocks.isNotEmpty
          ? SingleChildScrollView(
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
                      int index = _stocksList.indexOf(stock);
                      double _price = _remoteStocks[index].regularMarketPrice;
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
                              print(
                                  'SELECTED STOCK SYMBOL: ${stock.symbol} ==> ${stock.id}');
                              Navigator.pushNamed(context, '/add_stock_page',
                                  arguments: {
                                    'job': 'update',
                                    'stock': stock
                                  }).then((_) {
                                _stocksBloc.dispatch(AllStocksRequested());
                              });
                            },
                          ),
                          Container(
                            height: 30.0,
                            padding: EdgeInsets.only(left: 2.0, right: 2.0),
                            child: Center(
                              child: FittedBox(
                                child: Text('$_price'),
                              ),
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                color: Colors.white),
                          ),
                          Container(
                            height: 30.0,
                            padding: EdgeInsets.only(left: 2.0, right: 2.0),
                            child: Center(
                              child: FittedBox(
                                child: Text(
                                    '${_remoteStocks[_stocksList.indexOf(stock)].regularMarketChange}'),
                              ),
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                color: Colors.white),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 2.0, right: 2.0),
                            height: 30.0,
                            child: Center(
                              child: FittedBox(
                                child: Text(
                                    '${_remoteStocks[_stocksList.indexOf(stock)].regularMarketChangePercent}'),
                              ),
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                color: Colors.white),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 2.0, right: 2.0),
                            height: 30.0,
                            child: Center(
                              child: FittedBox(
                                  child: Text('${_calcBTDiff(_price, stock)}')),
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                color: Colors.white),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 2.0, right: 2.0),
                            height: 30.0,
                            child: Center(
                              child: FittedBox(
                                  child: Text('${_calcSTDiff(_price, stock)}')),
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
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.warning,
                    size: 50.0,
                    color: Colors.grey,
                  ),
                  Text(
                    'No Stocks added yet',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
    );
  }

  String _calcBTDiff(double price, Stock stock) {
    return ((price - double.parse(stock.buyTarget)) /
            ((double.parse(stock.buyTarget) * 100)))
        .toStringAsFixed(6);
  }

  String _calcSTDiff(double price, Stock stock) {
    return ((price - double.parse(stock.sellTarget)) /
            ((double.parse(stock.sellTarget) * 100)))
        .toStringAsFixed(6);
  }
}
