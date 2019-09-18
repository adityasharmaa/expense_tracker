import './transactionListItem.dart';
import "package:flutter/material.dart";
import "../models/transaction.dart";

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function _removeTransaction;

  TransactionList(this._transactions, this._removeTransaction);

  Widget build(BuildContext context) {
    return _transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                Text(
                  "No transactions yet!",
                  style: Theme.of(context).textTheme.title,
                ),
                Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      "assets/images/waiting.png",
                      fit: BoxFit.cover,
                    )),
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                child: Card(
                  elevation: 2,
                  child: TransactionListItem(
                      _transactions[index], _removeTransaction),
                ),
              );
            },
            itemCount: _transactions.length,
          );
  }
}
