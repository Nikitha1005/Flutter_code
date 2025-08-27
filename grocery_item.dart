// Import the Category enum/model so we can assign
// each grocery item to a category (fruits, dairy, etc.)
import 'Category.dart';

// Model class that represents a single Grocery Item
class GroceryItem {
  // A unique identifier for each item (e.g., "i1", "i2")
  final String id;

  // Name of the grocery item (e.g., "Milk", "Apple")
  final String name;

  // Category (enum) that specifies the group (fruits, bakery, etc.)
  final Category category;

  // Quantity of the item (e.g., 2 Milk cartons, 5 Apples)
  final int quantity;

  // Price of the item (could be per unit or total cost, depending on usage)
  final double price;

  // Constructor to initialize all fields
  GroceryItem({
    required this.id,
    required this.name,
    required this.category,
    required this.quantity,
    required this.price,
  });
}
