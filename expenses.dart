import 'package:flutter/material.dart';
import 'package:expense_tracker/expenses1.dart'; // ✅ Model (Expense + Category)
import 'package:expense_tracker/expense_list.dart'; // ✅ Expense list widget

// 🔹 Root StatefulWidget for managing expenses
class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  // 🔹 Initial demo expense list
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  // 🔹 Controllers for input fields
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  // 🔹 State variables for new expense form
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  @override
  void dispose() {
    // Cleanup controllers when widget is removed
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  // 🔹 Opens bottom sheet for adding a new expense
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // ensures keyboard doesn't overlap
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom:
                MediaQuery.of(ctx).viewInsets.bottom + 20, // keyboard padding
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // shrink to content
            children: [
              _buildTitleInput(),
              const SizedBox(height: 16),
              _buildAmountDateRow(),
              const SizedBox(height: 16),
              _buildCategoryButtonsRow(ctx),
            ],
          ),
        );
      },
    );
  }

  // 🔹 Text input for title
  Widget _buildTitleInput() {
    return TextField(
      controller: _titleController,
      decoration: const InputDecoration(labelText: 'Title'),
    );
  }

  // 🔹 Row with amount input + date picker
  Widget _buildAmountDateRow() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _amountController,
            decoration: const InputDecoration(labelText: 'Amount'),
            keyboardType: TextInputType.number, // numeric keyboard
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Show selected date OR fallback text
              Text(
                _selectedDate == null
                    ? 'No date selected'
                    : _selectedDate!.toLocal().toString().split(' ')[0],
              ),
              IconButton(
                icon: const Icon(Icons.calendar_month),
                onPressed: _presentDatePicker,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 🔹 Row with category dropdown + cancel + add buttons
  Widget _buildCategoryButtonsRow(BuildContext ctx) {
    return Row(
      children: [
        DropdownButton<Category>(
          value: _selectedCategory,
          items:
              Category.values.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category.name.toUpperCase()),
                );
              }).toList(),
          onChanged: (value) {
            if (value == null) return;
            setState(() {
              _selectedCategory = value;
            });
          },
        ),
        const Spacer(),
        // Cancel button → closes modal
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(),
          child: const Text('Cancel'),
        ),
        // Add button → saves expense
        ElevatedButton(
          onPressed: _submitExpenseData,
          child: const Text('Add Expense'),
        ),
      ],
    );
  }

  // 🔹 Show date picker
  void _presentDatePicker() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 1, now.month, now.day),
      lastDate: now,
    );

    if (pickedDate == null) return;

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  // 🔹 Validate + add new expense
  void _submitExpenseData() {
    final enteredTitle = _titleController.text.trim();
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    // Validation check
    if (enteredTitle.isEmpty || amountIsInvalid || _selectedDate == null) {
      showDialog(
        context: context,
        builder:
            (ctx) => AlertDialog(
              title: const Text('Invalid input'),
              content: const Text(
                'Please make sure a valid title, amount, and date was entered.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: const Text('Okay'),
                ),
              ],
            ),
      );
      return;
    }

    // Create new expense object
    final newExpense = Expense(
      title: enteredTitle,
      amount: enteredAmount!,
      date: _selectedDate!,
      category: _selectedCategory,
    );

    // Add expense to list
    setState(() {
      _registeredExpenses.add(newExpense);
    });

    Navigator.of(context).pop(); // Close modal

    // Reset form fields
    _titleController.clear();
    _amountController.clear();
    _selectedDate = null;
    _selectedCategory = Category.leisure;
  }

  // 🔹 Remove expense with undo option
  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });

    // Clear old snackbars
    ScaffoldMessenger.of(context).clearSnackBars();

    // Show snackbar with undo
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Expense deleted.'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Default placeholder widget when no expenses exist
    Widget mainContent = const Center(
      child: Text('No expenses found. Start adding some!'),
    );

    // If list is not empty → show list
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense, // Pass delete function to list
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _openAddExpenseOverlay, // Open add expense modal
          ),
        ],
      ),
      body: Column(
        children: [
          const Text('Chart Placeholder'), // (future chart widget)
          const SizedBox(height: 20),
          Expanded(child: mainContent), // Either placeholder or list
        ],
      ),
    );
  }
}
