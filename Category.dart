// Import Flutter Material UI package (needed for Color class)
import 'package:flutter/material.dart';

// Enum to represent different categories in the app
// Enums provide a fixed set of constant values
enum Category {
  fruits,
  vegetables,
  dairy,
  meat,
  bakery,
  beverages,
}

// A model class to represent each category with extra details
class CategoryModel {
  // The category type (from enum)
  final Category category;

  // Display title for the category (e.g., "Fruits")
  final String title;

  // A color associated with the category (for UI display)
  final Color color;

  // Constructor to initialize all fields
  const CategoryModel({
    required this.category,
    required this.title,
    required this.color,
  });
}

// A constant list of categories (CATEGORY_LIST)
// Each item is a CategoryModel instance
// Can be used to populate category UI (like Grid/List)
const CATEGORY_LIST = [
  CategoryModel(
    category: Category.fruits,
    title: 'Fruits',
    color: Colors.red,
  ),
  CategoryModel(
    category: Category.vegetables,
    title: 'Vegetables',
    color: Colors.green,
  ),
  CategoryModel(
    category: Category.dairy,
    title: 'Dairy',
    color: Colors.blue,
  ),
  CategoryModel(
    category: Category.meat,
    title: 'Meat',
    color: Colors.brown,
  ),
  CategoryModel(
    category: Category.bakery,
    title: 'Bakery',
    color: Colors.orange,
  ),
  CategoryModel(
    category: Category.beverages,
    title: 'Beverages',
    color: Colors.purple,
  ),
];
