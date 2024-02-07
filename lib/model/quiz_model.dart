import 'package:hive/hive.dart';
part 'quiz_model.g.dart';

@HiveType(typeId: 1)
class QuizModel {
  @HiveField(0)
  final String question;
  @HiveField(1)
  final List<String> options;
  @HiveField(2)
  final int points;
  @HiveField(3)
  final String answer;
  QuizModel({
    required this.question,
    required this.options,
    required this.points,
    required this.answer,
  });
}
