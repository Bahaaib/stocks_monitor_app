import 'package:stock_monitor/database/moor_database.dart';

class BuyLevels {
  double _buyLevel1;
  double _buyLevel2;
  double _buyLevel3;
  double _buyLevel4;
  double _buyLevel5;
  double _buyLevel6;
  double _buyLevel7;
  double _buyLevel8;
  double _buyLevel9;
  double _buyLevel10;
  double _buyLevel11;
  double _buyLevel12;
  Stock _mStock;
  double _mTargetValue;

  void calculateForStock(Stock stock, double targetValue) {
    this._mStock = stock;
    //Target Name, e.g: Price, Change, Change%
    this._mTargetValue = targetValue;

    //Calculate buy levels
    _buyLevel1 = double.parse(stock.buyTarget) *
        (1 - (double.parse(stock.buyTarget) / 100.0));

    _buyLevel2 = _buyLevel1 * (1 - (double.parse(stock.buyTarget) / 100.0));
    _buyLevel3 = _buyLevel2 * (1 - (double.parse(stock.buyTarget) / 100.0));
    _buyLevel4 = _buyLevel3 * (1 - (double.parse(stock.buyTarget) / 100.0));
    _buyLevel5 = _buyLevel4 * (1 - (double.parse(stock.buyTarget) / 100.0));
    _buyLevel6 = _buyLevel5 * (1 - (double.parse(stock.buyTarget) / 100.0));
    _buyLevel7 = _buyLevel6 * (1 - (double.parse(stock.buyTarget) / 100.0));
    _buyLevel8 = _buyLevel7 * (1 - (double.parse(stock.buyTarget) / 100.0));
    _buyLevel9 = _buyLevel8 * (1 - (double.parse(stock.buyTarget) / 100.0));
    _buyLevel10 = _buyLevel9 * (1 - (double.parse(stock.buyTarget) / 100.0));
    _buyLevel11 = _buyLevel10 * (1 - (double.parse(stock.buyTarget) / 100.0));
    _buyLevel12 = _buyLevel11 * (1 - (double.parse(stock.buyTarget) / 100.0));
  }

  int getStockLevel() {
    if (_mTargetValue >= double.parse(_mStock.buyTarget) &&
        _mTargetValue < _buyLevel1) {
      return 1;
    } else if (_mTargetValue >= _buyLevel1 && _mTargetValue < _buyLevel2) {
      return 2;
    } else if (_mTargetValue >= _buyLevel2 && _mTargetValue < _buyLevel3) {
      return 3;
    } else if (_mTargetValue >= _buyLevel3 && _mTargetValue < _buyLevel4) {
      return 4;
    } else if (_mTargetValue >= _buyLevel4 && _mTargetValue < _buyLevel5) {
      return 5;
    } else if (_mTargetValue >= _buyLevel5 && _mTargetValue < _buyLevel6) {
      return 6;
    } else if (_mTargetValue >= _buyLevel6 && _mTargetValue < _buyLevel7) {
      return 7;
    } else if (_mTargetValue >= _buyLevel7 && _mTargetValue < _buyLevel8) {
      return 8;
    } else if (_mTargetValue >= _buyLevel8 && _mTargetValue < _buyLevel9) {
      return 9;
    } else if (_mTargetValue >= _buyLevel9 && _mTargetValue < _buyLevel10) {
      return 10;
    } else if (_mTargetValue >= _buyLevel10 && _mTargetValue < _buyLevel1) {
      return 11;
    } else {
      return 12;
    }
  }
}
