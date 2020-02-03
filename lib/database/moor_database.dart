import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'moor_database.g.dart';

class Stocks extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get symbol => text()();

  IntColumn get categoryId => integer()();

  TextColumn get color => text()();

  TextColumn get targetName => text()();

  TextColumn get buyTarget => text()();

  TextColumn get buyInterval => text()();

  TextColumn get sellTarget => text()();

  TextColumn get sellInterval => text()();

  TextColumn get sharesBought => text()();

  TextColumn get sharesSold => text()();

  TextColumn get comments => text().nullable()();
}

@UseMoor(tables: [Stocks])
class StocksDatabase extends _$StocksDatabase {
  StocksDatabase()
      : super((FlutterQueryExecutor.inDatabaseFolder(
          path: 'db.sqlite',
          logStatements: true,
        )));

  @override
  int get schemaVersion => 1;


  Future<List<Stock>> getAllStocks() => select(stocks).get();

  Stream<List<Stock>> watchAllStocks() => select(stocks).watch();

  Future insertStock(Stock stock) => into(stocks).insert(stock);

  Future updateStock(Stock stock) => update(stocks).replace(stock);

  Future deleteStock(Stock stock) => delete(stocks).delete(stock);
}

