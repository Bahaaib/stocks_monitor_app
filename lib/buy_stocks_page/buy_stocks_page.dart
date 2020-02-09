import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stock_monitor/PODO/APIStock.dart';
import 'package:stock_monitor/bloc/stocks/bloc.dart';
import 'package:stock_monitor/bloc/stocks/stocks_bloc.dart';
import 'package:stock_monitor/bloc/stocks/stocks_event.dart';
import 'package:stock_monitor/database/moor_database.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class BuyStocksPage extends StatefulWidget {
  @override
  _BuyStocksPageState createState() => _BuyStocksPageState();
}

class _BuyStocksPageState extends State<BuyStocksPage> {
  final _stocksBloc = GetIt.instance<StocksBloc>();
  final _stocksList = List<Stock>();
  final _remoteStocks = List<APIStock>();
  final _leveledStocks = List<List<Stock>>();
  final _rowHeights = List<double>();

  @override
  void initState() {
    _stocksBloc.stocksStateSubject.listen((receivedState) {
      if (receivedState is StocksAndRemoteAreFetched) {
        _stocksList.clear();
        _remoteStocks.clear();
        _stocksList.addAll(receivedState.stocksList);
        _remoteStocks.addAll(receivedState.stocks.stocksList);
        _stocksBloc
            .dispatch(BuyStocksLevelsRequested(_stocksList, _remoteStocks));
      }
      if (receivedState is BuyStocksLevelsAreFetched) {
        setState(() {
          _leveledStocks.clear();
          _leveledStocks.addAll(receivedState.leveledStocks);
          _calculateHeights();
        });
      }
    });

    _stocksBloc.dispatch(StocksAndRemoteRequested());

    super.initState();
  }

  final List<int> _levelUnits = [
    1,
    2,
    4,
    7,
    12,
    20,
    33,
    54,
    88,
    143,
    232,
    376,
  ];

  Future<void> _refreshList() async {
    _stocksBloc.dispatch(StocksAndRemoteRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buy List'),
        actions: <Widget>[
          IconButton(
              icon: Image.asset(
                'assets/ic_sell.png',
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/sell_stock_page').then((_) {
                  _stocksBloc.dispatch(AllStocksRequested());
                });
              }),
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
              }),
        ],
      ),
      body: LiquidPullToRefresh(
        showChildOpacityTransition: false,
        onRefresh: () => _refreshList(),
        child: ListView(
          children: <Widget>[
            Table(
              children: [
                TableRow(
                  children: [
                    Container(
                      height: 30.0,
                      child: Center(
                        child: FittedBox(
                          child: Text('Level/Cat.'),
                        ),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.grey),
                    ),
                    Container(
                      height: 30.0,
                      child: Center(
                        child: Text('1'),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.grey),
                    ),
                    Container(
                      height: 30.0,
                      child: Center(
                        child: Text('2'),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.grey),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 2.0, right: 2.0),
                      height: 30.0,
                      child: Center(
                        child: FittedBox(child: Text('3')),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.grey),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 2.0, right: 2.0),
                      height: 30.0,
                      child: Center(
                        child: FittedBox(child: Text('4')),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.grey),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 2.0, right: 2.0),
                      height: 30.0,
                      child: Center(
                        child: FittedBox(child: Text('5')),
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
              children: _leveledStocks.map((stocks) {
                int _index = _leveledStocks.indexOf(stocks);
                return TableRow(children: _buildLevelRow(_index));
              }).toList(),
            )
          ],
        ),
      ),
    );
  }

  //Calculate the height of each row relative to its children number
  void _calculateHeights() {
    _rowHeights.clear();
    _leveledStocks.forEach((stocks) {
      List<int> _categories = List<int>.generate(5, (i) => 0);
      double _height = 0.0;
      if (stocks.isEmpty) {
        _rowHeights.add(50.0);
      } else {
        stocks.forEach((stock) {
          for (int i = 1; i < 6; i++) {
            if (stock.categoryId == i) {
              _categories[i-1]++;
            }
          }
        });
        int _max = _getMaxLength(_categories);
        _rowHeights.add(50.0 * _max);
      }
    });
  }

  int _getMaxLength(List<int> list){
    int length = 0;
    list.forEach((index) {
      if(index > length){
        length = index;
      }
    });
    return length;
  }

  //Render each row
  List<Widget> _buildLevelRow(int level) {
    List<Widget> rowList = List<Widget>();
    //Add the Level number cell as the first of each row
    rowList.add(Container(
      padding: EdgeInsets.only(left: 2.0, right: 2.0),
      height: _rowHeights[11 - level],
      child: Center(
        child: FittedBox(child: Text('Level ${11 - level + 1}')),
      ),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black), color: Colors.grey),
    ));

    //Get the stocks list for a certain level (Reversely for buy stocks)
    final List<Stock> stocksList = _leveledStocks[11 - level];
    List<Stock> categoryStocksList = List<Stock>();

    //iterate over the number of stocks in each category
    for (int i = 1; i < 6; i++) {
      categoryStocksList = stocksList.where((stock) {
        return stock.categoryId == i;
      }).toList();

      //If this category has no stocks, set a white empty cell
      if (categoryStocksList.isEmpty) {
        rowList.add(Container(
          padding: EdgeInsets.only(left: 2.0, right: 2.0),
          height: _rowHeights[11 - level],
          child: Center(
            child: FittedBox(child: Text(' ')),
          ),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black), color: Colors.white),
        ));
        //If this category has some stocks, add a column of cells
      } else {
        rowList.add(Column(
          children: categoryStocksList.map((stock) {
            int _index = _stocksList.indexOf(stock);

            return Container(
              padding: EdgeInsets.only(left: 2.0, right: 2.0),
              height: 50.0,
              child: Center(
                child: FittedBox(
                  child: Column(
                    children: <Widget>[
                      Text(
                          '${stock.symbol}, ${_remoteStocks[_index].regularMarketPrice}'),
                      Text(
                          '${(_levelUnits[11 - level] * 1000 ~/ _remoteStocks[_index].regularMarketPrice)}'),
                      Text('${stock.sharesBought}'),
                    ],
                  ),
                ),
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                color: _getCellColor(stock.color),
              ),
            );
          }).toList(),
        ));
      }
    }
    return rowList;
  }

  Color _getCellColor(String color) {
    switch (color) {
      case 'Red':
        return Colors.red;
        break;
      case 'Orange':
        return Colors.orange;
        break;
      case 'Yellow':
        return Colors.yellow;
        break;
      case 'Green':
        return Colors.green;
        break;
      case 'Blue':
        return Colors.blue;
        break;
      default:
        return Colors.white;
        break;
    }
  }
}
