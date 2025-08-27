// Import Flutter Material UI package
import 'package:flutter/material.dart';

// A stateless widget that displays a detailed summary of all quiz questions
class QuestionsSummary extends StatelessWidget {
  // List of summary data passed from ResultsScreen
  // Each map contains: question_index, question, correct_answer, user_answer
  final List<Map<String, Object>> summaryData;

  // Constructor to receive the summaryData
  const QuestionsSummary(this.summaryData, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // align left
      children:
          // Loop through each item in summaryData and build a widget for it
          summaryData.map((data) {
            // Extract values from map for easier usage
            final questionIndex = (data['question_index'] as int) + 1; // +1 for display
            final questionText = data['question'] as String;
            final correctAnswer = data['correct_answer'] as String;
            final userAnswer = data['user_answer'] as String;
            final isCorrect = userAnswer == correctAnswer; // check if user is correct

            // Each row shows question number and its details
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Display question number
                Text(
                  '$questionIndex. ',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                // Expanded so text wraps nicely and doesn't overflow
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Display the question text
                      Text(
                        questionText,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 5),

                      // Display user's answer → green if correct, red if wrong
                      Text(
                        'Your answer: $userAnswer',
                        style: TextStyle(
                          color: isCorrect ? Colors.green : Colors.red,
                        ),
                      ),

                      // Display the correct answer (always white text)
                      Text(
                        'Correct answer: $correctAnswer',
                        style: const TextStyle(color: Colors.white),
                      ),

                      const SizedBox(height: 10), // spacing after each question
                    ],
                  ),
                ),
              ],
            );
          }).toList(), // Convert map results into a list of widgets
    );
  }
}
