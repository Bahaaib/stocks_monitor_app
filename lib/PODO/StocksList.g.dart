// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'StocksList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StocksList _$StocksListFromJson(Map<String, dynamic> json) {
  return StocksList(
    (json['quoteResponse']['result'] as List)
        ?.map((e) =>
            e == null ? null : APIStock.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$StocksListToJson(StocksList instance) =>
    <String, dynamic>{
      'stocksList': instance.stocksList,
    };
