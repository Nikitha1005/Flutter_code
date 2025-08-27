// Import Flutter Material Design package
import 'package:flutter/material.dart';

// Import the quiz questions (data source)
import 'questions.dart';

// Import the custom AnswerButton widget
import 'answer_button.dart';

// Import Google Fonts for custom text styling
import 'package:google_fonts/google_fonts.dart';

// Stateful widget because the screen needs to update 
// as the user navigates through questions
class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

// State class that handles the logic for QuestionsScreen
class _QuestionsScreenState extends State<QuestionsScreen> {
  // Keeps track of which question is currently displayed
  var currentQuestionIndex = 0;

  // Function called when the user selects an answer
  void answerQuestion() {
    setState(() {
      // Move to the next question by increasing the index
      currentQuestionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get the current question object using the index
    final currentQuestion = questions[currentQuestionIndex];

    return SizedBox(
      width: double.infinity, // make widget take full width
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // center vertically
        children: [
          // Display the question text
          Text(
            currentQuestion.text, // question string
            style: GoogleFonts.lato(
              color: Colors.white,        // text color
              fontSize: 24,               // font size
              fontWeight: FontWeight.bold, // bold text
            ),
            textAlign: TextAlign.center, // center-align text
          ),

          const SizedBox(height: 30), // space between question and answers

          // 4 Answer buttons for the current question
          // Each button displays one answer and calls answerQuestion when tapped
          AnswerButton(
            answerText: currentQuestion.answers[0],
            onTap: answerQuestion,
          ),
          AnswerButton(
            answerText: currentQuestion.answers[1],
            onTap: answerQuestion,
          ),
          AnswerButton(
            answerText: currentQuestion.answers[2],
            onTap: answerQuestion,
          ),
          AnswerButton(
            answerText: currentQuestion.answers[3],
            onTap: answerQuestion,
          ),
        ],
      ),
    );
  }
}
