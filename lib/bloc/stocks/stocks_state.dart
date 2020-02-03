abstract class StocksState {}

class StockInserted extends StocksState {
  bool isSuccessful;

  StockInserted(this.isSuccessful);
}
