import 'package:stock_monitor/PODO/APIStock.dart';
import 'package:stock_monitor/database/moor_database.dart';

abstract class StocksEvent {}

class StockInsertRequested extends StocksEvent {
  final Stock stock;

  StockInsertRequested(this.stock);
}

class AllStocksRequested extends StocksEvent {}

class StockUpdateRequested extends StocksEvent {
  final Stock stock;

  StockUpdateRequested(this.stock);
}

class StockDeleteRequested extends StocksEvent {
  final Stock stock;

  StockDeleteRequested(this.stock);
}

class StocksRemoteDataRequested extends StocksEvent {
  final List<String> symbolsList;

  StocksRemoteDataRequested(this.symbolsList);
}

class StocksAndRemoteRequested extends StocksEvent {}

class BuyStocksLevelsRequested extends StocksEvent {
  final List<Stock> stocksList;
  final List<APIStock> remoteStocksList;

  BuyStocksLevelsRequested(this.stocksList, this.remoteStocksList);
}
