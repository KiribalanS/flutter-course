// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:quiz/data/data.dart';
import 'package:quiz/models/question_model.dart';
import 'package:quiz/startscreen.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    int correctAnswers = 0;
    final media = MediaQuery.of(context).size;
    for (var i = 0; i < questions.length; i++) {
      if (questions[i].answer[0] == userAnswers[i]) {
        correctAnswers++;
      }
    }
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 78, 10, 214),
      // appBar: AppBar(
      //   title: Text("Results!!"),
      //   backgroundColor: Colors.transparent,
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisSize: MainAxisSize.max,
          children: [
            RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
                children: [
                  TextSpan(text: "You Scored : "),
                  TextSpan(text: correctAnswers.toString()),
                  TextSpan(text: " out of "),
                  TextSpan(text: questions.length.toString()),
                  TextSpan(text: " correctly!"),
                ],
              ),
            ),
            SizedBox(height: media.height * 0.05),
            ListView.builder(
              shrinkWrap: true,
              itemCount: questions.length,
              itemBuilder: (context, index) => resultWidget(
                questions[index],
                index,
                Color.fromARGB(255, 37, 207, 207),
              ),
            ),
            SizedBox(height: media.height * 0.05),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                ),
                onPressed: () {
                  userAnswers = ["", "", "", "", ""];

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StartScreen(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.refresh,
                        color: Colors.white,
                        size: 30,
                      ),
                      Text(
                        "  Restart Quiz",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget resultWidget(QuestionModel question, int index, Color color) {
    bool isCorrect = question.answer[0] == userAnswers[index];
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 24,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor:
                isCorrect ? color : const Color.fromARGB(255, 178, 68, 60),
            child: Text((index + 1).toString()),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.white),
                children: [
                  TextSpan(
                    text: "${question.question.toUpperCase()}\n",
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: "Your Answer : ",
                    style: TextStyle(
                        height: 2, color: Colors.white70, fontSize: 18),
                  ),
                  TextSpan(
                    text: "${userAnswers[index].toUpperCase()}\n",
                    style: TextStyle(
                      color: isCorrect
                          ? color
                          : const Color.fromARGB(255, 178, 68, 60),
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: "Correct Answer : ",
                    style: TextStyle(color: Colors.white70, fontSize: 18),
                  ),
                  TextSpan(
                    text: question.answer[0].toUpperCase(),
                    style: TextStyle(
                      color: color,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
