import 'package:flutter/material.dart';
import 'package:expense_tracker/expenses1.dart'; // ✅ import model (Expense class)

class ExpensesList extends StatelessWidget {
  final List<Expense> expenses; // List of expenses to display
  final void Function(Expense) onRemoveExpense; // Callback to remove an expense

  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense, // Pass function from parent
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length, // Number of items in list
      itemBuilder: (ctx, index) {
        final expense = expenses[index]; // Get current expense
        return Dismissible(
          key: ValueKey(expense), // Unique key (important for Dismissible)
          direction:
              DismissDirection
                  .endToStart, // Swipe left to right (delete action)
          // 🔹 When swiped, trigger the remove callback
          onDismissed: (direction) => onRemoveExpense(expense),

          // 🔹 Red delete background when swiping
          background: Container(
            color: Colors.red, // Red background
            alignment: Alignment.centerRight, // Align content to right
            padding: const EdgeInsets.only(right: 20),
            child: const Icon(Icons.delete, color: Colors.white), // Trash icon
          ),

          // 🔹 Actual expense item
          child: ListTile(
            leading: const Icon(Icons.money), // Icon before expense title
            title: Text(expense.title), // Expense title
            subtitle: Text(
              '${expense.amount.toStringAsFixed(2)} • ${expense.category.name.toUpperCase()}',
              // Example: "250.00 • FOOD"
            ),
            trailing: Text(
              '${expense.date.day}/${expense.date.month}/${expense.date.year}',
              // Expense date formatted as DD/MM/YYYY
            ),
          ),
        );
      },
    );
  }
}
