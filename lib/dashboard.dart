import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:red_note_admin_pannel/questionsubjects.dart';
import 'package:red_note_admin_pannel/upcomingquiz/addquestionsubjects.dart';
import 'package:red_note_admin_pannel/upcomingquiz/availablesubjects.dart';
import 'package:red_note_admin_pannel/upcomingquiz/upcoming.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Pannel Red Notes"),
      ),
      body: Column(children: [
        SizedBox(
          height: 20,
        ),
        MaterialButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AvailableSubject(),
            ));
          },
          child: Card(
            child: SizedBox(
              height: 50,
              width: double.infinity,
              child: ListTile(
                leading: Icon(Icons.document_scanner),
                title: Text("Add Upcoming Question Subject"),
                trailing: Icon(Icons.arrow_forward),
              ),
            ),
          ),
        ),
        MaterialButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddQuestionSubjects(),
            ));
          },
          child: Card(
            child: SizedBox(
              height: 50,
              width: double.infinity,
              child: ListTile(
                leading: Icon(Icons.document_scanner),
                title: Text("Add Subject for MCQ"),
                trailing: Icon(Icons.arrow_forward),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
