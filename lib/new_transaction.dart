import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTxn;

  NewTransaction(this.addTxn);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  DateTime? _selectedDate;

  void submitTransaction() {
    final String enteredTitle = _titleController.text;
    final double enteredAmount = double.parse(_amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTxn(enteredTitle, enteredAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _pickDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2023),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            decoration: const InputDecoration(
              label: Text("Title"),
            ),
            controller: _titleController,
            onSubmitted: (_) =>
                submitTransaction(), //we are not using the value due to that we put underscore
          ),
          TextField(
            decoration: const InputDecoration(
              label: Text("Amount"),
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            controller: _amountController,
            onSubmitted: (_) => submitTransaction(),
          ),
          SizedBox(
            height: 70,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Text(_selectedDate == null
                        ? "No date chosen!"
                        : 'Picked Date: ${DateFormat.yMd().format(_selectedDate!)}')),
                TextButton(
                    onPressed: _pickDate,
                    child: Text(
                      "Choose date",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          ),
          ElevatedButton(
              onPressed: submitTransaction,
              child: const Text("Add transaction"))
        ],
      ),
    );
  }
}
