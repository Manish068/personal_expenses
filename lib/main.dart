import 'package:flutter/material.dart';
import 'package:personal_expenses/chart.dart';
import 'package:personal_expenses/new_transaction.dart';

import 'Transaction_list.dart';
import 'models/Transaction.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Personal Expense",
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: MyHomePage(title: 'Personal Expense'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> transaction = [
    // Transaction(
    //     "1", "Petrol", 650.0, DateTime.now().subtract(Duration(days: 1))),
    // Transaction("2", "House hold good", 250.0,
    //     DateTime.now().subtract(Duration(days: 2))),
    // Transaction(
    //     "3", "shoes", 1800.0, DateTime.now().subtract(Duration(days: 3))),
    // Transaction(
    //     "4", "Dinner", 780.0, DateTime.now().subtract(Duration(days: 4))),
    // Transaction(
    //     "5", "Daily Need", 540.0, DateTime.now().subtract(Duration(days: 1))),
  ];

  void _addTransaction(String txTitle, double amount, DateTime selectedDate) {
    var txn =
        Transaction(DateTime.now().toString(), txTitle, amount, selectedDate);
    setState(() {
      transaction.add(txn);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      transaction.removeWhere((tx) => tx.id == id);
    });
  }

  bool _showChart = false;

  List<Transaction> get _recentTransaction {
    return transaction.where((tx) {
      return tx.dateTime
          .isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  void _showBottomSheetDialog(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            child: NewTransaction(_addTransaction),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text(widget.title),
    );

    final txtListWidget = SizedBox(
        height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            1.0,
        child: TransactionList(transaction, _deleteTransaction));

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Show Chart"),
                  Switch(
                      value: _showChart,
                      onChanged: (val) {
                        setState(() {
                          _showChart = val;
                        });
                      })
                ],
              ),
            if (!isLandscape)
              SizedBox(
                  height: (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.15,
                  child: Chart(_recentTransaction)),
            if (!isLandscape) txtListWidget,
            if (isLandscape)
              _showChart
                  ? SizedBox(
                      height: (MediaQuery.of(context).size.height -
                              appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.7,
                      child: Chart(_recentTransaction))
                  : txtListWidget
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showBottomSheetDialog(context),
        child: const Icon(
          Icons.add,
          size: 18,
        ),
      ),
    );
  }
}
