import './widgets/chart.dart';

import "./widgets/newTransaction.dart";
import "./widgets/transactionList.dart";
import "./models/transaction.dart";
import "package:flutter/material.dart";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My App",
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.amber,
        accentColor: Colors.green,
        fontFamily: "Quicksand",
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              button: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  bool _showList = false;
  final List<Transaction> _transactions = [];

  void _addTransaction(String title, double amount, DateTime dateTime) {
    setState(() {
      _transactions.add(Transaction(
        title: title,
        amount: amount,
        id: 1,
        dateTime: dateTime,
      ));
    });
  }

  void _removeTransaction(DateTime dateTime) => setState(() {
        _transactions
            .removeWhere((tx) => tx.dateTime.isAtSameMomentAs(dateTime));
      });

  void _openNewTransactionSheet(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) => NewTransaction(_addTransaction),
    );
  }

  List<Transaction> get _recentTransactions {
    return _transactions.where((tx) {
      return tx.dateTime.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appBar = AppBar(
      title: Text("Expense Tracker"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            _openNewTransactionSheet(context);
          },
        )
      ],
    );

    final double space = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final isLandscape =
        mediaQuery.orientation == Orientation.landscape;

    final txList = Container(
        height: space * 0.75,
        child: TransactionList(_transactions, _removeTransaction));

    return Scaffold(
      appBar: appBar,
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Show List"),
                  Switch(
                    value: _showList,
                    onChanged: (val) {
                      setState(() {
                        _showList = val;
                      });
                    },
                  )
                ],
              ),
            if (!isLandscape)
              Container(
                height: space * 0.25,
                child: Chart(_recentTransactions),
              ),
            if (!isLandscape) txList,
            if (isLandscape)
              !_showList
                  ? Container(
                      height: space * 0.7,
                      child: Chart(_recentTransactions),
                    )
                  : txList,
          ]),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _openNewTransactionSheet(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
