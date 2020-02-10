import 'package:stock_monitor/PODO/StocksList.dart';
import 'package:stock_monitor/database/moor_database.dart';

abstract class StocksState {}

class ConnectivityStatusChecked extends StocksState {
  bool isConnected;

  ConnectivityStatusChecked(this.isConnected);
}

class StockValidationChecked extends StocksState {
  final bool isExist;
  final String job;

  StockValidationChecked(this.isExist, this.job);
}

class StockInserted extends StocksState {
  bool isSuccessful;

  StockInserted(this.isSuccessful);
}

class StocksAreFetched extends StocksState {
  final List<Stock> stocksList;

  StocksAreFetched(this.stocksList);
}

class StockIsUpdated extends StocksState {
  bool isSuccessful;

  StockIsUpdated(this.isSuccessful);
}

class StockIsDeleted extends StocksState {
  bool isSuccessful;

  StockIsDeleted(this.isSuccessful);
}

class StocksDataIsFetched extends StocksState {
  final StocksList stocks;

  StocksDataIsFetched(this.stocks);
}

class StocksAndRemoteAreFetched extends StocksState {
  final List<Stock> stocksList;
  final StocksList stocks;

  StocksAndRemoteAreFetched(this.stocksList, this.stocks);
}

class BuyStocksLevelsAreFetched extends StocksState {
  final List<List<Stock>> leveledStocks;

  BuyStocksLevelsAreFetched(this.leveledStocks);
}

class SellStocksLevelsAreFetched extends StocksState {
  final List<List<Stock>> leveledStocks;

  SellStocksLevelsAreFetched(this.leveledStocks);
}
