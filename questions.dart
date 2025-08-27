// questions.dart

// A model class representing a single quiz question
class QuizQuestion {
  // The question text (e.g., "What is Flutter?")
  final String text;

  // A list of possible answers (first one is always the correct answer)
  final List<String> answers;

  // Constructor to initialize text and answers
  const QuizQuestion(this.text, this.answers);

  /// Returns a shuffled *copy* of the answers list
  /// - Original list order remains unchanged
  /// - Ensures that correct answer position is randomized each time
  List<String> getShuffledAnswers() {
    // Create a copy of the answers list
    final shuffledList = List.of(answers);

    // Randomly shuffle the copy
    shuffledList.shuffle();

    // Return the randomized list
    return shuffledList;
  }
}

// A constant list of quiz questions
// Using `final` so we can still have non-const inner lists
final List<QuizQuestion> questions = [
  // Question 1
  QuizQuestion(
    'What are the main building blocks of Flutter UIs?', [
      'Widgets',    // ✅ Correct answer
      'Components',
      'Blocks',
      'Functions',
    ],
  ),

  // Question 2
  QuizQuestion(
    'Which programming language is used by Flutter?', [
      'Dart',       // ✅ Correct answer
      'Kotlin',
      'Swift',
      'Java',
    ],
  ),

  // Question 3
  QuizQuestion(
    'Who developed Flutter?', [
      'Google',     // ✅ Correct answer
      'Apple',
      'Microsoft',
      'Facebook',
    ],
  ),
];
