import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/chart_bar.dart';

import 'models/Transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> transactionList;

  Chart(this.transactionList);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;
      for (var i = 0; i < transactionList.length; i++) {
        if (transactionList[i].dateTime.day == weekDay.day &&
            transactionList[i].dateTime.month == weekDay.month &&
            transactionList[i].dateTime.year == weekDay.year) {
          totalSum += transactionList[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  //total spending for the week
  double get maxSpending {
    return groupedTransactionValues.fold(0.0, (sum, element) {
      return sum + (element['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: groupedTransactionValues.map((data) {
            return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                    data['day'] as String,
                    data['amount'] as double,
                    maxSpending == 0.0
                        ? 0.0
                        : (data['amount'] as double) / maxSpending));
          }).toList(),
        ),
      ),
    );
  }
}
