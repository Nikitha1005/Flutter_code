import 'package:flutter/material.dart';
import 'package:expense_tracker/expenses1.dart'; // ✅ Import model (Expense class & Category)
import 'package:expense_tracker/expenses.dart'; // (might be unused here, check if needed)
import 'package:expense_tracker/expense_list.dart'; // ⚠️ Careful: circular import? (probably not needed)
import 'package:expense_tracker/expense._item.dart'; // ✅ Import ExpenseItem widget

// Widget to display a scrollable list of expenses
class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses});

  // List of all expenses passed from parent widget (stateful widget)
  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // 🔹 Creates a lazy-loading scrollable list
      itemCount: expenses.length, // Number of expenses
      itemBuilder:
          (ctx, index) => ExpenseItem(
            expenses[index],
          ), // Build each row using ExpenseItem widget
    );
  }
}
