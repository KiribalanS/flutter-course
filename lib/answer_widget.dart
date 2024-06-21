import 'package:flutter/material.dart';
import 'package:quiz/data/data.dart';

class AnswerWidget extends StatefulWidget {
  const AnswerWidget({
    required this.answer,
    required this.index,
    required this.groupName,
    required this.onPressed,
    super.key,
  });
  final String answer;
  final int index;
  final Function(String) onPressed;
  final String groupName;

  @override
  State<AnswerWidget> createState() => _AnswerWidgetState();
}

class _AnswerWidgetState extends State<AnswerWidget> {
  var color = const Color.fromARGB(255, 7, 3, 105);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          // changeColor();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
        ),
        child: Column(
          children: [
            RadioListTile<String>(
              title: Text(
                widget.answer.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 20,
                ),
              ),
              value: widget.answer,
              groupValue: widget.groupName,
              onChanged: (String? value) {
                setState(() {
                  widget.onPressed(value ?? "");
                });
                userAnswers[widget.index] = value ?? "";
              },
            ),
          ],
        ),
      ),
    );
  }
}
