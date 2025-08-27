// Import Flutter's Material UI package
import 'package:flutter/material.dart';

// Import Google Fonts package for custom text styling
import 'package:google_fonts/google_fonts.dart';

// A stateless widget that represents the starting screen of the quiz app
class StartScreen extends StatelessWidget {
  // A callback function that will be called when the "Start Quiz" button is pressed
  final VoidCallback startQuiz;

  // Constructor for StartScreen
  // - startQuiz is passed from the parent (QuizApp) so this screen can tell
  //   the app to switch to the question screen
  const StartScreen({super.key, required this.startQuiz});

  @override
  Widget build(BuildContext context) {
    return Center(
      // Center widget puts its child (Column) in the middle of the screen
      child: Column(
        // Column arranges its children vertically
        mainAxisSize: MainAxisSize.min, 
        // min → Column takes only as much vertical space as its children need
        children: [
          // A title text shown at the top of the start screen
          Text(
            'Learn the fun way!',
            style: GoogleFonts.poppins(
              color: Colors.white,        // white text color
              fontSize: 24,               // font size
              fontWeight: FontWeight.w600, // semi-bold
            ),
          ),

          // A SizedBox for spacing between the title and button
          const SizedBox(height: 30),

          // A button with an icon and label → "Start Quiz"
          OutlinedButton.icon(
            // When button is pressed, the startQuiz callback is executed
            onPressed: startQuiz,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,              // text + icon color
              side: const BorderSide(color: Colors.white), // white border
            ),
            icon: const Icon(Icons.arrow_right_alt), // arrow icon
            label: const Text('Start Quiz'),         // button label
          ),
        ],
      ),
    );
  }
}
