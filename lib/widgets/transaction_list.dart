import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);



  @override
  Widget build(BuildContext context) {
    return  transactions.isEmpty ? LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: [
            Text(
              'No transactions added yet!!!',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: constraints.maxHeight * 0.6,
              child: Image.asset(
                'assets/images/waiting.png',
                fit: BoxFit.cover,
              ),
            ),
          ],
        );
      },
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
              trailing: MediaQuery.of(context).size.width > 400 ? TextButton(
                onPressed: () => deleteTransaction(transactions[i].id),
                style: TextButton.styleFrom(
                  primary: Theme.of(context).errorColor,
                ),
                child: FittedBox(
                  child: Row(
                    children: [
                      Icon(Icons.delete),
                      Text('Delete '),
                    ],
                  ),
                ),
              ) : IconButton(
                onPressed: () => deleteTransaction(transactions[i].id),
                color: Theme.of(context).errorColor,
                icon: Icon(Icons.delete),
              ),
            ),
          );
        },
        itemCount: transactions.length,
    );
  }
  
}