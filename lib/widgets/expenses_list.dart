import 'package:expense_tracker/main.dart';
import 'package:expense_tracker/widgets/expense_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../expense.dart';

class ExpenseList extends StatelessWidget {
  ExpenseList(
      {super.key, required this.expenses, required this.onRemoveFromList});

  void Function(Expense expense) onRemoveFromList;
  final List<Expense> expenses;

  @override
  Widget build(context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        background:
            Container(color: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.4),margin: Theme.of(context).cardTheme.margin,),
        onDismissed: (direction) {
          onRemoveFromList(expenses[index]);
        },
        key: ValueKey(expenses[index]),
        child: ExpenseItem(expense: expenses[index]),
      ),
    );
  }
}
