import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:stock_monitor/bloc/stocks/bloc.dart';
import 'package:stock_monitor/database/moor_database.dart';

class StockAddPage extends StatefulWidget {
  @override
  _StockAddPageState createState() => _StockAddPageState();
}

class _StockAddPageState extends State<StockAddPage> {
  final _stocksBloc = GetIt.instance<StocksBloc>();
  Stock _stock;
  int _categoryId = 1;
  String _color;
  String _targetNameSpinnerValue = 'Price';
  int _index;
  ProgressDialog _progressDialog;

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
  final List<String> _targetNames = [
    'Price',
    'Change',
    'Change%',
  ];

  @override
  void initState() {
    _stocksBloc.stocksStateSubject.listen((receivedState) {
      if (receivedState is StockInserted) {
        if (receivedState.isSuccessful) {
          _progressDialog.dismiss();
          _showSuccessDialog(context);
        } else {
          Navigator.of(context).pop();
          _showErrorDialog(context);
        }
      }
    });
    super.initState();
  }

  void _initProgressDialog() {
    _progressDialog.style(
      message: 'Saving Data...',
      backgroundColor: Colors.white,
      progressWidget: CircularProgressIndicator(),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w600),
    );
  }

  @override
  Widget build(BuildContext context) {
    _progressDialog = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
    _initProgressDialog();
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Stock'),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.check,
                color: Colors.white,
              ),
              onPressed: () {
                _createStock();
                _stocksBloc.dispatch(StockInsertRequested(_stock));
                _progressDialog.show();
              })
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(
          FocusNode(),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 30.0, right: 20.0, left: 20.0),
                child: TextField(
                  autofocus: false,
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
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
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
                          _categoryId = _index;
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
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
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
                          setState(() {
                            _color = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 100.0, left: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Text(
                        'Target Name',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0),
                      ),
                    ),
                    DropdownButton<String>(
                      value: _targetNameSpinnerValue,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 18),
                      underline: Container(height: 2, color: Colors.black),
                      onChanged: (String data) {
                        setState(() {
                          _targetNameSpinnerValue = data;
                        });
                      },
                      items: _targetNames
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30.0, right: 20.0, left: 20.0),
                child: TextField(
                  autofocus: false,
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
                  autofocus: false,
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
                  autofocus: false,
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
                  autofocus: false,
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
                  autofocus: false,
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
                  autofocus: false,
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
                  autofocus: false,
                  textAlign: TextAlign.center,
                  controller: _commentsFieldController,
                  keyboardType: TextInputType.text,
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
                    onPressed: () {
                      _progressDialog.show();
                      _createStock();
                      _stocksBloc.dispatch(StockInsertRequested(_stock));
                    },
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
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                          Icon(
                            Icons.save,
                            color: Theme.of(context).primaryColor,
                          )
                        ],
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(color: Theme.of(context).primaryColor),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Container(
          height: 100.0,
          child: Center(
            child: Text('Data successfully saved!'),
          ),
        ),
        title: Container(
          height: 50.0,
          color: Colors.green,
          child: Center(
            child: Text(
              'Success',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        titlePadding: EdgeInsets.all(0.0),
      ),
    );
  }

  _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Container(
          height: 100.0,
          child: Center(
            child: Text('All fields are required'),
          ),
        ),
        title: Container(
          height: 50.0,
          color: Colors.red,
          child: Center(
            child: Text(
              'Error',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        titlePadding: EdgeInsets.all(0.0),
      ),
    );
  }

  void _createStock() {
    _stock = Stock(
        symbol: _symbolFieldController.text.toUpperCase(),
        categoryId: _categoryId,
        color: _color,
        targetName: _targetNameSpinnerValue,
        buyTarget: _buyTargetFieldController.text,
        buyInterval: _buyIntervalFieldController.text,
        sellTarget: _sellTargetFieldController.text,
        sellInterval: _sellIntervalFieldController.text,
        sharesBought: _sharesBoughtFieldController.text,
        sharesSold: _sharesSoldFieldController.text,
        comments: _commentsFieldController.text);
  }
}
