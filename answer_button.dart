// Importing Flutter's Material Design package to use UI widgets like ElevatedButton
import 'package:flutter/material.dart';

// A custom stateless widget named AnswerButton
// This widget represents a single quiz answer option as a button
class AnswerButton extends StatelessWidget {
  // A string to display as the button's label
  final String answerText;

  // A function that will be executed when the button is tapped
  final void Function() onTap;

  // Constructor for AnswerButton
  // - answerText: the label on the button
  // - onTap: the callback function when the button is pressed
  const AnswerButton({
    super.key,
    required this.answerText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Using an ElevatedButton (a raised material button)
    return ElevatedButton(
      // Assigning the callback function to the button's onPressed property
      onPressed: onTap,

      // Styling the button
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 33, 1, 95), // dark purple background
        foregroundColor: Colors.white, // button text color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40), // rounded corner radius = 40
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 10,   // top & bottom padding
          horizontal: 40, // left & right padding
        ),
      ),

      // Child widget inside the button (the text label)
      child: Text(
        answerText, // the text to display on the button
        style: const TextStyle(fontSize: 16), // text styling with font size 16
      ),
    );
  }
}
