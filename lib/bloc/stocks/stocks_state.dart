import 'package:stock_monitor/PODO/StocksList.dart';
import 'package:stock_monitor/database/moor_database.dart';

abstract class StocksState {}

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

class StocksDataIsFetched extends StocksState{
  final StocksList stocks;

  StocksDataIsFetched(this.stocks);


}
