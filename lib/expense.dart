import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import 'category.dart';

Uuid uuid = const Uuid();
DateFormat dateFormat = DateFormat.yMd();
const categoryIcons = {
  Category.leisure: Icons.movie,
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight,
  Category.work: Icons.work,
};

class Expense {


  Expense(
      {required this.amount,
      required this.date,
      required this.title,
      required this.category})
      : id = uuid.v4();
  final String title;
  final String id;
  final double amount;
  final DateTime date;
  final Category category;

  String get getFormattedDate {
    return dateFormat.format(date);
  }
}

