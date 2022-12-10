import 'package:flutter/material.dart';

class UpcomingQuiz extends StatefulWidget {
  const UpcomingQuiz({super.key});

  @override
  State<UpcomingQuiz> createState() => _UpcomingQuizState();
}

class _UpcomingQuizState extends State<UpcomingQuiz> {
  final TextEditingController question = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Upcoming Quiz Topic")),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(children: [
          Card(
            color: Colors.white,
            child: SizedBox(
              height: 60,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: TextFormField(
                  controller: question,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      label: Text("Examname"),
                      hintText: "Enter Exam Name"),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          MaterialButton(
            onPressed: () {
              String chaptername = question.text;
              sendtoserver(chaptername);
            },
            child: Card(
              color: Color.fromARGB(255, 0, 122, 138),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: Center(
                    child: Text(
                  "Submit Topic",
                  style: TextStyle(color: Colors.white),
                )),
              ),
            ),
          )
        ]),
      ),
    );
  }

  void sendtoserver(String chaptername) {}
}
