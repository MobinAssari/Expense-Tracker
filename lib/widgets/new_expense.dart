import 'package:expense_tracker/category.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../expense.dart';

final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  NewExpense({super.key, required this.onAddToLIst});

  void Function(Expense expense) onAddToLIst;

  @override
  State<NewExpense> createState() {
    return _newExpenseState();
  }
}

class _newExpenseState extends State<NewExpense> {
  late Category _selectedCategory = Category.food;
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  DateTime? _selectedDate;

  void _showDatePicker() async {
    var now = DateTime.now();

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 1, now.month, now.day),
      lastDate: DateTime(now.year + 20, now.month, now.day),
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _saveButtonSwlected() {
    double? _enteredAmount = double.tryParse(_amountController.text);
    if (_selectedDate == null ||
        _enteredAmount == null ||
        _enteredAmount <= 0 ||
        _titleController.text.trim().isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text('Invalid Input'),
            content: const Text('Make sure inputs are valid'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: const Text('okay'))
            ],
          );
        },
      );
      return;
    }

    widget.onAddToLIst(Expense(
        amount: _enteredAmount,
        date: _selectedDate!,
        title: _titleController.text,
        category: _selectedCategory));
    Navigator.pop(context);
  }

  @override
  Widget build(context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return SizedBox( height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(30, 50, 30, keyboardSpace + 10),
          child: Column(

            children: [
              TextField(
                maxLength: 40,
                controller: _titleController,
                decoration: const InputDecoration(
                  label: Text('Title'),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      maxLength: 20,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        prefixText: '\$ ',
                        label: Text('Amount'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          _selectedDate == null
                              ? 'No Date Selected'
                              : formatter.format(_selectedDate!),
                        ),
                        IconButton(
                          onPressed: _showDatePicker,
                          icon: const Icon(Icons.calendar_month_outlined),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  DropdownButton(
                    value: _selectedCategory,
                    items: Category.values
                        .map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(category.name),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value == null) return;
                      setState(
                        () {
                          _selectedCategory = value;
                        },
                      );
                    },
                  ),
                  const Spacer(),
                  ElevatedButton(
                      onPressed: _saveButtonSwlected, child: const Text('Save')),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
