import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StocksPage extends StatefulWidget {
  @override
  _StocksPageState createState() => _StocksPageState();
}

class _StocksPageState extends State<StocksPage> {
  final List<String> _stockSymbols = [
    'MSFT',
    'APLT',
    'AXSM',
    'RLMD',
    'CDLX',
    'EVER',
    'KRMD',
    'CLSD',
    'GSX',
    'CTACW',
  ];

  void _sortSymbolsAlphabetically() {
    _stockSymbols.sort((a, b) => a.compareTo(b));
  }

  @override
  Widget build(BuildContext context) {
    _sortSymbolsAlphabetically();
    return Scaffold(
      appBar: AppBar(
        title: Text('Stocks List'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Table(
              children: [
                TableRow(
                  children: [
                    Container(
                      height: 30.0,
                      child: Center(
                        child: Text('Symbol'),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.grey),
                    ),
                    Container(
                      height: 30.0,
                      child: Center(
                        child: Text('Price'),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.grey),
                    ),
                    Container(
                      height: 30.0,
                      child: Center(
                        child: Text('Change'),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.grey),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 2.0, right: 2.0),
                      height: 30.0,
                      child: Center(
                        child: FittedBox(child: Text('Change%')),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.grey),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 2.0, right: 2.0),
                      height: 30.0,
                      child: Center(
                        child: FittedBox(child: Text('Buy T.Diff.')),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.grey),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 2.0, right: 2.0),
                      height: 30.0,
                      child: Center(
                        child: FittedBox(child: Text('Sell T.Diff.')),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            Table(
              children: _stockSymbols.map((symbol) {
                return TableRow(
                  children: [
                    Container(
                      height: 30.0,
                      child: Center(
                        child: Text(symbol),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.grey),
                    ),
                    Container(
                      height: 30.0,
                      child: Center(
                        child: Text('50'),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.white),
                    ),
                    Container(
                      height: 30.0,
                      child: Center(
                        child: Text('100'),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.white),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 2.0, right: 2.0),
                      height: 30.0,
                      child: Center(
                        child: FittedBox(child: Text('13%')),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.white),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 2.0, right: 2.0),
                      height: 30.0,
                      child: Center(
                        child: FittedBox(child: Text('-20')),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.white),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 2.0, right: 2.0),
                      height: 30.0,
                      child: Center(
                        child: FittedBox(child: Text('+40')),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.white),
                    ),
                  ],
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
