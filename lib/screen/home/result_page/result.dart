import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/screen/home/quiz_questions/quiz_questions.dart';

class ResultScrn extends StatefulWidget {
  const ResultScrn(
      {super.key,
      required this.totalMarks,
      required this.totalPoint,
      required this.totalQuestions});

  final double totalMarks;
  final int totalPoint;
  final int totalQuestions;

  @override
  State<ResultScrn> createState() => _ResultScrnState();
}

String content = '';
Color contentcolor = Colors.white;

class _ResultScrnState extends State<ResultScrn> {
  getFunctions() {
    int per = ((widget.totalQuestions / widget.totalPoint) * 100).toInt();
    if (per == 100) {
      content = 'Excellent';
      contentcolor = Colors.green;
    } else if (per > 75) {
      content = 'Great Job';
      contentcolor = Colors.orange;
    } else if (per <= 75 && per >= 50) {
      content = 'Not bad, keep it up';
      contentcolor = Colors.yellow;
    } else {
      content = 'You can do better';
      contentcolor = Colors.red;
    }
    setState(() {});
  }

  @override
  void initState() {
    getFunctions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 35, left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(3, 3),
                ),
              ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  const Text('RESULT',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  CircularChart(
                    individualMarks: widget.totalPoint.toDouble(),
                    totalMarks: widget.totalMarks,
                  ),
                  Text(
                    content,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: contentcolor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Correct Answers :- ${widget.totalPoint}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Wrong Answers :- ${widget.totalQuestions - widget.totalPoint}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              width: size.width,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const QuestionsScrn()));
                  },
                  child: const Text('Back',
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold))),
            )
          ],
        ),
      ),
    );
  }
}

class CircularChart extends StatelessWidget {
  final double totalMarks;
  final double individualMarks;

  const CircularChart(
      {super.key, required this.individualMarks, required this.totalMarks});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 400,
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(
              color: const Color(0XFF4fa1ca),
              value: individualMarks,
              radius: 50,
              titleStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            PieChartSectionData(
              color: Colors.red.withOpacity(0.2),
              value: totalMarks - individualMarks,
              radius: 50,
              titleStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
