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
  Stock _pickedStock;
  int _categoryId = 1;
  String _color = 'Red';
  String _targetNameSpinnerValue = 'Price';
  int _index;
  ProgressDialog _progressDialog;
  bool _isInit = true;
  String _pickedColor = 'Red';

  final _symbolFieldController = TextEditingController();
  final _buyTargetFieldController = TextEditingController();
  final _buyIntervalFieldController = TextEditingController();
  final _sellTargetFieldController = TextEditingController();
  final _sellIntervalFieldController = TextEditingController();
  final _sharesBoughtFieldController = TextEditingController();
  final _sharesSoldFieldController = TextEditingController();
  final _commentsFieldController = TextEditingController();

  final _buyTargetNode = FocusNode();
  final _buyIntervalNode = FocusNode();
  final _sellTargetNode = FocusNode();
  final _sellIntervalNode = FocusNode();
  final _sharesBoughtNode = FocusNode();
  final _sharesSoldNode = FocusNode();
  final _commentsNode = FocusNode();

  final List<String> _categoriesList = ['1', '2', '3', '4', '5'];
  final List<String> _targetNames = [
    'Price',
    'Change',
    'Change%',
  ];

  @override
  void initState() {
    _stocksBloc.stocksStateSubject.listen((receivedState) {
      if (receivedState is StockValidationChecked) {
        if (receivedState.isExist) {
          if (receivedState.job == 'add') {
            _progressDialog.show();
            _createStock();
            _stocksBloc.dispatch(StockInsertRequested(_stock));
          } else {
            _progressDialog.show();
            _updateStock();
            _stocksBloc.dispatch(StockUpdateRequested(_pickedStock));
          }
        }else{
          _progressDialog.dismiss();
          _showErrorDialog(context, 'Stock symbol is not valid');
        }
      }
      if (receivedState is StockInserted) {
        print('STATE INSERT');
        if (receivedState.isSuccessful) {
          if (_progressDialog.isShowing()) {
            Navigator.of(context).pop();
          }
          Navigator.pop(context);
        } else {
          _progressDialog.dismiss();
          Navigator.of(context).pop();
          _showErrorDialog(context, 'All fields are required');
        }
      }

      if (receivedState is StockIsUpdated) {
        print('STATE UPDATE');

        if (receivedState.isSuccessful) {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        } else {
          _progressDialog.dismiss();
          Navigator.of(context).pop();
          _showErrorDialog(context, 'All fields are required');
        }
      }

      if (receivedState is StockIsDeleted) {
        print('STATE DELETE');
        if (receivedState.isSuccessful) {
          if (_progressDialog.isShowing()) {
            Navigator.of(context).pop();
          }
          Navigator.of(context).pop();
        } else {
          _progressDialog.dismiss();
          Navigator.of(context).pop();
          _showErrorDialog(context, 'All fields are required');
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
    final _args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    String _job = _args['job'];
    _pickedStock = _args['stock'];

    if (_job == 'update' && _isInit) {
      _addInitialValues(_pickedStock);
    }

    _progressDialog = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
    _initProgressDialog();
    return Scaffold(
      appBar: AppBar(
        title: Text(_job == 'add' ? 'Add Stock' : 'Update Stock'),
        actions: _job == 'add'
            ? <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _stocksBloc.dispatch(StockValidationRequested(
                          _symbolFieldController.text, _job));
                    })
              ]
            : <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _stocksBloc.dispatch(StockDeleteRequested(_pickedStock));
                      _progressDialog.show();
                    }),
                IconButton(
                    icon: Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _stocksBloc.dispatch(StockValidationRequested(
                          _symbolFieldController.text, _job));
                    }),
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
                margin: EdgeInsets.only(top: 10.0, right: 20.0, left: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Symbol:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                    Container(
                      width: 250.0,
                      height: 40.0,
                      child: TextField(
                        autofocus: false,
                        textAlign: TextAlign.center,
                        controller: _symbolFieldController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'Stock symbol, e.g. MSFT',
                          hintStyle: TextStyle(fontSize: 14.0),
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
                        onEditingComplete: () =>
                            FocusScope.of(context).requestFocus(_buyTargetNode),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 0.0),
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
                      picked: _categoryId.toString(),
                      itemBuilder: (Radio radio, Text text, int i) {
                        return Container(
                          width: 50.0,
                          child: FittedBox(
                            child: Row(
                              children: <Widget>[radio, text],
                            ),
                          ),
                        );
                      },
                      onSelected: (value) {
                        setState(() {
                          _index = int.parse(value);
                          _categoryId = _index;
                          _isInit = false;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 0.0, left: 20.0, right: 10.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Color:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Radio(
                          value: 'Red',
                          groupValue: _pickedColor,
                          onChanged: (value) {
                            setState(() {
                              _color = value;
                              _pickedColor = value;
                              _isInit = false;
                            });
                          }),
                    ),
                    Text(
                      'Red',
                      style: TextStyle(fontSize: 12.0),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Radio(
                          value: 'Orange',
                          groupValue: _pickedColor,
                          onChanged: (value) {
                            setState(() {
                              _color = value;
                              _pickedColor = value;
                              _isInit = false;
                            });
                          }),
                    ),
                    Text(
                      'Orange',
                      style: TextStyle(fontSize: 12.0),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Radio(
                          value: 'Yellow',
                          groupValue: _pickedColor,
                          onChanged: (value) {
                            setState(() {
                              _color = value;
                              _pickedColor = value;
                              _isInit = false;
                            });
                          }),
                    ),
                    Text(
                      'Yellow',
                      style: TextStyle(fontSize: 12.0),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Radio(
                          value: 'Green',
                          groupValue: _pickedColor,
                          onChanged: (value) {
                            setState(() {
                              _color = value;
                              _pickedColor = value;
                              _isInit = false;
                            });
                          }),
                    ),
                    Text(
                      'Green',
                      style: TextStyle(fontSize: 12.0),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Radio(
                          value: 'Blue',
                          groupValue: _pickedColor,
                          onChanged: (value) {
                            setState(() {
                              _color = value;
                              _pickedColor = value;
                              _isInit = false;
                            });
                          }),
                    ),
                    Text(
                      'Blue',
                      style: TextStyle(fontSize: 12.0),
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
                      elevation: 8,
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 14),
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
                margin: EdgeInsets.only(top: 10.0, right: 20.0, left: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Buy Target:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                    Container(
                      height: 40.0,
                      width: 220.0,
                      child: TextField(
                        focusNode: _buyTargetNode,
                        autofocus: false,
                        textAlign: TextAlign.center,
                        controller: _buyTargetFieldController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Enter a buy target price, e.g. 180',
                          hintStyle: TextStyle(fontSize: 12.0),
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
                        onSubmitted: (_) => FocusScope.of(context)
                            .requestFocus(_buyIntervalNode),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0, right: 20.0, left: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Buy Interval:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                    Container(
                      height: 40.0,
                      width: 220.0,
                      child: TextField(
                          focusNode: _buyIntervalNode,
                          autofocus: false,
                          textAlign: TextAlign.center,
                          controller: _buyIntervalFieldController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Enter a buy interval, e.g: 5%',
                            hintStyle: TextStyle(fontSize: 12.0),
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
                          onSubmitted: (_) => FocusScope.of(context)
                              .requestFocus(_sellTargetNode)),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0, right: 20.0, left: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Sell Target:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                    Container(
                      width: 220.0,
                      height: 40.0,
                      child: TextField(
                          focusNode: _sellTargetNode,
                          autofocus: false,
                          textAlign: TextAlign.center,
                          controller: _sellTargetFieldController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Enter a sell target price, e.g. 250',
                            hintStyle: TextStyle(fontSize: 12.0),
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
                          onSubmitted: (_) => FocusScope.of(context)
                              .requestFocus(_sellIntervalNode)),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0, right: 20.0, left: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Sell Interval:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                    Container(
                      width: 220.0,
                      height: 40.0,
                      child: TextField(
                          focusNode: _sellIntervalNode,
                          autofocus: false,
                          textAlign: TextAlign.center,
                          controller: _sellIntervalFieldController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Enter a sell interval, e.g. 3%',
                            hintStyle: TextStyle(fontSize: 12.0),
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
                          onSubmitted: (_) => FocusScope.of(context)
                              .requestFocus(_sharesBoughtNode)),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0, right: 20.0, left: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Shares Bought:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                    Container(
                      width: 205.0,
                      height: 40.0,
                      child: TextField(
                          focusNode: _sharesBoughtNode,
                          autofocus: false,
                          textAlign: TextAlign.center,
                          controller: _sharesBoughtFieldController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: '# of shares bought, e.g: 1000',
                            hintStyle: TextStyle(fontSize: 12.0),
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
                          onSubmitted: (_) => FocusScope.of(context)
                              .requestFocus(_sharesSoldNode)),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0, right: 20.0, left: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Shares Sold:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                    Container(
                      width: 220.0,
                      height: 40.0,
                      child: TextField(
                          focusNode: _sharesSoldNode,
                          autofocus: false,
                          textAlign: TextAlign.center,
                          controller: _sharesSoldFieldController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: '# of shares sold, e.g: 500',
                            hintStyle: TextStyle(fontSize: 12.0),
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
                          onSubmitted: (_) => FocusScope.of(context)
                              .requestFocus(_commentsNode)),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0, right: 20.0, left: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Comments:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                    Container(
                      width: 220.0,
                      height: 40.0,
                      child: TextField(
                        focusNode: _commentsNode,
                        autofocus: false,
                        textAlign: TextAlign.center,
                        controller: _commentsFieldController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'Some notes. e.g: sell when price > 250',
                          hintStyle: TextStyle(fontSize: 12.0),
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
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 10.0, bottom: 5.0),
                  child: RaisedButton(
                    onPressed: () {
                      _stocksBloc.dispatch(StockValidationRequested(
                          _symbolFieldController.text, _job));
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
                            _job == 'add' ? 'Save' : 'Update',
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

  _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Container(
          height: 100.0,
          child: Center(
            child: Text(message, textAlign: TextAlign.center,),
          ),
        ),
        title: Container(
          height: 50.0,
          color: Colors.red,
          child: Center(
            child: Container(
              margin: EdgeInsets.only(left: 20.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Error',
                    style: TextStyle(color: Colors.white),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: Colors.white,
                    ),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),
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

  void _updateStock() {
    _pickedStock = _pickedStock.copyWith(
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

  void _addInitialValues(Stock stock) {
    _symbolFieldController.text = stock.symbol;
    _buyTargetFieldController.text = stock.buyTarget;
    _buyIntervalFieldController.text = stock.buyInterval;
    _sellTargetFieldController.text = stock.sellTarget;
    _sellIntervalFieldController.text = stock.sellInterval;
    _sharesBoughtFieldController.text = stock.sharesBought;
    _sharesSoldFieldController.text = stock.sharesSold;
    _commentsFieldController.text = stock.comments;

    _pickedColor = stock.color;
    _categoryId = stock.categoryId;
    _targetNameSpinnerValue = stock.targetName;
  }
}
