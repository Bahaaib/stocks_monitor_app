import 'package:stock_monitor/database/moor_database.dart';

class SellLevels {
  double _sellLevel1;
  double _sellLevel2;
  double _sellLevel3;
  double _sellLevel4;
  double _sellLevel5;
  double _sellLevel6;
  double _sellLevel7;
  double _sellLevel8;
  double _sellLevel9;
  double _sellLevel10;
  double _sellLevel11;
  double _sellLevel12;
  Stock _mStock;
  double _mTargetValue;

  void calculateForStock(Stock stock, double targetValue) {
    this._mStock = stock;
    //Target Name, e.g: Price, Change, Change%
    this._mTargetValue = targetValue;

    //Calculate sell levels
    _sellLevel1 = double.parse(stock.sellTarget) *
        (1 + (double.parse(stock.sellInterval) / 100.0));

    _sellLevel2 =
        _sellLevel1 * (1 + (double.parse(stock.sellInterval) / 100.0));
    _sellLevel3 =
        _sellLevel2 * (1 + (double.parse(stock.sellInterval) / 100.0));
    _sellLevel4 =
        _sellLevel3 * (1 + (double.parse(stock.sellInterval) / 100.0));
    _sellLevel5 =
        _sellLevel4 * (1 + (double.parse(stock.sellInterval) / 100.0));
    _sellLevel6 =
        _sellLevel5 * (1 + (double.parse(stock.sellInterval) / 100.0));
    _sellLevel7 =
        _sellLevel6 * (1 + (double.parse(stock.sellInterval) / 100.0));
    _sellLevel8 =
        _sellLevel7 * (1 + (double.parse(stock.sellInterval) / 100.0));
    _sellLevel9 =
        _sellLevel8 * (1 + (double.parse(stock.sellInterval) / 100.0));
    _sellLevel10 =
        _sellLevel9 * (1 + (double.parse(stock.sellInterval) / 100.0));
    _sellLevel11 =
        _sellLevel10 * (1 + (double.parse(stock.sellInterval) / 100.0));
    _sellLevel12 =
        _sellLevel11 * (1 + (double.parse(stock.sellInterval) / 100.0));
  }

  int getStockLevel() {
    if (_mTargetValue <= double.parse(_mStock.sellTarget) &&
        _mTargetValue > _sellLevel1) {
      return 1;
    } else if (_mTargetValue <= _sellLevel1 && _mTargetValue > _sellLevel2) {
      return 2;
    } else if (_mTargetValue <= _sellLevel2 && _mTargetValue > _sellLevel3) {
      return 3;
    } else if (_mTargetValue <= _sellLevel3 && _mTargetValue > _sellLevel4) {
      return 4;
    } else if (_mTargetValue <= _sellLevel4 && _mTargetValue > _sellLevel5) {
      return 5;
    } else if (_mTargetValue <= _sellLevel5 && _mTargetValue > _sellLevel6) {
      return 6;
    } else if (_mTargetValue <= _sellLevel6 && _mTargetValue > _sellLevel7) {
      return 7;
    } else if (_mTargetValue <= _sellLevel7 && _mTargetValue > _sellLevel8) {
      return 8;
    } else if (_mTargetValue <= _sellLevel8 && _mTargetValue > _sellLevel9) {
      return 9;
    } else if (_mTargetValue <= _sellLevel9 && _mTargetValue > _sellLevel10) {
      return 10;
    } else if (_mTargetValue <= _sellLevel10 && _mTargetValue > _sellLevel1) {
      return 11;
    } else if (_mTargetValue <= _sellLevel11 && _mTargetValue > _sellLevel2) {
      return 12;
    } else {
      return -1;
    }
  }
}
