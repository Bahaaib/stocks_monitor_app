// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'APIStock.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

APIStock _$APIStockFromJson(Map<String, dynamic> json) {
  return APIStock(
    json['longName'] as String,
    (json['priceToBook'] as num)?.toDouble(),
  )
    ..regularMarketChange = (json['regularMarketChange'] as num)?.toDouble()
    ..regularMarketChangePercent =
        (json['regularMarketChangePercent'] as num)?.toDouble();
}

Map<String, dynamic> _$APIStockToJson(APIStock instance) => <String, dynamic>{
      'longName': instance.longName,
      'priceToBook': instance.priceToBook,
      'regularMarketChange': instance.regularMarketChange,
      'regularMarketChangePercent': instance.regularMarketChangePercent,
    };
