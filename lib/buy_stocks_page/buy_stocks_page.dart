import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BuyStocksPage extends StatefulWidget {
  @override
  _BuyStocksPageState createState() => _BuyStocksPageState();
}

class _BuyStocksPageState extends State<BuyStocksPage> {
  final List<int> _levelsList = [
    12,
    11,
    10,
    9,
    8,
    7,
    6,
    5,
    4,
    3,
    2,
    1,
  ];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Buy List Screen'),
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
                        child: FittedBox(
                          child: Text('Level/Cat.'),
                        ),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.grey),
                    ),
                    Container(
                      height: 30.0,
                      child: Center(
                        child: Text('1'),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.grey),
                    ),
                    Container(
                      height: 30.0,
                      child: Center(
                        child: Text('2'),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.grey),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 2.0, right: 2.0),
                      height: 30.0,
                      child: Center(
                        child: FittedBox(child: Text('3')),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.grey),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 2.0, right: 2.0),
                      height: 30.0,
                      child: Center(
                        child: FittedBox(child: Text('4')),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.grey),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 2.0, right: 2.0),
                      height: 30.0,
                      child: Center(
                        child: FittedBox(child: Text('5')),
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
              children: _levelsList.map((level) {
                return TableRow(
                  children: [
                    Container(
                      height: 30.0,
                      child: Center(
                        child: Text(level.toString()),
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
