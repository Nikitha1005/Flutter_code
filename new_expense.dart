import 'package:flutter/material.dart';
import 'package:expense_tracker/expenses1.dart';

class NewExpense extends StatefulWidget {
  final void Function(Expense) onAddExpense;

  const NewExpense({Key? key, required this.onAddExpense}) : super(key: key);

  @override
  _NewExpenseState createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  Category? _selectedCategory;
  DateTime _selectedDate = DateTime.now();

  void _presentDatePicker() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() => _selectedDate = pickedDate);
    }
  }

  void _submitData() {
    final enteredTitle = _titleController.text.trim();
    final enteredAmount = double.tryParse(_amountController.text);

    if (enteredTitle.isEmpty ||
        enteredAmount == null ||
        enteredAmount <= 0 ||
        _selectedCategory == null) {
      showDialog(
        context: context,
        builder:
            (ctx) => AlertDialog(
              title: const Text('Invalid input'),
              content: const Text(
                'Please make sure a valid title, amount, date, and category was entered.',
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

    final newExpense = Expense(
      title: enteredTitle,
      amount: enteredAmount,
      date: _selectedDate,
      category: _selectedCategory!,
    );

    widget.onAddExpense(newExpense);

    // Close modal after adding expense
    Navigator.of(context).pop();

    // Reset form
    _titleController.clear();
    _amountController.clear();
    _selectedDate = DateTime.now();
    _selectedCategory = null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        16,
        48, // top padding to avoid notch/camera
        16,
        MediaQuery.of(context).viewInsets.bottom +
            16, // bottom padding for keyboard
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Amount'),
          ),
          const SizedBox(height: 16),
          DropdownButton<Category>(
            value: _selectedCategory,
            hint: const Text('Select Category'),
            isExpanded: true,
            items:
                Category.values
                    .map(
                      (c) => DropdownMenuItem(
                        value: c,
                        child: Text(c.name.toUpperCase()),
                      ),
                    )
                    .toList(),
            onChanged: (v) => setState(() => _selectedCategory = v),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Picked Date: ${_selectedDate.toLocal().toString().split(' ')[0]}',
                ),
              ),
              TextButton(
                onPressed: _presentDatePicker,
                child: const Text('Choose Date'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: _submitData,
                child: const Text('Add Expense'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
