import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../place_provider.dart';
import 'add_place.dart';

class PlacesListScreen extends ConsumerWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final places = ref.watch(placesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Places'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: places.isEmpty
          ? const Center(child: Text('No favorite places added yet.'))
          : ListView.builder(
              itemCount: places.length,
              itemBuilder: (ctx, index) {
                final place = places[index];
                return ListTile(
                  title: Text(place.title),
                );
              },
            ),
    );
  }
}
