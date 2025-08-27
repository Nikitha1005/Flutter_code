import 'expenses.dart'; // Make sure the path is correct relative to this file
import 'expenses1.dart';

class ExpenseBucket {
  final Category category;
  final List<Expense> expenses;

  // Default constructor
  ExpenseBucket({required this.category, required this.expenses});

  // Alternative named constructor to filter expenses by category
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
    : expenses =
          allExpenses.where((expense) => expense.category == category).toList();

  // Getter to calculate total expenses in this bucket
  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
