import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

class StockAddPage extends StatefulWidget {
  @override
  _StockAddPageState createState() => _StockAddPageState();
}

class _StockAddPageState extends State<StockAddPage> {
  final _symbolFieldController = TextEditingController();
  final _buyTargetFieldController = TextEditingController();
  final _buyIntervalFieldController = TextEditingController();
  final _sellTargetFieldController = TextEditingController();
  final _sellIntervalFieldController = TextEditingController();
  final _sharesBoughtFieldController = TextEditingController();
  final _sharesSoldFieldController = TextEditingController();
  final _commentsFieldController = TextEditingController();
  final List<String> _categoriesList = ['1', '2', '3', '4', '5'];
  final List<String> _colorsList = [
    'Red',
    'Orange',
    'Yellow',
    'Green',
    'Blue',
  ];
  int _index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.check,
                color: Colors.white,
              ),
              onPressed: () {})
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 30.0, right: 20.0, left: 20.0),
              child: TextField(
                textAlign: TextAlign.center,
                controller: _symbolFieldController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Stock symbol, e.g. MSFT',
                  hintStyle: TextStyle(fontSize: 16.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    'Category:',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  RadioButtonGroup(
                    orientation: GroupedButtonsOrientation.HORIZONTAL,
                    labels: _categoriesList,
                    itemBuilder: (Radio radio, Text text, int i) {
                      return Container(
                        width: 50.0,
                        child: FittedBox(
                          child: Row(
                            children: <Widget>[text, radio],
                          ),
                        ),
                      );
                    },
                    onSelected: (value) {
                      setState(() {
                        _index = int.parse(value);
                      });
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0, left: 20.0),
              child: Column(
                children: <Widget>[
                  Text(
                    'Color',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Container(
                    child: RadioButtonGroup(
                      orientation: GroupedButtonsOrientation.HORIZONTAL,
                      labels: _colorsList,
                      itemBuilder: (Radio radio, Text text, int i) {
                        return Container(
                          width: 68.0,
                          child: FittedBox(
                            child: Row(
                              children: <Widget>[text, radio],
                            ),
                          ),
                        );
                      },
                      onSelected: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30.0, right: 20.0, left: 20.0),
              child: TextField(
                textAlign: TextAlign.center,
                controller: _buyTargetFieldController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter a buy target price, e.g. 180',
                  hintStyle: TextStyle(fontSize: 16.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30.0, right: 20.0, left: 20.0),
              child: TextField(
                textAlign: TextAlign.center,
                controller: _buyIntervalFieldController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter a buy interval. e.g: 5%',
                  hintStyle: TextStyle(fontSize: 16.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30.0, right: 20.0, left: 20.0),
              child: TextField(
                textAlign: TextAlign.center,
                controller: _sellTargetFieldController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter a sell target price, e.g. 250',
                  hintStyle: TextStyle(fontSize: 16.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30.0, right: 20.0, left: 20.0),
              child: TextField(
                textAlign: TextAlign.center,
                controller: _sellIntervalFieldController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter a sell interval. e.g: 3%',
                  hintStyle: TextStyle(fontSize: 16.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30.0, right: 20.0, left: 20.0),
              child: TextField(
                textAlign: TextAlign.center,
                controller: _sharesBoughtFieldController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: '#of shares bought. e.g: 1000',
                  hintStyle: TextStyle(fontSize: 16.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30.0, right: 20.0, left: 20.0),
              child: TextField(
                textAlign: TextAlign.center,
                controller: _sharesSoldFieldController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: '#of shares sold. e.g: 500',
                  hintStyle: TextStyle(fontSize: 16.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30.0, right: 20.0, left: 20.0),
              child: TextField(
                textAlign: TextAlign.center,
                controller: _commentsFieldController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Some notes. e.g: sell when price > 250',
                  hintStyle: TextStyle(fontSize: 16.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: RaisedButton(
                  onPressed: () {},
                  color: Colors.white,
                  splashColor: Colors.green[100],
                  child: Container(
                    height: 40.0,
                    width: 130.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          'Save',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.green),
                        ),
                        Icon(
                          Icons.save,
                          color: Theme.of(context).primaryColor,
                        )
                      ],
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0),
                    side: BorderSide(color: Theme.of(context).primaryColor),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
