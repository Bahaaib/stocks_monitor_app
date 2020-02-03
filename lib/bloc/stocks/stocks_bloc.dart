import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stock_monitor/bloc/bloc.dart';
import 'package:stock_monitor/bloc/stocks/bloc.dart';
import 'package:stock_monitor/database/moor_database.dart';

class StocksBloc extends BLoC<StocksEvent> {
  final stocksStateSubject = BehaviorSubject<StocksState>();
  final _stockDatabase = GetIt.instance<StocksDatabase>();

  @override
  void dispatch(StocksEvent event) async {
    if (event is StockInsertRequested) {
      _insertStockIntoDatabase(event.stock);
    }
  }

  Future<void> _insertStockIntoDatabase(Stock stock) async {
    await _stockDatabase
        .insertStock(stock)
        .catchError((error) => print(error.toString()))
        .whenComplete(() {
          print('SUCESSFULL');
      stocksStateSubject.sink.add(StockInserted(true));
    });
  }

  void dispose() {
    stocksStateSubject.close();
  }
}
