import '../category.dart';
import '../expense.dart';

class ExpensePucket {
  ExpensePucket(this.category, this.expenses);

  ExpensePucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  Category category;
  List<Expense> expenses;

  double getExpense(){
    var sum = 0.0;
    for(var expense in expenses){
      sum+= expense.amount;
    }
    return sum;
  }
}
