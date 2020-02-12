// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps
class Stock extends DataClass implements Insertable<Stock> {
  final int id;
  final String symbol;
  final int categoryId;
  final String color;
  final String targetName;
  final String buyTarget;
  final String buyInterval;
  final String sellTarget;
  final String sellInterval;
  final String sharesBought;
  final String sharesSold;
  final String multiplier;
  final String comments;
  Stock(
      {@required this.id,
      @required this.symbol,
      @required this.categoryId,
      @required this.color,
      @required this.targetName,
      @required this.buyTarget,
      @required this.buyInterval,
      @required this.sellTarget,
      @required this.sellInterval,
      @required this.sharesBought,
      @required this.sharesSold,
      this.multiplier,
      this.comments});
  factory Stock.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Stock(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      symbol:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}symbol']),
      categoryId: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}category_id']),
      color:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}color']),
      targetName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}target_name']),
      buyTarget: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}buy_target']),
      buyInterval: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}buy_interval']),
      sellTarget: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}sell_target']),
      sellInterval: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}sell_interval']),
      sharesBought: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}shares_bought']),
      sharesSold: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}shares_sold']),
      multiplier: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}multiplier']),
      comments: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}comments']),
    );
  }
  factory Stock.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Stock(
      id: serializer.fromJson<int>(json['id']),
      symbol: serializer.fromJson<String>(json['symbol']),
      categoryId: serializer.fromJson<int>(json['categoryId']),
      color: serializer.fromJson<String>(json['color']),
      targetName: serializer.fromJson<String>(json['targetName']),
      buyTarget: serializer.fromJson<String>(json['buyTarget']),
      buyInterval: serializer.fromJson<String>(json['buyInterval']),
      sellTarget: serializer.fromJson<String>(json['sellTarget']),
      sellInterval: serializer.fromJson<String>(json['sellInterval']),
      sharesBought: serializer.fromJson<String>(json['sharesBought']),
      sharesSold: serializer.fromJson<String>(json['sharesSold']),
      multiplier: serializer.fromJson<String>(json['multiplier']),
      comments: serializer.fromJson<String>(json['comments']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'symbol': serializer.toJson<String>(symbol),
      'categoryId': serializer.toJson<int>(categoryId),
      'color': serializer.toJson<String>(color),
      'targetName': serializer.toJson<String>(targetName),
      'buyTarget': serializer.toJson<String>(buyTarget),
      'buyInterval': serializer.toJson<String>(buyInterval),
      'sellTarget': serializer.toJson<String>(sellTarget),
      'sellInterval': serializer.toJson<String>(sellInterval),
      'sharesBought': serializer.toJson<String>(sharesBought),
      'sharesSold': serializer.toJson<String>(sharesSold),
      'multiplier': serializer.toJson<String>(multiplier),
      'comments': serializer.toJson<String>(comments),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<Stock>>(bool nullToAbsent) {
    return StocksCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      symbol:
          symbol == null && nullToAbsent ? const Value.absent() : Value(symbol),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      color:
          color == null && nullToAbsent ? const Value.absent() : Value(color),
      targetName: targetName == null && nullToAbsent
          ? const Value.absent()
          : Value(targetName),
      buyTarget: buyTarget == null && nullToAbsent
          ? const Value.absent()
          : Value(buyTarget),
      buyInterval: buyInterval == null && nullToAbsent
          ? const Value.absent()
          : Value(buyInterval),
      sellTarget: sellTarget == null && nullToAbsent
          ? const Value.absent()
          : Value(sellTarget),
      sellInterval: sellInterval == null && nullToAbsent
          ? const Value.absent()
          : Value(sellInterval),
      sharesBought: sharesBought == null && nullToAbsent
          ? const Value.absent()
          : Value(sharesBought),
      sharesSold: sharesSold == null && nullToAbsent
          ? const Value.absent()
          : Value(sharesSold),
      multiplier: multiplier == null && nullToAbsent
          ? const Value.absent()
          : Value(multiplier),
      comments: comments == null && nullToAbsent
          ? const Value.absent()
          : Value(comments),
    ) as T;
  }

  Stock copyWith(
          {int id,
          String symbol,
          int categoryId,
          String color,
          String targetName,
          String buyTarget,
          String buyInterval,
          String sellTarget,
          String sellInterval,
          String sharesBought,
          String sharesSold,
          String multiplier,
          String comments}) =>
      Stock(
        id: id ?? this.id,
        symbol: symbol ?? this.symbol,
        categoryId: categoryId ?? this.categoryId,
        color: color ?? this.color,
        targetName: targetName ?? this.targetName,
        buyTarget: buyTarget ?? this.buyTarget,
        buyInterval: buyInterval ?? this.buyInterval,
        sellTarget: sellTarget ?? this.sellTarget,
        sellInterval: sellInterval ?? this.sellInterval,
        sharesBought: sharesBought ?? this.sharesBought,
        sharesSold: sharesSold ?? this.sharesSold,
        multiplier: multiplier ?? this.multiplier,
        comments: comments ?? this.comments,
      );
  @override
  String toString() {
    return (StringBuffer('Stock(')
          ..write('id: $id, ')
          ..write('symbol: $symbol, ')
          ..write('categoryId: $categoryId, ')
          ..write('color: $color, ')
          ..write('targetName: $targetName, ')
          ..write('buyTarget: $buyTarget, ')
          ..write('buyInterval: $buyInterval, ')
          ..write('sellTarget: $sellTarget, ')
          ..write('sellInterval: $sellInterval, ')
          ..write('sharesBought: $sharesBought, ')
          ..write('sharesSold: $sharesSold, ')
          ..write('multiplier: $multiplier, ')
          ..write('comments: $comments')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          symbol.hashCode,
          $mrjc(
              categoryId.hashCode,
              $mrjc(
                  color.hashCode,
                  $mrjc(
                      targetName.hashCode,
                      $mrjc(
                          buyTarget.hashCode,
                          $mrjc(
                              buyInterval.hashCode,
                              $mrjc(
                                  sellTarget.hashCode,
                                  $mrjc(
                                      sellInterval.hashCode,
                                      $mrjc(
                                          sharesBought.hashCode,
                                          $mrjc(
                                              sharesSold.hashCode,
                                              $mrjc(
                                                  multiplier.hashCode,
                                                  comments
                                                      .hashCode)))))))))))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Stock &&
          other.id == id &&
          other.symbol == symbol &&
          other.categoryId == categoryId &&
          other.color == color &&
          other.targetName == targetName &&
          other.buyTarget == buyTarget &&
          other.buyInterval == buyInterval &&
          other.sellTarget == sellTarget &&
          other.sellInterval == sellInterval &&
          other.sharesBought == sharesBought &&
          other.sharesSold == sharesSold &&
          other.multiplier == multiplier &&
          other.comments == comments);
}

