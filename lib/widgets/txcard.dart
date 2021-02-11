import 'package:flutter/material.dart';
import 'package:flutter_expense/models/transaction.dart';
import 'package:intl/intl.dart';

class TxCard extends StatelessWidget {
  final Transcation tx;
  final Function deletTx;

  TxCard(this.tx, this.deletTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Card(
        elevation: 3,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).accentColor,
              radius: 30,
              child: Padding(
                padding: EdgeInsets.all(5),
                child: FittedBox(
                  child: Text(
                    "\$${tx.amount.toStringAsFixed(2)}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),
            title: Text(
              tx.title,
              style: Theme.of(context).textTheme.headline3,
            ),
            subtitle: Text(
              DateFormat('MMMM dd, yyyy').format(tx.date),
              // style: Theme.of(context).textTheme.headline3,
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: () => deletTx(tx.id),
            ),
          ),
        ),
      ),
    );
  }
}
