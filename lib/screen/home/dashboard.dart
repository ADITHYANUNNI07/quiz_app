import 'package:flutter/material.dart';
import 'package:quiz_app/screen/home/quiz_form/quiz_form.dart';
import 'package:quiz_app/screen/home/quiz_questions/quiz_questions.dart';

class DashboardScrn extends StatefulWidget {
  const DashboardScrn({super.key});

  @override
  State<DashboardScrn> createState() => _DashboardScrnState();
}

int currentIndex = 0;

List<Widget> pages = [];

class _DashboardScrnState extends State<DashboardScrn> {
  @override
  void initState() {
    pages = [const QuestionsScrn(), const QuizFormScrn()];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 18.0, left: 10, right: 10),
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.01),
                  blurRadius: 25,
                  offset: const Offset(8, 5))
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BottomNavigationBar(
                backgroundColor: Colors.transparent,
                selectedItemColor: const Color(0XFF4fa1ca),
                unselectedItemColor: Colors.black,
                currentIndex: currentIndex,
                onTap: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.quiz), label: "Questions"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.add_to_queue_outlined),
                      label: "Add Questions"),
                ]),
          ),
        ),
      ),
      body: pages[currentIndex],
    );
  }
}
