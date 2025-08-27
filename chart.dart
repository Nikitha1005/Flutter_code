import 'package:flutter/material.dart';
import '../expenses.dart';
import '../expenseBucket.dart';
import 'chart_bar.dart';
import 'expenses1.dart';

class Chart extends StatelessWidget {
  final List<Expense> expenses; // List of all expenses to be displayed in chart

  const Chart({super.key, required this.expenses});

  // 🔹 Create a list of buckets (grouped expenses by category)
  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.forCategory(expenses, Category.food),
      ExpenseBucket.forCategory(expenses, Category.travel),
      ExpenseBucket.forCategory(expenses, Category.leisure),
      ExpenseBucket.forCategory(expenses, Category.work),
    ];
  }

  // 🔹 Find the maximum total expenses from all categories
  // This is used to calculate the "fill" percentage for each ChartBar
  double get maxTotalExpenses {
    double max = 0;
    for (final bucket in buckets) {
      if (bucket.totalExpenses > max) {
        max = bucket.totalExpenses;
      }
    }
    return max;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16), // Spacing around the chart card
      child: Padding(
        padding: const EdgeInsets.all(16), // Padding inside the card
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end, // Align bars to bottom
          children: [
            // 🔹 Loop through each bucket and render a ChartBar
            for (final bucket in buckets)
              ChartBar(
                // The "fill" height is proportional to totalExpenses/maxTotalExpenses
                fill:
                    maxTotalExpenses == 0
                        ? 0 // Avoid division by zero when no expenses exist
                        : bucket.totalExpenses / maxTotalExpenses,
                category:
                    bucket.category, // Pass category to display correct icon
              ),
          ],
        ),
      ),
    );
  }
}
