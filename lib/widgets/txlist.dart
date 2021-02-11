import 'package:flutter/material.dart';
import 'package:flutter_expense/models/transaction.dart';
import 'package:flutter_expense/widgets/txcard.dart';

class TxList extends StatelessWidget {
  final List<Transcation> transcations;
  final Function deletTx;

  TxList(this.transcations, this.deletTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      child: transcations.isEmpty
          ? Container(
              margin: EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Text(
                    'No Transactions added yet!',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  Container(
                    height: 200,
                    margin: EdgeInsets.only(top: 20),
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
            )
          : ListView.builder(
              itemBuilder: (ctx, idx) {
                return TxCard(transcations[idx], deletTx);
              },
              itemCount: transcations.length,
            ),
    );
  }
}
