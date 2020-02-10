import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stock_monitor/PODO/APIStock.dart';
import 'package:stock_monitor/PODO/StocksList.dart';

class APIManager {
  static String _requestedSymbols = '';

  static Future<StocksList> fetchStock() async {
    final response = await http.get(
        'https://query1.finance.yahoo.com/v7/finance/quote?symbols=$_requestedSymbols');

    if (response.statusCode == 200) {
      print(response.body);
      return StocksList.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to fetch stocks');
    }
  }

  static void parseStocksSymbols(List<String> symbols) {
    symbols.forEach((symbol) {
      _requestedSymbols = _requestedSymbols + symbol + ',';
      print('REQUESTED SYMBOLS: $_requestedSymbols');
    });
  }

  static void setStockSymbol(String symbol){
    _requestedSymbols = symbol;
  }

  static void clearSymbols() {
    _requestedSymbols = '';
  }
}
