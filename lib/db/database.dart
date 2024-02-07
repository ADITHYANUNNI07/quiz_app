// ignore_for_file: use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:quiz_app/model/quiz_model.dart';
import 'package:quiz_app/widget/widget.dart';

Future<void> initalizeHiveandAdapter() async {
  Hive.registerAdapter<QuizModel>(QuizModelAdapter());
  await Hive.openBox<QuizModel>('QuizDBHive');
}

class DatabaseHive {
  Future<void> addQuestionsToHive(
      QuizModel quizModel, BuildContext context) async {
    final box = await Hive.openBox<QuizModel>('QuizDBHive');

    try {
      final index = await box.add(quizModel);

      if (index >= 0) {
        print('quizModel added at index: $index');
        newshowSnackbar(context, 'Question Added',
            'Questions added successfully', ContentType.success);
      } else {
        print('Failed to add quizModel  to the box');
      }
    } catch (e) {
      print('Error while adding quizModel: $e');
    }
  }

  Future<List<QuizModel>?> getQuizQuestions() async {
    final quizModelBox = await Hive.openBox<QuizModel>('QuizDBHive');
    final List<QuizModel> quizmodelList = quizModelBox.values.toList();
    if (quizmodelList.isEmpty) {
      return null;
    } else {
      return quizmodelList;
    }
  }
}
