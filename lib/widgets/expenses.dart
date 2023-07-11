import 'package:expense_tracker/widgets/expenses_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/expense.dart';

import '../category.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  void _addToList(Expense expense) {
    setState(
      () {
        _expenceData.add(expense);
      },
    );
  }

  void _removeFromList(Expense expense) {
    final expenceIndex = _expenceData.indexOf(expense);
    setState(
      () {
        _expenceData.remove(expense);
      },
    );
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Item Deleted!'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(
              () {
                _expenceData.insert(expenceIndex, expense);
              },
            );
          },
        ),
      ),
    );
  }

  final List<Expense> _expenceData = [
    Expense(
        amount: 20,
        date: DateTime.now(),
        title: 'book',
        category: Category.leisure),
    Expense(
        amount: 11.5,
        date: DateTime.now(),
        title: 'lunch',
        category: Category.food)
  ];

  void _addItemSheetOpener() {
    showModalBottomSheet(
      useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return NewExpense(
            onAddToLIst: _addToList,
          );
        });
  }

  @override
  Widget build(context) {
    var width = MediaQuery.of(context).size.width;
    Widget mainContent = const Center(
      child: Text('Empty! Try Adding Items'),
    );
    if (_expenceData.isNotEmpty) {
      mainContent = ExpenseList(
        expenses: _expenceData,
        onRemoveFromList: _removeFromList,
      );
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Expense Tracker'),
          actions: [
            IconButton(
                onPressed: _addItemSheetOpener, icon: const Icon(Icons.add))
          ],
        ),
        body:
        width < 600 ?
        Column(
          children: [

            Expanded(child: mainContent),
          ],
        ) : Row(children: [

          Expanded(child: mainContent),
        ],));
  }
}
