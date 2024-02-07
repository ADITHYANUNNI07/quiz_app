import 'package:flutter/material.dart';
import 'package:quiz_app/db/database.dart';
import 'package:quiz_app/model/quiz_model.dart';

void validateQuizFN(QuizModel quizModel, BuildContext context) {
  DatabaseHive().addQuestionsToHive(quizModel, context);
}
