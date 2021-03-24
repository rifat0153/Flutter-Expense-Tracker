import 'dart:ui';

import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/widgets/chart.dart';
import 'package:expense_tracker/widgets/new_transaction.dart';
import 'package:expense_tracker/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          errorColor: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'OpenSans',
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                    headline6: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                )),
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 67.33,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'New Bike',
      amount: 400,
      date: DateTime.now().subtract(
        Duration(days: 3),
      ),
    ),
    Transaction(
      id: 't3',
      title: 'New Shoes',
      amount: 67.33,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't4',
      title: 'New Bike',
      amount: 3700,
      date: DateTime.now().subtract(
        Duration(days: 2),
      ),
    ),
    Transaction(
      id: 't5',
      title: 'New Shoes',
      amount: 67.33,
      date: DateTime.now().subtract(
        Duration(days: 3),
      ),
    ),
    Transaction(
      id: 't6',
      title: 'New Bike',
      amount: 100,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      id: 't7',
      title: 'New Shoes',
      amount: 67.33,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't8',
      title: 'New Bike',
      amount: 100,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime date) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: date);

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(
        'Personal Expenses',
        style: TextStyle(fontFamily: 'Roboto'),
      ),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _startAddNewTransaction(context);
            }),
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.3,
                child: Chart(_recentTransactions),
              ),
              Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.7,
                child: TransactionList(_userTransactions, _deleteTransaction),
              ),
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _startAddNewTransaction(context);
        },
      ),
    );
  }
}
