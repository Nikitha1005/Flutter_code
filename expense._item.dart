import 'package:flutter/material.dart';
import '../expenses1.dart'; // ✅ Import model & category icons

class ExpenseItem extends StatelessWidget {
  final Expense expense; // The expense data to display

  // Constructor → takes one Expense object
  const ExpenseItem(this.expense, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

      // Card margin: adds spacing around each item
      child: Padding(
        padding: const EdgeInsets.all(16), // Inner padding inside the card
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align text left
          children: [
            // 🔹 Expense title
            Text(
              expense.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8), // Small vertical spacing
            // 🔹 Row with amount + date + category
            Row(
              children: [
                // Expense amount
                Text('\$${expense.amount.toStringAsFixed(2)}'),

                const Spacer(), // Pushes date & icon to the right

                Row(
                  children: [
                    // Category icon (from categoryIcons map)
                    Icon(categoryIcons[expense.category]),

                    const SizedBox(width: 8), // Small horizontal space
                    // Expense date (formatted string from model)
                    Text(expense.formattedDate),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
