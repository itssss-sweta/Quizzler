import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quiz_bran.dart';

QuizBrain quizBrain = QuizBrain();

void main() {
  runApp(
    const Quizzler(),
  );
}

class Quizzler extends StatelessWidget {
  const Quizzler({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const Scaffold(
        body: SafeArea(
          child: QuizPage(),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getQuestionAnswer();

    setState(
      () {
        if (quizBrain.isFinished() == true) {
          Alert(
                  context: context,
                  title: 'Finished',
                  desc: 'You\'ve reached the end of the quiz.')
              .show();

          quizBrain.reset();

          scoreKeeper = [];
        } else {
          if (userPickedAnswer == correctAnswer) {
            scoreKeeper.add(Icon(
              Icons.check,
              color: Colors.green,
            ));
          } else {
            scoreKeeper.add(Icon(
              Icons.close,
              color: Colors.red,
            ));
          }
          quizBrain.nextQuestion();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Center(
            child: TextButton(
              onPressed: () {},
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          padding: const EdgeInsets.all(5),
          color: Colors.green,
          child: TextButton(
            onPressed: () {
              checkAnswer(true);
            },
            child: const Text(
              'True',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          padding: const EdgeInsets.all(5),
          color: Colors.red,
          child: TextButton(
            onPressed: () {
              checkAnswer(false);
            },
            child: const Text(
              'False',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}
