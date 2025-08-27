import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

// Generate unique IDs
final uuid = Uuid();

// Categories enum
enum Category { food, travel, leisure, work }

// Map categories to icons
const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  // Getter for formatted date
  String get formattedDate {
    final formatter = DateFormat.yMd();
    return formatter.format(date);
  }
}
