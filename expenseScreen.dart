import 'package:flutter/material.dart';
import '/chart.dart'; // Chart widget to visualize expenses
import '/expenses.dart'; // Not really needed here, could cause a self-import loop
import '/expense_list.dart'; // Widget to display list of expenses
import '/new_expense.dart'; // Widget to add new expense
import 'expenses1.dart'; // Expense model (data class)

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  // List to hold all registered expenses
  final List<Expense> _registeredExpenses = [];

  // Function to add new expense
  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense); // Add expense to list
    });
  }

  // Function to remove expense by ID
  void _removeExpense(String id) {
    setState(() {
      _registeredExpenses.removeWhere((expense) => expense.id == id);
    });
  }

  // Opens modal bottom sheet to add new expense
  void _openAddExpenseOverlay(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true, // Ensures sheet adapts to keyboard
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Access device size/orientation details
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    // AppBar with title and add button
    final appBar = AppBar(
      title: const Text('Expense Tracker'),
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => _openAddExpenseOverlay(context),
        ),
      ],
    );

    // Calculate available height (screen height minus appbar + top padding)
    final availableHeight =
        mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    // Chart widget (dynamic height based on orientation)
    final chartWidget = Container(
      height: isLandscape ? availableHeight * 0.7 : availableHeight * 0.3,
      child: Chart(expenses: _registeredExpenses),
    );

    // Expense list widget (takes more space than chart)
    final expenseListWidget = Container(
      height: isLandscape ? availableHeight * 0.7 : availableHeight * 0.7,
      child: ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense, // Pass remove function
      ),
    );

    // Final UI structure
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: isLandscape
            // Landscape: chart and list side by side
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: chartWidget),
                  const SizedBox(width: 16),
                  Expanded(child: expenseListWidget),
                ],
              )
            // Portrait: chart on top, list below
            : Column(
                children: [
                  chartWidget,
                  const SizedBox(height: 16),
                  expenseListWidget,
                ],
              ),
      ),

      // Floating button to add expenses
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddExpenseOverlay(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
