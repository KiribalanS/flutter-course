import 'package:flutter/material.dart';
import 'package:quiz/questions_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: media.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 95, 24, 194),
              Color.fromARGB(255, 77, 32, 144),
              Color.fromARGB(255, 99, 23, 156),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "lib/assets/image.png",
              width: media.width * 0.8,
            ),
            SizedBox(height: media.height * 0.02),
            const Text(
              "Learning is Fun!!",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 24,
              ),
            ),
            SizedBox(height: media.height * 0.05),
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuestionsScreen(),
                  ),
                );
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              clipBehavior: Clip.hardEdge,
              child: const Text(
                "Lets go",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
