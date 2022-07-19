import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './chart_bar.dart';
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

      print('day ${DateFormat.E().format(weekDay).substring(0, 1)}');
      print('amount ${sum}');

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': sum,
      };
    });
  }

  double get totalSpending {
    return groupedTransaction.fold(0.0, (previousValue, element) => previousValue += element['amount'] as double);
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransaction);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: groupedTransaction.map((data) {
          return ChartBar(
              data['day'].toString(),
              data['amount'] as double,
              totalSpending == 0.0 ? 0.0 : (data['amount'] as double) / totalSpending);
        }).toList(),
      ),
    );
  }
}