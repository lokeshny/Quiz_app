import 'package:flutter/material.dart';

import 'model/questions.dart';

class QuizeApp extends StatefulWidget {
  const QuizeApp({Key? key}) : super(key: key);

  @override
  State<QuizeApp> createState() => _QuizeAppState();
}

class _QuizeAppState extends State<QuizeApp> {
  int _currentQuestionIndex = 0;

  List questionBank = [
    Question.name("The india's independence declaration was on 1947", true),
    Question.name("National emblem of india is Ashoka chakra", true),
    Question.name("National animal of india is elephant", false),
    Question.name("Indian currency is Dollar", false),
    Question.name("First PM of India is Javahar lal neharu", true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Helo to quize app"),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Image.asset(
                  "images/Flag_of_India.png",
                  width: 250,
                  height: 180,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                height: 130,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadius.circular(14.5),
                        border: Border.all(
                            color: Colors.blueGrey.shade400,
                            style: BorderStyle.solid)),
                    child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            questionBank[_currentQuestionIndex].questionText,
                            /*style: const TextStyle(
                          fontStyle: FontStyle.italic,
                         fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),*/
                          ),
                        )),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => _previousQuestion(),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                ElevatedButton(
                    onPressed: () => _checkAnswer(true, context),
                    child: Text("TRUE")),
                ElevatedButton(
                    onPressed: () => _checkAnswer(false, context),
                    child: Text("FALSE")),
                ElevatedButton(
                  onPressed: () => _nextQuestion(),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _nextQuestion() {
    _updateQuestion();
  }

  _checkAnswer(bool userChoice, BuildContext context) {
    if (userChoice == questionBank[_currentQuestionIndex].isCorrect) {
      const snackBar = SnackBar(
          backgroundColor: Colors.green,
          duration: Duration(milliseconds: 500),
          content: Text("Correct"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      _updateQuestion();
    } else {
      const snackBar = SnackBar(
          backgroundColor: Colors.red,
          duration: Duration(milliseconds: 500),
          content: Text("Incorrect"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      _updateQuestion();
    }
  }

  _updateQuestion() {
    setState(() {
      _currentQuestionIndex = (_currentQuestionIndex + 1) % questionBank.length;
    });
  }

  _previousQuestion() {
    setState(() {
      _currentQuestionIndex = (_currentQuestionIndex - 1) % questionBank.length;
    });
  }
}