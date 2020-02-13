import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stock_monitor/API/api_manager.dart';
import 'package:stock_monitor/PODO/APIStock.dart';
import 'package:stock_monitor/PODO/StocksList.dart';
import 'package:stock_monitor/bloc/bloc.dart';
import 'package:stock_monitor/bloc/stocks/bloc.dart';
import 'package:stock_monitor/database/moor_database.dart';
import 'package:stock_monitor/utilities/buy_levels.dart';
import 'package:stock_monitor/utilities/sell_levels.dart';
import 'package:connectivity/connectivity.dart';

class StocksBloc extends BLoC<StocksEvent> {
  final stocksStateSubject = BehaviorSubject<StocksState>();
  final _stockDatabase = GetIt.instance<StocksDatabase>();
  final _buyLevels = GetIt.instance<BuyLevels>();
  final _sellLevels = GetIt.instance<SellLevels>();
  List<List<Stock>> _leveledStocks = List<List<Stock>>(12);
  List<Stock> _stocksList = List<Stock>();
  StocksList _remoteStocks;

  @override
  void dispatch(StocksEvent event) async {
    if (event is ConnectivityStatusRequested) {
      _checkConnectivity();
    }

    if (event is StockValidationRequested) {
      print('DISPATCHED StockValidationRequested EVENT');
      _checkStockDataIsValid(event.symbol, event.job);
    }
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
      await _getAllStocks();
      _collectStocksAndRemote();
    }

    if (event is BuyStocksLevelsRequested) {
      _getBuyStocksLevels(event.stocksList, event.remoteStocksList);
    }

    if (event is SellStocksLevelsRequested) {
      _getSellStocksLevels(event.stocksList, event.remoteStocksList);
    }
  }

  Future<void> _checkConnectivity() async {
    ConnectivityResult _result = await Connectivity().checkConnectivity();
    if (_result == ConnectivityResult.none) {
      stocksStateSubject.sink.add(ConnectivityStatusChecked(false));
    } else {
      stocksStateSubject.sink.add(ConnectivityStatusChecked(true));
    }
  }

  Future<void> _checkStockDataIsValid(String symbol, String job) async {
    APIManager.clearSymbols();
    APIManager.setStockSymbol(symbol);
    StocksList stocks = await APIManager.fetchStock();
    print('CHECKED STOCKS LIST');
    if (stocks.stocksList.isEmpty || stocks.stocksList[0].regularMarketPrice == null) {
      print('STOCK INVALID');
      stocksStateSubject.sink.add(StockValidationChecked(false, job));
    } else {
      print('STOCK OK!');
      stocksStateSubject.sink.add(StockValidationChecked(true, job));
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

  Future<void> _getBuyStocksLevels(
      List<Stock> stocksList, List<APIStock> remoteStocksList) async {
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

  Future<void> _getSellStocksLevels(
      List<Stock> stocksList, List<APIStock> remoteStocksList) async {
    _leveledStocks = List<List<Stock>>.generate(12, (_) => List<Stock>());
    stocksList.forEach((stock) {
      //Check according to target name
      if (stock.targetName == 'Price') {
        _sellLevels.calculateForStock(stock,
            remoteStocksList[stocksList.indexOf(stock)].regularMarketPrice);
      } else if (stock.targetName == 'Change') {
        _sellLevels.calculateForStock(stock,
            remoteStocksList[stocksList.indexOf(stock)].regularMarketChange);
      } else if (stock.targetName == 'Change%') {
        _sellLevels.calculateForStock(
            stock,
            remoteStocksList[stocksList.indexOf(stock)]
                .regularMarketChangePercent);
      }

      int _index = _sellLevels.getStockLevel();
      //arrange each stocks from the same level into a list of stocks
      if (_index != -1) {
        _leveledStocks[_index - 1].add(stock);
      }
    });

    stocksStateSubject.sink.add(SellStocksLevelsAreFetched(_leveledStocks));
  }

  //For debugging only
  Future<void> _resetDatabase() async {
    _stockDatabase.deleteAllFromTable();
  }

  void dispose() {
    stocksStateSubject.close();
  }
}
