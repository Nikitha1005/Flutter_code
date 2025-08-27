import 'package:flutter/material.dart';
import '../expenses.dart';
import 'expenses1.dart';

class ChartBar extends StatelessWidget {
  final double
  fill; // Represents how "full" the bar should be (range 0.0 to 1.0)
  final Category
  category; // The category this bar represents (e.g., Food, Travel)

  const ChartBar({super.key, required this.fill, required this.category});

  @override
  Widget build(BuildContext context) {
    // Access the current app theme (light or dark mode colors, fonts, etc.)
    final theme = Theme.of(context);

    // Detect if the device is currently in dark mode
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    // Choose the bar's color depending on the theme
    final barColor =
        isDarkMode ? theme.colorScheme.secondary : theme.colorScheme.primary;

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end, // Align bars to bottom
        children: [
          // FractionallySizedBox makes the bar height relative to "fill" (0.0–1.0)
          FractionallySizedBox(
            heightFactor: fill, // Controls how tall the bar is
            child: Container(
              decoration: BoxDecoration(
                color: barColor, // Dynamic color depending on theme
                borderRadius: BorderRadius.circular(6), // Rounded edges
              ),
            ),
          ),
          const SizedBox(height: 4), // Small gap between bar and icon
          // Display the category icon below the bar
          Icon(
            categoryIcons[category], // Get the matching icon for this category
            size: 20, // Small icon size
            color:
                theme.colorScheme.onBackground, // Matches background contrast
          ),
        ],
      ),
    );
  }
}
