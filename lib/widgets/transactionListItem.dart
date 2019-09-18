import '../models/transaction.dart';
import 'package:flutter/material.dart';
import "package:intl/intl.dart";

class TransactionListItem extends StatelessWidget {
  final Transaction _transaction;
  final Function _removeTransaction;

  TransactionListItem(this._transaction, this._removeTransaction);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        child: Padding(
          padding: EdgeInsets.all(5),
          child: FittedBox(
            child: Text("₹ ${_transaction.amount}"),
          ),
        ),
      ),
      title: Text(
        "${_transaction.title}",
        style: Theme.of(context).textTheme.title,
      ),
      subtitle: Text(DateFormat.yMMMd().format(_transaction.dateTime)),
      trailing: MediaQuery.of(context).size.width > 490
          ? FlatButton.icon(
            icon: Icon(
              Icons.delete
            ),
            label: Text("Delete"),
            textColor: Theme.of(context).errorColor,
            onPressed: () {
              _removeTransaction(_transaction.dateTime);
            },
          )
          : IconButton(
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: () {
                _removeTransaction(_transaction.dateTime);
              },
            ),
    );
  }
}
