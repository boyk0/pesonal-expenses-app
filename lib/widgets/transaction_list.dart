import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 300,
      child: transactions.isEmpty ? Column(
        children: [
          Text(
            'No transactions added yet!!!',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 200,
            child: Image.asset(
              'assets/images/waiting.png',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ) : ListView.builder(
        itemBuilder: (ctx, i) {
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 5,
            ),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: EdgeInsets.all(6),
                  child: FittedBox(
                      child: Text('\$${transactions[i].amount}'),
                  ),
                ),
              ),
              title: Text(
                transactions[i].title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(
                DateFormat.yMMMd().format(transactions[i].date,
              ),
            ),
            ),
          );
          var c = Card(
            child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 2,
                      ),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Text(
                      '\$${transactions[i].amount.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Theme.of(context).primaryColor,

                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        transactions[i].title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        DateFormat.yMMMd().format(transactions[i].date),
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ]),
          );
        },
        itemCount: transactions.length,
      ),
    );
  }
  
}