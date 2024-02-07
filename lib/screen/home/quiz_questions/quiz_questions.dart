// ignore_for_file: library_private_types_in_public_api
import 'dart:async';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/db/database.dart';
import 'package:quiz_app/model/quiz_model.dart';
import 'package:quiz_app/screen/home/result_page/result.dart';
import 'package:quiz_app/widget/widget.dart';

class QuestionsScrn extends StatefulWidget {
  const QuestionsScrn({super.key});

  @override
  _QuestionsScrnState createState() => _QuestionsScrnState();
}

class _QuestionsScrnState extends State<QuestionsScrn> {
  int timerDurationInSeconds = 10;
  late Timer timer;
  bool startTimeBool = true;
  List<QuizModel>? questions;
  int questionNumber = 0;
  int selectedContainerIndex = -1;
  bool answerIsselected = false;
  bool islastResult = false;
  @override
  void initState() {
    getlist();
    startTimer();
    super.initState();
  }

  double totalPointPer = 0;
  int totalPoint = 0;
  List<Color> ansColor = List.filled(4, Colors.white);
  String answer = '';
  List<String> options = [];
  void getlist() async {
    answerIsselected = false;
    final questionslist = await DatabaseHive().getQuizQuestions();
    setState(() {
      questions = questionslist;
    });
    if (questions != null) {
      setState(() {
        options = questions![questionNumber].options;
        answer = questions![questionNumber].answer;
        options.shuffle();
      });
    }
  }

  void startTimer() {
    setState(() {
      answerIsselected = false;
      timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
        setState(() {
          if (timerDurationInSeconds > 0) {
            timerDurationInSeconds--;
          } else {
            timer.cancel();
            if (questions != null) {
              if (questions!.length - 1 > questionNumber) {
                questionNumber++;
                setState(() {
                  ansColor = List.filled(4, Colors.white);
                  options = questions![questionNumber].options;
                  answer = questions![questionNumber].answer;
                  options.shuffle();
                });
                timerDurationInSeconds = 10;
                startTimer();
              } else {
                islastResult = true;
                totalPointPer = (totalPoint / questions!.length) * 100;
                setState(() {});
              }
            }
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Questions'),
        centerTitle: true,
      ),
      body: questions == null
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Please Add Questions there is no Questions !',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: size.width,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(3, 3),
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          child: startTimeBool
                              ? Text(
                                  '$timerDurationInSeconds',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )
                              : IconButton(
                                  icon: const Icon(Icons.play_arrow_rounded,
                                      size: 35),
                                  onPressed: () {
                                    if (!startTimeBool) {
                                      setState(() {
                                        startTimeBool = true;
                                        startTimer();
                                      });
                                    }
                                  },
                                ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Question  ${questionNumber + 1}',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 20),
                        Row(
                          children: [
                            const Icon(Icons.quiz_rounded),
                            const SizedBox(width: 10),
                            questions != null &&
                                    questionNumber < questions!.length
                                ? Text(
                                    '${questions![questionNumber].question} ?',
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )
                                : const Text(''),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Column(
                          children: List.generate(
                            4,
                            (index) => GestureDetector(
                              onTap: () {
                                if (answerIsselected == false) {
                                  selectedContainerIndex = index;
                                  ansColor =
                                      List.filled(options.length, Colors.white);
                                  ansColor[index] = Colors.red;

                                  if (answer ==
                                      options[selectedContainerIndex]) {
                                    ansColor[index] = Colors.green;
                                    totalPoint++;
                                  } else {
                                    int correctAnswerIndex =
                                        options.indexOf(answer);

                                    if (correctAnswerIndex != -1) {
                                      ansColor[correctAnswerIndex] =
                                          Colors.green;
                                    }

                                    ansColor[index] = Colors.red;
                                  }
                                  answerIsselected = true;
                                  setState(() {});
                                }
                              },
                              child: OptionWidget(
                                  size: size,
                                  options: options[index],
                                  index: index,
                                  selectedContainerIndex:
                                      selectedContainerIndex,
                                  answercolor: ansColor[index]),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.width,
                          child: ElevatedButton(
                              onPressed: () {
                                print(answer);
                                if (answerIsselected) {
                                  questionNumber++;
                                  if (questions!.length > questionNumber) {
                                    setState(() {
                                      ansColor = List.filled(4, Colors.white);
                                      options =
                                          questions![questionNumber].options;
                                      answer =
                                          questions![questionNumber].answer;
                                      options.shuffle();
                                    });
                                    timerDurationInSeconds = 10;
                                    timer.cancel();
                                    startTimer();
                                  }
                                  if (questionNumber == questions!.length) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ResultScrn(
                                              totalMarks:
                                                  questions!.length.toDouble(),
                                              totalPoint: totalPoint,
                                              totalQuestions:
                                                  questions!.length),
                                        ));
                                  }
                                } else {
                                  newshowSnackbar(
                                      context,
                                      'Select Option',
                                      'Please select the above options',
                                      ContentType.failure);
                                }
                              },
                              child: questionNumber == questions!.length - 1
                                  ? const Text('Submit',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold))
                                  : const Text('Next',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold))),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}

class OptionWidget extends StatelessWidget {
  const OptionWidget({
    super.key,
    required this.size,
    required this.options,
    required this.selectedContainerIndex,
    required this.index,
    this.answercolor,
  });
  final int selectedContainerIndex;
  final Size size;
  final String options;
  final int index;
  final Color? answercolor;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: size.width,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(3, 3),
            ),
          ], color: answercolor, borderRadius: BorderRadius.circular(10)),
          child: Text(
            options,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 17,
            ),
          ),
        ),
        const SizedBox(height: 10)
      ],
    );
  }
}
