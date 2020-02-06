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
