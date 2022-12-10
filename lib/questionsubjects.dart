import 'package:flutter/material.dart';

class QuestionSub extends StatefulWidget {
  const QuestionSub({super.key});

  @override
  State<QuestionSub> createState() => _QuestionSubState();
}

class _QuestionSubState extends State<QuestionSub> {
  List<String> subjects = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MCQ Subjects"),
      ),
      body: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, position) {
            return Card(
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: ListTile(
                  title: Text("Rajasthan History"),
                  leading: Icon(Icons.note),
                  trailing: Icon(Icons.arrow_forward),
                ),
              ),
            );
          }),
    );
  }
}
