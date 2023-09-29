import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_app/firebase/fb_store_controller.dart';
import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/models/quiz_result.dart';
import 'package:quiz_app/screens/score_screen.dart';
import 'package:quiz_app/utils/context_extenssion.dart';
import 'package:quiz_app/widgets/custom_elevated_buttom.dart';
import 'package:quiz_app/widgets/custom_text.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key, this.userName});

  final String? userName;

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  late PageController _pageController;
  int _currentPage = 0;
  int userScore = 0;
  List<int?> selectedAnswers =
      List.filled(5, null); // List to store selected answers

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
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
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
                              Center(
                                child: CustomText(
                                  text:
                                      'Question ${index + 1} out of ${quizQuestions.length}',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  colorText: Colors.black45,
                                ),
                              ),
                              SizedBox(height: 20.h),
                              const CustomText(
                                text:
                                    'Choose the correct answer. Is this word a verb, noun, adjective, or adverb?',
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.lightBlueAccent,
                                  ),
                                  width: 200.w,
                                  height: 40,
                                  child: Center(
                                    child: CustomText(
                                      text: currentQuestion.word,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      colorText: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.h),
                              Column(
                                children: [
                                  // Use Radio buttons to select answers
                                  // Store the selected answer in selectedAnswers list
                                  RadioListTile<int?>(
                                    title: const CustomText(text: 'verb'),
                                    value: 0,
                                    groupValue: selectedAnswers[index],
                                    onChanged: (int? value) {
                                      setState(() {
                                        selectedAnswers[index] = value;
                                      });
                                    },
                                  ),
                                  RadioListTile<int?>(
                                    title: const CustomText(text: 'noun'),
                                    value: 1,
                                    groupValue: selectedAnswers[index],
                                    onChanged: (int? value) {
                                      setState(() {
                                        selectedAnswers[index] = value;
                                      });
                                    },
                                  ),
                                  RadioListTile<int?>(
                                    title: const CustomText(text: 'adjective'),
                                    value: 2,
                                    groupValue: selectedAnswers[index],
                                    onChanged: (int? value) {
                                      setState(() {
                                        selectedAnswers[index] = value;
                                      });
                                    },
                                  ),
                                  RadioListTile<int?>(
                                    title: const CustomText(text: 'adverb'),
                                    value: 3,
                                    groupValue: selectedAnswers[index],
                                    onChanged: (int? value) {
                                      setState(() {
                                        selectedAnswers[index] = value;
                                      });
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
                    CustomElevatedButton(
                        onPressed: () {
                          if (_currentPage == quizQuestions.length - 1) {
                            _pref();
                          } else {
                            _pageController.nextPage(
                              duration: const Duration(seconds: 1),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        textButton: _currentPage == quizQuestions.length - 1
                            ? 'Finish Quiz'
                            : 'Next Question'),
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
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
    }
  }

  void _pref() {
    if (_checkData()) {
      _calculateScore();
      _save();
    }
  }

  void _calculateScore() {
    for (int i = 0; i < quizQuestions.length; i++) {
      final currentQuestion = quizQuestions[i];
      final selectedAnswer = selectedAnswers[i];
      if (selectedAnswer != null) {
        final selectedPartOfSpeech = _getSelectedPartOfSpeech(selectedAnswer);
        final actualPartOfSpeech = currentQuestion.pos;
        final bool isCorrectAnswer = selectedPartOfSpeech == actualPartOfSpeech;
        if (isCorrectAnswer) {
          // Award 10 points for a correct answer
          setState(() {
            userScore += 10;
          });
        }
      }
    }
  }

  String _getSelectedPartOfSpeech(int selectedAnswer) {
    switch (selectedAnswer) {
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

  bool _checkData() {
    if (widget.userName!.isNotEmpty) {
      return true;
    }
    context.showSnackBar(message: 'Input is empty!', error: false);
    return false;
  }

  void _save() async {
    await FbStoreController().createQuizResult(result);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ScoreScreen(userScore: userScore, userName: widget.userName!),
        ));
  }

  QuizResult get result {
    QuizResult quizResult = QuizResult();
    quizResult.name = widget.userName!;
    quizResult.score = userScore;
    return quizResult;
  }
}
