import 'package:stock_monitor/database/moor_database.dart';

abstract class StocksEvent {}

class StockInsertRequested extends StocksEvent {
  final Stock stock;

  StockInsertRequested(this.stock);
}
