import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_app/firebase/fb_store_controller.dart';
import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/screens/score_screen.dart';
import 'package:quiz_app/widgets/custom_option_card.dart';
import 'package:quiz_app/widgets/custom_text.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key, this.studentName});

  final String? studentName;

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  late PageController _pageController;
  int _currentPage = 0;
  int userScore = 0; // Initialize userScore to keep track of the score
  List<Question> quizQuestions = [];
  Set<int> askedQuestionIndices = {};

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    fetchAndShuffleQuestions();
  }



  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          child: quizQuestions.isNotEmpty
              ? Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                        physics: const ClampingScrollPhysics(),
                        controller: _pageController,
                        onPageChanged: (int current) {
                          setState(() {
                            _currentPage = current;
                          });
                        },
                        itemCount: quizQuestions.length,
                        itemBuilder: (context, index) {
                          final currentQuestion = quizQuestions[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: 'Question ${index + 1} out of ${quizQuestions.length}',
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                colorText: Colors.black45,
                              ),
                              SizedBox(height: 20.h),
                              const CustomText(
                                text:
                                    'Choose the correct answer. Is this word a verb, noun, adjective, or adverb?',
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              CustomText(
                                text: currentQuestion.word,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                colorText: Colors.black45,
                              ),
                              SizedBox(height: 20.h),
                              Column(
                                children: [
                                  CustomOptionCard(
                                    textOption: 'verb',
                                    colorOption:  Colors.white10,
                                    onPressed: () {
                                      handleAnswerSelection(0);
                                    },
                                  ),
                                  CustomOptionCard(
                                    textOption: 'noun',
                                    colorOption:  Colors.white10,
                                    onPressed: () {
                                      handleAnswerSelection(1);
                                    },
                                  ),
                                  CustomOptionCard(
                                    textOption: 'adjective',
                                    colorOption:  Colors.white10,
                                    onPressed: () {
                                      handleAnswerSelection(2);
                                    },
                                  ),
                                  CustomOptionCard(
                                    textOption: 'adverb',
                                    colorOption:  Colors.white10,
                                    onPressed: () {
                                      handleAnswerSelection(3);
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.h),
                            ],
                          );
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_currentPage == quizQuestions.length - 1) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ScoreScreen(userScore: userScore),
                              ));
                        }
                        _pageController.nextPage(
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeInOut,
                        );
                        setState(() {
                          userScore;
                        });
                      },
                      child: Text(_currentPage == quizQuestions.length - 1
                          ? 'Finish Quiz'
                          : 'Next Question'),
                    ),
                    SizedBox(height: 20.h),
                    Text('Score: $userScore',
                        style: const TextStyle(fontSize: 20)),
                  ],
                )
              : const Center(
                  child:
                      CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }

  void fetchAndShuffleQuestions() async {
    try {
      final questionsSnapshot = await FbStoreController().read().first;

      if (questionsSnapshot.docs.isNotEmpty) {
        final fetchedQuestions = questionsSnapshot.docs.map((doc) {
          return Question.fromMap(doc.data().toMap());
        }).toList();

        // Shuffle the questions
        fetchedQuestions.shuffle();

        // Select the first 5 questions (assuming you have at least 5 questions)
        quizQuestions = fetchedQuestions.sublist(0, 5);

        setState(() {
          askedQuestionIndices.clear();
          userScore = 0; // Reset userScore for a new quiz session
        });
      } else {
        // Handle the case where there are no questions in the Firestore collection.
      }
    } catch (e) {
      // Handle any errors that occur during data retrieval.
      print('Error fetching questions: $e');
    }
  }

  void handleAnswerSelection(int selectedOptionIndex) {
    final currentQuestion = quizQuestions[_currentPage];
    final selectedPartOfSpeech = _getSelectedPartOfSpeech(selectedOptionIndex);
    final actualPartOfSpeech = currentQuestion.pos;
     final bool isCorrectAnswer = selectedPartOfSpeech == actualPartOfSpeech;
    if (isCorrectAnswer) {
      // Award 10 points for a correct answer
      setState(() {
        userScore += 10;
      });
    }

    askedQuestionIndices.add(_currentPage);

    if (askedQuestionIndices.length == 5) {
      // End of quiz, you can navigate to the results screen or perform any other actions.
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ScoreScreen(userScore: userScore),
          ));
    } else {
      // Move to the next question
      _pageController.nextPage(
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  String _getSelectedPartOfSpeech(int selectedOptionIndex) {
    switch (selectedOptionIndex) {
      case 0:
        return 'verb';
      case 1:
        return 'noun';
      case 2:
        return 'adjective';
      case 3:
        return 'adverb';
      default:
        return '';
    }
  }
}
