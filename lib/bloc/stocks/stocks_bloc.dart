import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stock_monitor/API/api_manager.dart';
import 'package:stock_monitor/PODO/APIStock.dart';
import 'package:stock_monitor/PODO/StocksList.dart';
import 'package:stock_monitor/bloc/bloc.dart';
import 'package:stock_monitor/bloc/stocks/bloc.dart';
import 'package:stock_monitor/database/moor_database.dart';
import 'package:stock_monitor/utilities/buy_levels.dart';

class StocksBloc extends BLoC<StocksEvent> {
  final stocksStateSubject = BehaviorSubject<StocksState>();
  final _stockDatabase = GetIt.instance<StocksDatabase>();
  final _buyLevels = GetIt.instance<BuyLevels>();
  List<List<Stock>> _leveledStocks = List<List<Stock>>(12);
  List<Stock> _stocksList = List<Stock>();
  StocksList _remoteStocks;

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

    if (event is StocksRemoteDataRequested) {
      _fetchStockDataFromApi(event.symbolsList);
    }

    if (event is StocksAndRemoteRequested) {
      _collectStocksAndRemote();
    }

    if (event is BuyStocksLevelsRequested) {
      _getBuyStocksLevels(event.stocksList, event.remoteStocksList);
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
    _stocksList = await _stockDatabase.getAllStocksInAlphabeticalOrder();
    stocksStateSubject.sink.add(StocksAreFetched(_stocksList));
  }

  Future<void> _fetchStockDataFromApi(List<String> symbols) async {
    APIManager.clearSymbols();
    APIManager.parseStocksSymbols(symbols);
    _remoteStocks = await APIManager.fetchStock();
    stocksStateSubject.sink.add(StocksDataIsFetched(_remoteStocks));
  }

  void _collectStocksAndRemote() {
    stocksStateSubject.sink
        .add(StocksAndRemoteAreFetched(_stocksList, _remoteStocks));
  }

  void _getBuyStocksLevels(
      List<Stock> stocksList, List<APIStock> remoteStocksList) {
    _leveledStocks = List<List<Stock>>.generate(12, (_) => List<Stock>());
    stocksList.forEach((stock) {
      //Check according to target name
      if (stock.targetName == 'Price') {
        _buyLevels.calculateForStock(stock,
            remoteStocksList[stocksList.indexOf(stock)].regularMarketPrice);
      } else if (stock.targetName == 'Change') {
        _buyLevels.calculateForStock(stock,
            remoteStocksList[stocksList.indexOf(stock)].regularMarketChange);
      } else if (stock.targetName == 'Change%') {
        _buyLevels.calculateForStock(
            stock,
            remoteStocksList[stocksList.indexOf(stock)]
                .regularMarketChangePercent);
      }

      int _index = _buyLevels.getStockLevel();
      //arrange each stocks from the same level into a list of stocks
      if (_index != -1) {
        _leveledStocks[_index - 1].add(stock);
      }
    });

    stocksStateSubject.sink.add(BuyStocksLevelsAreFetched(_leveledStocks));
  }

  //For debugging only
  Future<void> _resetDatabase() async {
    _stockDatabase.deleteAllFromTable();
  }

  void dispose() {
    stocksStateSubject.close();
  }
}
