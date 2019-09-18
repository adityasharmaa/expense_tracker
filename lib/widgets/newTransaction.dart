import "package:flutter/material.dart";
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function _addNewTransaction;

  NewTransaction(this._addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _datePicked;

  void _submitData() {
    final title = _titleController.text;
    final amountText = _amountController.text;

    if (title.isEmpty || amountText.isEmpty || _datePicked == null) return;

    final amount = double.parse(amountText);

    widget._addNewTransaction(
      title,
      amount,
      _datePicked,
    );

    Navigator.of(context).pop();
  }

  void _pickDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((datePicked) {
      if (datePicked != null) {
        setState(() {
          this._datePicked = datePicked;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
        top: 10,
        bottom: MediaQuery.of(context).viewInsets.bottom + 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              labelText: "Title",
            ),
            controller: _titleController,
          ),
          TextField(
            decoration: InputDecoration(
              labelText: "Amount",
            ),
            controller: _amountController,
            keyboardType: TextInputType.number,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(_datePicked == null
                  ? "No date choosen!"
                  : "Date Selected: ${DateFormat.yMMMd().format(_datePicked)}"),
              FlatButton(
                child: Text(
                  "Choose Date",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                textColor: Theme.of(context).primaryColor,
                onPressed: _pickDate,
              ),
            ],
          ),
          RaisedButton(
            child: Text("Add"),
            onPressed: _submitData,
            color: Theme.of(context).primaryColor,
            textColor: Theme.of(context).textTheme.button.color,
          )
        ],
      ),
    ));
  }
}
