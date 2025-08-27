// Import Flutter Material Design package
import 'package:flutter/material.dart';

// Import Google Fonts for custom text styles
import 'package:google_fonts/google_fonts.dart';

// Import the QuestionsSummary widget (displays detailed results)
import 'questionsummary.dart';

// Import the list of questions (to check answers)
import 'questions.dart';

// A stateless widget → since results are final (no internal state to update)
class ResultsScreen extends StatelessWidget {
  // List of answers chosen by the user (passed from Quiz.dart)
  final List<String> chosenAnswers;

  // Callback function to restart the quiz
  final VoidCallback restartQuiz;

  // Constructor: requires both chosenAnswers and restartQuiz
  const ResultsScreen({
    super.key,
    required this.chosenAnswers,
    required this.restartQuiz,
  });

  // Helper function to prepare summary data for each question
  // Returns a list of maps (one per question)
  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    // Loop through all answers chosen by user
    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add({
        'question_index': i,             // question number
        'question': questions[i].text,   // actual question text
        'correct_answer': questions[i].answers[0], // correct answer (always 1st in list)
        'user_answer': chosenAnswers[i], // what the user selected
      });
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    // Generate summary data
    final summaryData = getSummaryData();

    // Count number of correct answers (compare user vs correct answer)
    final numCorrect = summaryData
        .where((data) => data['user_answer'] == data['correct_answer'])
        .length;

    return Center(
      child: Container(
        margin: const EdgeInsets.all(20), // spacing around container
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // center vertically
          children: [
            // Show final result text
            Text(
              'You answered $numCorrect out of ${questions.length} questions correctly!',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),

            // Scrollable summary list of each question & answer
            Expanded(
              child: SingleChildScrollView(
                child: QuestionsSummary(summaryData),
              ),
            ),

            const SizedBox(height: 20),

            // Restart button → calls restartQuiz when pressed
            TextButton(
              onPressed: restartQuiz,
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromARGB(255, 33, 1, 95),
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 30,
                ),
              ),
              child: Text(
                'Restart Quiz!',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