class StocksCompanion extends UpdateCompanion<Stock> {
  final Value<int> id;
  final Value<String> symbol;
  final Value<int> categoryId;
  final Value<String> color;
  final Value<String> targetName;
  final Value<String> buyTarget;
  final Value<String> buyInterval;
  final Value<String> sellTarget;
  final Value<String> sellInterval;
  final Value<String> sharesBought;
  final Value<String> sharesSold;
  final Value<String> multiplier;
  final Value<String> comments;
  const StocksCompanion({
    this.id = const Value.absent(),
    this.symbol = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.color = const Value.absent(),
    this.targetName = const Value.absent(),
    this.buyTarget = const Value.absent(),
    this.buyInterval = const Value.absent(),
    this.sellTarget = const Value.absent(),
    this.sellInterval = const Value.absent(),
    this.sharesBought = const Value.absent(),
    this.sharesSold = const Value.absent(),
    this.multiplier = const Value.absent(),
    this.comments = const Value.absent(),
  });
  StocksCompanion copyWith(
      {Value<int> id,
      Value<String> symbol,
      Value<int> categoryId,
      Value<String> color,
      Value<String> targetName,
      Value<String> buyTarget,
      Value<String> buyInterval,
      Value<String> sellTarget,
      Value<String> sellInterval,
      Value<String> sharesBought,
      Value<String> sharesSold,
      Value<String> multiplier,
      Value<String> comments}) {
    return StocksCompanion(
      id: id ?? this.id,
      symbol: symbol ?? this.symbol,
      categoryId: categoryId ?? this.categoryId,
      color: color ?? this.color,
      targetName: targetName ?? this.targetName,
      buyTarget: buyTarget ?? this.buyTarget,
      buyInterval: buyInterval ?? this.buyInterval,
      sellTarget: sellTarget ?? this.sellTarget,
      sellInterval: sellInterval ?? this.sellInterval,
      sharesBought: sharesBought ?? this.sharesBought,
      sharesSold: sharesSold ?? this.sharesSold,
      multiplier: multiplier ?? this.multiplier,
      comments: comments ?? this.comments,
    );
  }
}

class $StocksTable extends Stocks with TableInfo<$StocksTable, Stock> {
  final GeneratedDatabase _db;
  final String _alias;
  $StocksTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _symbolMeta = const VerificationMeta('symbol');
  GeneratedTextColumn _symbol;
  @override
  GeneratedTextColumn get symbol => _symbol ??= _constructSymbol();
  GeneratedTextColumn _constructSymbol() {
    return GeneratedTextColumn('symbol', $tableName, false, minTextLength: 1);
  }

