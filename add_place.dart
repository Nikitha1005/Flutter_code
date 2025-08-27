import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../place.dart';
import '../place_provider.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  static const routeName = '/add-place';

  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _formKey = GlobalKey<FormState>();
  String _enteredTitle = '';

  void _savePlace() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;

    _formKey.currentState!.save();

    final newPlace = Place(
      id: DateTime.now().toString(),
      title: _enteredTitle,
    );

    ref.read(placesProvider.notifier).addPlace(newPlace);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add a Place')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a title.';
                  }
                  return null;
                },
                onSaved: (value) => _enteredTitle = value!.trim(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _savePlace,
                child: const Text('Add Place'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
