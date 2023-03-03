import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'models/Transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function deleteTransaction;

  const TransactionList(this.transaction, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return transaction.isEmpty
        ? noDataFound(context)
        : ListView.builder(
            itemBuilder: (context, index) {
              return transactionItem(transaction[index], context);
            },
            itemCount: transaction.length,
          );
  }

  Widget noDataFound(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          const Text(
            "No transaction added yet!!",
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          Image.asset(
            "assets/images/no_data.png",
            fit: BoxFit.cover,
            height: constraints.maxHeight * 0.6,
          )
        ],
      );
    });
  }

  Widget transactionItem(Transaction transaction, BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      color: Colors.brown[50],
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(7),
            child: FittedBox(
              child: Text("₹${transaction.amount.toStringAsFixed(0)}"),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(DateFormat().add_yMMMd().format(transaction.dateTime),
            style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 14)),
        trailing: IconButton(
            onPressed: () => deleteTransaction(transaction.id),
            icon: Icon(
              Icons.delete,
              color: Theme.of(context).errorColor,
            )),
      ),
    );

  }
}
