import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stock_monitor/bloc/bloc.dart';
import 'package:stock_monitor/bloc/stocks/bloc.dart';
import 'package:stock_monitor/database/moor_database.dart';

class StocksBloc extends BLoC<StocksEvent> {
  final stocksStateSubject = BehaviorSubject<StocksState>();
  final _stockDatabase = GetIt.instance<StocksDatabase>();

  @override
  void dispatch(StocksEvent event) {
    if (event is StockInsertRequested) {
      _insertStockIntoDatabase(event.stock);
    }
  }

  Future<void> _insertStockIntoDatabase(Stock stock) async {
    print('inside BLOC');
//    try {
//      print('inside TRY');
//
//      await _stockDatabase.insertStock(stock);
//      print('TRUE');
//      stocksStateSubject.sink.add(StockInserted(true));
//    } on Exception catch (_) {
//      print('inside CATCH');
//
//      stocksStateSubject.sink.add(StockInserted(false));
//    }

    _stockDatabase
        .insertStock(stock)
        .then((_) => stocksStateSubject.sink.add(StockInserted(true)))
        .catchError((_) => stocksStateSubject.sink.add(StockInserted(false)));
  }

  //For debugging purposes
  Future<void> _getAllStocks() async {
    final List<Stock> stocks = await _stockDatabase.getAllStocks();
    for (Stock stock in stocks) {
      print('STOCK SYMBOL: ${stock.symbol} ==> ID: ${stock.id}');
    }
  }

  void dispose() {
    stocksStateSubject.close();
  }
}
