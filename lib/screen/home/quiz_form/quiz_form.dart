import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/model/quiz_model.dart';
import 'package:quiz_app/screen/home/quiz_form/quiz_form_util.dart';
import 'package:quiz_app/widget/widget.dart';

class QuizFormScrn extends StatefulWidget {
  const QuizFormScrn({super.key});

  @override
  State<QuizFormScrn> createState() => _QuizFormScrnState();
}

String? selectedValue = 'Select Point';
List<String> selectedlist = [];

final questionEditingController = TextEditingController();
final answerEditingController = TextEditingController();
final optionEditingController2 = TextEditingController();
final optionEditingController1 = TextEditingController();
final optionEditingController3 = TextEditingController();
final formkey = GlobalKey<FormState>();

class _QuizFormScrnState extends State<QuizFormScrn> {
  @override
  void initState() {
    selectedlist = ['Select Point', '1', '2', '5', '10'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar:
          AppBar(title: const Text('Add Quiz Questions'), centerTitle: true),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                TextFormWidget(
                  controller: questionEditingController,
                  mainlabel: 'Question',
                  label: 'Enter the Question',
                  icon: Icons.add,
                  maxLines: 5,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Your Question";
                    } else {
                      return RegExp(r'[!@#<>?:_`"~;[\]\\|=+)(*&^%0-9-]')
                              .hasMatch(value)
                          ? "Please enter valid questions"
                          : null;
                    }
                  },
                ),
                TextFormWidget(
                  controller: answerEditingController,
                  mainlabel: 'Answer',
                  label: 'Enter the Question answer',
                  icon: Icons.question_answer,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Your Question";
                    } else {
                      return RegExp(r'[!@#<>?:_`"~;[\]\\|=+)(*&^%0-9-]')
                              .hasMatch(value)
                          ? "Please enter valid answer"
                          : null;
                    }
                  },
                ),
                TextFormWidget(
                  controller: optionEditingController1,
                  mainlabel: 'Other Option 1',
                  label: 'Enter the Other Option 1',
                  icon: Icons.question_answer_outlined,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Your other option";
                    } else {
                      return RegExp(r'[!@#<>?:_`"~;[\]\\|=+)(*&^%0-9-]')
                              .hasMatch(value)
                          ? "Please enter valid option"
                          : null;
                    }
                  },
                ),
                TextFormWidget(
                  controller: optionEditingController2,
                  mainlabel: 'Other Option 2',
                  label: 'Enter the Other Option 2',
                  icon: Icons.question_answer_outlined,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Your other option";
                    } else {
                      return RegExp(r'[!@#<>?:_`"~;[\]\\|=+)(*&^%0-9-]')
                              .hasMatch(value)
                          ? "Please enter valid option"
                          : null;
                    }
                  },
                ),
                TextFormWidget(
                  controller: optionEditingController3,
                  mainlabel: 'Other Option 3',
                  label: 'Enter the Other Option 3',
                  icon: Icons.question_answer_outlined,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Your other option";
                    } else {
                      return RegExp(r'[!@#<>?:_`"~;[\]\\|=+)(*&^%0-9-]')
                              .hasMatch(value)
                          ? "Please enter valid option"
                          : null;
                    }
                  },
                ),
                const SizedBox(height: 5),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Select Points',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  width: size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    borderRadius: BorderRadius.circular(10),
                    value: selectedValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue!;
                      });
                    },
                    items: [
                      for (var i in selectedlist)
                        DropdownMenuItem<String>(
                          value: i,
                          child: Text(
                            i,
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        )
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedBtnWidget(
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            int? parsedPoints = int.tryParse(selectedValue!);
                            if (parsedPoints != null) {
                              final model = QuizModel(
                                  question:
                                      questionEditingController.text.trim(),
                                  options: [
                                    answerEditingController.text.trim(),
                                    optionEditingController1.text.trim(),
                                    optionEditingController2.text.trim(),
                                    optionEditingController3.text.trim(),
                                  ],
                                  answer: answerEditingController.text.trim(),
                                  points: parsedPoints);
                              validateQuizFN(model, context);
                            } else {
                              newshowSnackbar(
                                  context,
                                  'Select Point',
                                  'Please select the point',
                                  ContentType.failure);
                            }
                          }
                        },
                        title: "ADD"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
