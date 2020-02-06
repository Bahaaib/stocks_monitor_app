import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'moor_database.g.dart';

class Stocks extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get symbol => text().withLength(min: 1)();

  IntColumn get categoryId => integer()();

  TextColumn get color => text().withLength(min: 1)();

  TextColumn get targetName => text().withLength(min: 1)();

  TextColumn get buyTarget => text().withLength(min: 1)();

  TextColumn get buyInterval => text().withLength(min: 1)();

  TextColumn get sellTarget => text().withLength(min: 1)();

  TextColumn get sellInterval => text().withLength(min: 1)();

  TextColumn get sharesBought => text().withLength(min: 1)();

  TextColumn get sharesSold => text().withLength(min: 1)();

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

  Future deleteAllFromTable() => delete(stocks).go();

  Future<List<Stock>> getAllStocksInAlphabeticalOrder() {
    return (select(stocks)
          ..orderBy(
            ([
              (t) => OrderingTerm(expression: t.symbol),
            ]),
          ))
        .get();
  }
}