  final VerificationMeta _categoryIdMeta = const VerificationMeta('categoryId');
  GeneratedIntColumn _categoryId;
  @override
  GeneratedIntColumn get categoryId => _categoryId ??= _constructCategoryId();
  GeneratedIntColumn _constructCategoryId() {
    return GeneratedIntColumn(
      'category_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _colorMeta = const VerificationMeta('color');
  GeneratedTextColumn _color;
  @override
  GeneratedTextColumn get color => _color ??= _constructColor();
  GeneratedTextColumn _constructColor() {
    return GeneratedTextColumn('color', $tableName, false, minTextLength: 1);
  }

  final VerificationMeta _targetNameMeta = const VerificationMeta('targetName');
  GeneratedTextColumn _targetName;
  @override
  GeneratedTextColumn get targetName => _targetName ??= _constructTargetName();
  GeneratedTextColumn _constructTargetName() {
    return GeneratedTextColumn('target_name', $tableName, false,
        minTextLength: 1);
  }

  final VerificationMeta _buyTargetMeta = const VerificationMeta('buyTarget');
  GeneratedTextColumn _buyTarget;
  @override
  GeneratedTextColumn get buyTarget => _buyTarget ??= _constructBuyTarget();
  GeneratedTextColumn _constructBuyTarget() {
    return GeneratedTextColumn('buy_target', $tableName, false,
        minTextLength: 1);
  }

  final VerificationMeta _buyIntervalMeta =
      const VerificationMeta('buyInterval');
  GeneratedTextColumn _buyInterval;
  @override
  GeneratedTextColumn get buyInterval =>
      _buyInterval ??= _constructBuyInterval();
  GeneratedTextColumn _constructBuyInterval() {
    return GeneratedTextColumn('buy_interval', $tableName, false,
        minTextLength: 1);
  }

  final VerificationMeta _sellTargetMeta = const VerificationMeta('sellTarget');
  GeneratedTextColumn _sellTarget;
  @override
  GeneratedTextColumn get sellTarget => _sellTarget ??= _constructSellTarget();
  GeneratedTextColumn _constructSellTarget() {
    return GeneratedTextColumn('sell_target', $tableName, false,
        minTextLength: 1);
  }

  final VerificationMeta _sellIntervalMeta =
      const VerificationMeta('sellInterval');
  GeneratedTextColumn _sellInterval;
  @override
  GeneratedTextColumn get sellInterval =>
      _sellInterval ??= _constructSellInterval();
  GeneratedTextColumn _constructSellInterval() {
    return GeneratedTextColumn('sell_interval', $tableName, false,
        minTextLength: 1);
  }

  final VerificationMeta _sharesBoughtMeta =
      const VerificationMeta('sharesBought');
  GeneratedTextColumn _sharesBought;
  @override
  GeneratedTextColumn get sharesBought =>
      _sharesBought ??= _constructSharesBought();
  GeneratedTextColumn _constructSharesBought() {
    return GeneratedTextColumn('shares_bought', $tableName, false,
        minTextLength: 1);
  }

  final VerificationMeta _sharesSoldMeta = const VerificationMeta('sharesSold');
  GeneratedTextColumn _sharesSold;
  @override
  GeneratedTextColumn get sharesSold => _sharesSold ??= _constructSharesSold();
  GeneratedTextColumn _constructSharesSold() {
    return GeneratedTextColumn('shares_sold', $tableName, false,
        minTextLength: 1);
  }

  final VerificationMeta _multiplierMeta = const VerificationMeta('multiplier');
  GeneratedTextColumn _multiplier;
  @override
  GeneratedTextColumn get multiplier => _multiplier ??= _constructMultiplier();
  GeneratedTextColumn _constructMultiplier() {
    return GeneratedTextColumn(
      'multiplier',
      $tableName,
      true,
    );
  }

  final VerificationMeta _commentsMeta = const VerificationMeta('comments');
  GeneratedTextColumn _comments;
  @override
  GeneratedTextColumn get comments => _comments ??= _constructComments();
  GeneratedTextColumn _constructComments() {
    return GeneratedTextColumn(
      'comments',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        symbol,
        categoryId,
        color,
        targetName,
        buyTarget,
        buyInterval,
        sellTarget,
        sellInterval,
        sharesBought,
        sharesSold,
        multiplier,
        comments
      ];
  @override
  $StocksTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'stocks';
  @override
  final String actualTableName = 'stocks';
  @override
  VerificationContext validateIntegrity(StocksCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.symbol.present) {
      context.handle(
          _symbolMeta, symbol.isAcceptableValue(d.symbol.value, _symbolMeta));
    } else if (symbol.isRequired && isInserting) {
      context.missing(_symbolMeta);
    }
    if (d.categoryId.present) {
      context.handle(_categoryIdMeta,
          categoryId.isAcceptableValue(d.categoryId.value, _categoryIdMeta));
    } else if (categoryId.isRequired && isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (d.color.present) {
      context.handle(
          _colorMeta, color.isAcceptableValue(d.color.value, _colorMeta));
    } else if (color.isRequired && isInserting) {
      context.missing(_colorMeta);
    }
    if (d.targetName.present) {
      context.handle(_targetNameMeta,
          targetName.isAcceptableValue(d.targetName.value, _targetNameMeta));
    } else if (targetName.isRequired && isInserting) {
      context.missing(_targetNameMeta);
    }
    if (d.buyTarget.present) {
      context.handle(_buyTargetMeta,
          buyTarget.isAcceptableValue(d.buyTarget.value, _buyTargetMeta));
    } else if (buyTarget.isRequired && isInserting) {
      context.missing(_buyTargetMeta);
    }
    if (d.buyInterval.present) {
      context.handle(_buyIntervalMeta,
          buyInterval.isAcceptableValue(d.buyInterval.value, _buyIntervalMeta));
    } else if (buyInterval.isRequired && isInserting) {
      context.missing(_buyIntervalMeta);
    }
    if (d.sellTarget.present) {
      context.handle(_sellTargetMeta,
          sellTarget.isAcceptableValue(d.sellTarget.value, _sellTargetMeta));
    } else if (sellTarget.isRequired && isInserting) {
      context.missing(_sellTargetMeta);
    }
    if (d.sellInterval.present) {
      context.handle(
          _sellIntervalMeta,
          sellInterval.isAcceptableValue(
              d.sellInterval.value, _sellIntervalMeta));
    } else if (sellInterval.isRequired && isInserting) {
      context.missing(_sellIntervalMeta);
    }
    if (d.sharesBought.present) {
      context.handle(
          _sharesBoughtMeta,
          sharesBought.isAcceptableValue(
              d.sharesBought.value, _sharesBoughtMeta));
    } else if (sharesBought.isRequired && isInserting) {
      context.missing(_sharesBoughtMeta);
    }
    if (d.sharesSold.present) {
      context.handle(_sharesSoldMeta,
          sharesSold.isAcceptableValue(d.sharesSold.value, _sharesSoldMeta));
    } else if (sharesSold.isRequired && isInserting) {
      context.missing(_sharesSoldMeta);
    }
    if (d.multiplier.present) {
      context.handle(_multiplierMeta,
          multiplier.isAcceptableValue(d.multiplier.value, _multiplierMeta));
    } else if (multiplier.isRequired && isInserting) {
      context.missing(_multiplierMeta);
    }
    if (d.comments.present) {
      context.handle(_commentsMeta,
          comments.isAcceptableValue(d.comments.value, _commentsMeta));
    } else if (comments.isRequired && isInserting) {
      context.missing(_commentsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Stock map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Stock.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(StocksCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.symbol.present) {
      map['symbol'] = Variable<String, StringType>(d.symbol.value);
    }
    if (d.categoryId.present) {
      map['category_id'] = Variable<int, IntType>(d.categoryId.value);
    }
    if (d.color.present) {
      map['color'] = Variable<String, StringType>(d.color.value);
    }
    if (d.targetName.present) {
      map['target_name'] = Variable<String, StringType>(d.targetName.value);
    }
    if (d.buyTarget.present) {
      map['buy_target'] = Variable<String, StringType>(d.buyTarget.value);
    }
    if (d.buyInterval.present) {
      map['buy_interval'] = Variable<String, StringType>(d.buyInterval.value);
    }
    if (d.sellTarget.present) {
      map['sell_target'] = Variable<String, StringType>(d.sellTarget.value);
    }
    if (d.sellInterval.present) {
      map['sell_interval'] = Variable<String, StringType>(d.sellInterval.value);
    }
    if (d.sharesBought.present) {
      map['shares_bought'] = Variable<String, StringType>(d.sharesBought.value);
    }
    if (d.sharesSold.present) {
      map['shares_sold'] = Variable<String, StringType>(d.sharesSold.value);
    }
    if (d.multiplier.present) {
      map['multiplier'] = Variable<String, StringType>(d.multiplier.value);
    }
    if (d.comments.present) {
      map['comments'] = Variable<String, StringType>(d.comments.value);
    }
    return map;
  }

  @override
  $StocksTable createAlias(String alias) {
    return $StocksTable(_db, alias);
  }
}

abstract class _$StocksDatabase extends GeneratedDatabase {
  _$StocksDatabase(QueryExecutor e)
      : super(const SqlTypeSystem.withDefaults(), e);
  $StocksTable _stocks;
  $StocksTable get stocks => _stocks ??= $StocksTable(this);
  @override
  List<TableInfo> get allTables => [stocks];
}
