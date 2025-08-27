// Import GroceryItem model (represents an item in the grocery list)
import '../grocery_item.dart';

// Import Category enum (to assign each item to a category)
import '../Category.dart';

// Dummy data for testing / prototyping
// Instead of fetching from a database or API,
// we use a predefined list of items (hardcoded).
final DUMMY_ITEMS = [
  GroceryItem(
    id: 'i1',                  // Unique ID for the item
    name: 'Apple',             // Item name
    category: Category.fruits, // Belongs to fruits category
    quantity: 5,               // Number of apples
    price: 3.5,                // Price per unit / total price
  ),
  GroceryItem(
    id: 'i2',
    name: 'Milk',
    category: Category.dairy,  // Belongs to dairy category
    quantity: 2,
    price: 2.0,
  ),
  GroceryItem(
    id: 'i3',
    name: 'Bread',
    category: Category.bakery, // Belongs to bakery category
    quantity: 1,
    price: 1.5,
  ),
  GroceryItem(
    id: 'i4',
    name: 'Carrot',
    category: Category.vegetables, // Belongs to vegetables category
    quantity: 10,
    price: 4.0,
  ),
  GroceryItem(
    id: 'i5',
    name: 'Orange Juice',
    category: Category.beverages,  // Belongs to beverages category
    quantity: 3,
    price: 5.0,
  ),
];
