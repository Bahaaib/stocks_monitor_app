import 'package:json_annotation/json_annotation.dart';
import 'package:stock_monitor/PODO/APIStock.dart';

part 'StocksList.g.dart';

@JsonSerializable()
class StocksList {
  List<APIStock> stocksList;


  StocksList(this.stocksList);

  factory StocksList.fromJson(Map<String, dynamic> json) =>
      _$StocksListFromJson(json);

  Map<String, dynamic> toJson() => _$StocksListToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is StocksList &&
              runtimeType == other.runtimeType &&
              (stocksList == other.stocksList);

  @override
  int get hashCode => stocksList.hashCode;
}
