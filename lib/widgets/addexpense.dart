import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddExpense extends StatefulWidget {
  final Function addExpense;

  AddExpense(this.addExpense);

  @override
  _AddExpenseState createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selectedDate;

  void _handleSubmitClick() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addExpense(
      titleController.text,
      double.parse(amountController.text),
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      } else {
        setState(() {
          _selectedDate = pickedDate;
        });
      }
    });

    // showDateRangePicker(
    //   context: context,
    //   // initialDate: DateTime.now(),
    //   firstDate: DateTime(2019),
    //   lastDate: DateTime.now(),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Title',
              ),
              controller: titleController,
              onSubmitted: (_) => _handleSubmitClick(),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
              controller: amountController,
              keyboardType: TextInputType.numberWithOptions(signed: true),
              onSubmitted: (_) => _handleSubmitClick(),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No Date Chosen!'
                          : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                    ),
                  ),
                  FlatButton(
                    child: Text(
                      'Choose Date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    textColor: Theme.of(context).accentColor,
                    onPressed: _presentDatePicker,
                  ),
                ],
              ),
            ),
            RaisedButton(
              child: Text(
                'SUBMIT',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: _handleSubmitClick,
              color: Theme.of(context).accentColor,
              textColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
