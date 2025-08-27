import 'package:flutter/material.dart';
import 'Category.dart';
import 'grocery_item.dart';

// NewItem screen allows the user to add a new grocery item
class NewItem extends StatefulWidget {
  final Function(GroceryItem) onAdd; // Callback to send item back to parent widget

  const NewItem({super.key, required this.onAdd});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  final _formKey = GlobalKey<FormState>(); // Key for form validation

  // Variables to store user input
  String _enteredName = '';
  int _enteredQuantity = 1;
  double _enteredPrice = 0;
  Category? _selectedCategory = CATEGORY_LIST.first.category; // Default category

  // Save the form and return new GroceryItem to parent
  void _saveItem() {
    final isValid = _formKey.currentState!.validate(); // Validate all inputs
    if (!isValid || _selectedCategory == null) return;

    _formKey.currentState!.save(); // Save form state

    // Create a new GroceryItem object
    final newItem = GroceryItem(
      id: DateTime.now().toString(), // Unique ID
      name: _enteredName,
      category: _selectedCategory!,
      quantity: _enteredQuantity,
      price: _enteredPrice,
    );

    // Pop the screen and return newItem to previous page
    Navigator.of(context).pop(newItem);
  }

  // Reset form fields to default values
  void _resetForm() {
    _formKey.currentState!.reset();
    setState(() {
      _selectedCategory = CATEGORY_LIST.first.category;
      _enteredQuantity = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add a New Item')), // Screen title
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey, // Connects form with validator
          child: ListView(
            children: [
              // NAME INPUT
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                maxLength: 50,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Name is required'; // Validation rule
                  }
                  if (value.trim().length < 2 || value.trim().length > 50) {
                    return 'Must be between 2 and 50 characters';
                  }
                  return null;
                },
                onSaved: (value) => _enteredName = value!.trim(),
              ),
              const SizedBox(height: 12),

              // QUANTITY + CATEGORY DROPDOWN
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Quantity input
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: 'Quantity'),
                      initialValue: _enteredQuantity.toString(),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Quantity required';
                        final parsed = int.tryParse(value);
                        if (parsed == null || parsed <= 0) return 'Must be positive';
                        return null;
                      },
                      onSaved: (value) => _enteredQuantity = int.parse(value!),
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Category dropdown
                  Expanded(
                    child: DropdownButtonFormField<Category>(
                      value: _selectedCategory,
                      items: CATEGORY_LIST.map((cat) {
                        return DropdownMenuItem<Category>(
                          value: cat.category,
                          child: Row(
                            children: [
                              // Color box for category
                              Container(width: 16, height: 16, color: cat.color),
                              const SizedBox(width: 6),
                              Text(cat.title),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) => setState(() => _selectedCategory = value),
                      validator: (value) => value == null ? 'Select a category' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // PRICE INPUT
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Price required';
                  final parsed = double.tryParse(value);
                  if (parsed == null || parsed < 0) return 'Must be positive';
                  return null;
                },
                onSaved: (value) => _enteredPrice = double.parse(value!),
              ),
              const SizedBox(height: 20),

              // ACTION BUTTONS: Add & Reset
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Save new item
                  ElevatedButton(onPressed: _saveItem, child: const Text('Add Item')),

                  // Reset form
                  ElevatedButton(
                    onPressed: _resetForm,
                    child: const Text('Reset'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
