// Import Flutter Material Design package
import 'package:flutter/material.dart';

// Import your custom screens and data
import 'start_screen.dart'; // Starting screen
import 'question_screen.dart'; // Question screen
import 'ResultScreen.dart'; // Results screen
import 'questions.dart'; // Questions data

// The main Quiz widget → Stateful because the UI changes dynamically
class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

// The state class for Quiz widget (handles screen changes & quiz logic)
class _QuizState extends State<Quiz> {
  // Stores all answers selected by the user
  List<String> selectedAnswers = [];

  // Keeps track of which screen is currently active
  var activeScreen = 'start-screen';

  // Function to switch from start screen → question screen
  void switchScreen() {
    setState(() {
      activeScreen = 'questions-screen';
    });
  }

  // Function called when user selects an answer
  void chooseAnswer(String answer) {
    // Add selected answer into the list
    selectedAnswers.add(answer);

    // If user has answered all questions → switch to results screen
    if (selectedAnswers.length == questions.length) {
      setState(() {
        activeScreen = 'results-screen';
      });
    }
  }

  // Function to restart quiz (reset answers & go back to start screen)
  void restartQuiz() {
    setState(() {
      selectedAnswers = []; // clear old answers
      activeScreen = 'start-screen'; // reset screen
    });
  }

  @override
  Widget build(BuildContext context) {
    // Default screen = Start Screen
    Widget screenWidget = StartScreen(startQuiz: switchScreen);

    // If activeScreen = questions, load the QuestionsScreen
    if (activeScreen == 'questions-screen') {
      screenWidget = QuestionsScreen(onSelectAnswer: chooseAnswer);
    }

    // If activeScreen = results, load the ResultsScreen
    if (activeScreen == 'results-screen') {
      screenWidget = ResultsScreen(
        chosenAnswers: selectedAnswers, // pass selected answers
        onRestart: restartQuiz, // pass restart function
      );
    }

    // Return overall app structure
    return MaterialApp(
      home: Scaffold(
        body: Container(
          // Background gradient for the app
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 78, 13, 151), // dark purple
                Color.fromARGB(255, 107, 15, 168), // lighter purple
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          // Display whichever screen is currently active
          child: screenWidget,
        ),
      ),
    );
  }
}
