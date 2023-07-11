import 'package:flutter/material.dart';

import '../expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key, required this.expense});

  final Expense expense;

  @override
  Widget build(context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(expense.title,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),),
          const SizedBox(height: 10,),
          Row(children: [
            Text('\$${expense.amount}'),
            const Spacer(),
            Icon(categoryIcons[expense.category]),
            const SizedBox(width: 10,),
            Text(expense.getFormattedDate)
            
          ],)
        ],),
      ),
    );
  }
}
