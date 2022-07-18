import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  Chart(this.recentTransaction);

  List<Map<String, Object>> get groupedTransaction {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double sum = 0;

      for (int i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.day == weekDay.day &&
            recentTransaction[i].date.month == weekDay.month &&
            recentTransaction[i].date.year == recentTransaction[i].date.year) {
          sum += recentTransaction[i].amount;
        }
      }

      print('day ${DateFormat.E().format(weekDay)}');
      print('amount ${sum}');

      return {
        'day': DateFormat.E().format(weekDay),
        'amount': sum,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransaction);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: [],
      ),
    );
  }
}