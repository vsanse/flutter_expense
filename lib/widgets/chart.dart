import 'package:flutter/material.dart';
import 'package:flutter_expense/models/transaction.dart';
import 'package:flutter_expense/widgets/chart_bar.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transcation> recentTranscations;

  Chart(this.recentTranscations);

  List<Map<String, Object>> get grouppedTranscationValues {
    return List.generate(7, (idx) {
      final weekDay = DateTime.now().subtract(Duration(
        days: idx,
      ));
      double totalSum = 0.0;

      for (var i = 0; i < recentTranscations.length; i++) {
        if (recentTranscations[i].date.day == weekDay.day &&
            recentTranscations[i].date.month == weekDay.month &&
            recentTranscations[i].date.year == weekDay.year) {
          totalSum += recentTranscations[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get maxSpending {
    return grouppedTranscationValues.fold(0.0, (accumulator, tx) {
      return accumulator + tx['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Card(
        elevation: 6,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ...grouppedTranscationValues.map((tx) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                    label: tx['day'],
                    spendingAmount: tx['amount'],
                    spendingPctOfTotal: maxSpending == 0.0
                        ? 0
                        : (tx['amount'] as double) / maxSpending,
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
