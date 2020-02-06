import 'package:json_annotation/json_annotation.dart';

part 'APIStock.g.dart';

@JsonSerializable()
class APIStock {
  String longName;
  double priceToBook;
  double regularMarketChange;
  double regularMarketChangePercent;

  APIStock(this.longName, this.priceToBook);

  factory APIStock.fromJson(Map<String, dynamic> json) =>
      _$APIStockFromJson(json);

  Map<String, dynamic> toJson() => _$APIStockToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is APIStock &&
          runtimeType == other.runtimeType &&
          (longName == other.longName) &&
          (priceToBook == other.priceToBook);

  @override
  int get hashCode => longName.hashCode;
}
