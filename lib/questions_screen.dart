import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:quiz/answer_widget.dart';
import 'package:quiz/data/data.dart';
import 'package:quiz/results_screen.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  late List<String> question;
  late int index;
  @override
  void initState() {
    super.initState();
    index = 0;
    question = questions[index].getShuffeledAnswerList();
  }

  String selectedAnswer = "";
  @override
  Widget build(BuildContext context) {
    const verticalSpace = SizedBox(
      height: 25,
    );
    return Scaffold(
      backgroundColor: const Color.fromARGB(203, 118, 4, 188),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              questions[index].question.toUpperCase(),
              style: GoogleFonts.lato(
                fontSize: 19,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            verticalSpace,
            ...question.map(
              (e) => AnswerWidget(
                answer: e,
                index: index,
                groupName: selectedAnswer,
                onPressed: (val) => setState(() {
                  selectedAnswer = val;
                }),
              ),
            ),
            verticalSpace,
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 7, 3, 105),
                side: const BorderSide(
                  width: 1,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                if (index + 1 < questions.length) {
                  question = questions[index].getShuffeledAnswerList();
                  setState(() {
                    index = index + 1;
                    selectedAnswer = "";
                  });
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ResultsScreen(),
                    ),
                  );
                }
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Next!",
                  style: TextStyle(
                    fontSize: 19,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
