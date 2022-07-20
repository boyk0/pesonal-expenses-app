import 'dart:io';

import 'package:expenses/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

import './models/transaction.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        errorColor: Colors.red,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
          titleMedium: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        buttonTheme: ThemeData.light().buttonTheme.copyWith(
          buttonColor: Colors.white,
        ),
        appBarTheme: AppBarTheme(
          color: Colors.deepOrangeAccent,
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(id: 't1', title: 'q', amount: 10, date: DateTime.now()),
    // Transaction(id: 't2', title: 'w', amount: 11.1, date: DateTime.now()),
  ];
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((transaction) {
      return transaction.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }
  
  void _addTransaction(String title, double amount, DateTime date) {
    final newTransaction = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: date,
    );

    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((transaction) => transaction.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewTransaction(_addTransaction));
        },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    final dynamic appBar = Platform.isIOS ? CupertinoNavigationBar(
      middle: Text(
        'App',
        style: TextStyle(
          fontFamily: 'OpenSans',
          color: Colors.black,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => _startAddNewTransaction(context),
            child: Icon(CupertinoIcons.add),
          ),
        ],
      ),
    ) : AppBar(
      title: Text(
        'App',
        style: TextStyle(
            fontFamily: 'OpenSans'
        ),
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () => _startAddNewTransaction(context),
          icon: Icon(Icons.add),
        ),
      ],
    );

    final transactionsListWidget = Container(
      height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.7,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );

    final pageBody = SafeArea(child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (isLandscape) Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Show chart',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Switch.adaptive(
                activeColor: Theme.of(context).accentColor,
                value: _showChart,
                onChanged: ( value) {
                  setState(() {
                    _showChart = value;
                  });
                },
              ),
            ],
          ),
          if (!isLandscape) Container(
            height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.3,
            child: Chart(_recentTransactions),
          ),
          if (!isLandscape) transactionsListWidget,

          if (isLandscape) _showChart ? Container(
            height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.7,
            child: Chart(_recentTransactions),
          ) : transactionsListWidget
        ],
      ),
    ),);

    return Platform.isIOS ? CupertinoPageScaffold(
      child: pageBody,
      navigationBar: appBar,
    ) : Scaffold(
      appBar: appBar,
      body: pageBody,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS ? Container() : FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
