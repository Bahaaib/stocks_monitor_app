import 'package:stock_monitor/database/moor_database.dart';

abstract class StocksState {}

class StockInserted extends StocksState {
  bool isSuccessful;

  StockInserted(this.isSuccessful);
}

class StocksAreFetched extends StocksState{
  final List<Stock> stocksList;

  StocksAreFetched(this.stocksList);


}
