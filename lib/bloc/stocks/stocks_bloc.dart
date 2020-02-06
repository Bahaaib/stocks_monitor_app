import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stock_monitor/API/api_manager.dart';
import 'package:stock_monitor/PODO/APIStock.dart';
import 'package:stock_monitor/PODO/StocksList.dart';
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

    if (event is AllStocksRequested) {
      _getAllStocks();
    }

    if (event is StockUpdateRequested) {
      _updateStock(event.stock);
    }

    if (event is StockDeleteRequested) {
      _deleteStock(event.stock);
    }

    if(event is StocksRemoteDataRequested){
      _fetchStockDataFromApi(event.symbolsList);
    }
  }

  Future<void> _insertStockIntoDatabase(Stock stock) async {
    _stockDatabase
        .insertStock(stock)
        .then((_) => stocksStateSubject.sink.add(StockInserted(true)))
        .catchError((_) => stocksStateSubject.sink.add(StockInserted(false)));
  }

  Future<void> _updateStock(Stock stock) async {
    print('BLoC UPDATE');
    _stockDatabase
        .updateStock(stock)
        .then((_) => stocksStateSubject.sink.add(StockIsUpdated(true)))
        .catchError((_) => stocksStateSubject.sink.add(StockIsUpdated(false)));
  }

  Future<void> _deleteStock(Stock stock) async {
    _stockDatabase
        .deleteStock(stock)
        .then((_) => stocksStateSubject.sink.add(StockIsDeleted(true)))
        .catchError((_) => stocksStateSubject.sink.add(StockIsDeleted(false)));
  }

  Future<void> _getAllStocks() async {
    final List<Stock> stocks =
        await _stockDatabase.getAllStocksInAlphabeticalOrder();
    stocksStateSubject.sink.add(StocksAreFetched(stocks));
  }

  Future<void> _fetchStockDataFromApi(List<String> symbols) async {
    APIManager.parseStocksSymbols(symbols);
    StocksList stocks = await APIManager.fetchStock();
    stocksStateSubject.sink.add(StocksDataIsFetched(stocks));
  }

  //For debugging only
  Future<void> _resetDatabase() async {
   _stockDatabase.deleteAllFromTable();
  }


  void dispose() {
    stocksStateSubject.close();
  }
}
