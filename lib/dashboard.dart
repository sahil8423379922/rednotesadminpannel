import 'package:flutter/material.dart';
import 'package:red_note_admin_pannel/studymaterial/availablestudymaterialsub.dart';
import 'package:red_note_admin_pannel/upcomingexam/avlmocktest.dart';
import 'package:red_note_admin_pannel/upcomingquiz/addquestionsubjects.dart';
import 'package:red_note_admin_pannel/upcomingquiz/availablesubjects.dart';
import 'package:red_note_admin_pannel/upcomingquiz/avlwebupdate.dart';

import 'mocktest/avlmocktest.dart';

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
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Admin Pannel Red Notes"),
        ),
        drawer: Drawer(),
        body: Container(
          color: Colors.grey[200],
          child: Column(children: [
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
                  height: 60,
                  width: double.infinity,
                  child: Center(
                    child: ListTile(
                      leading: Icon(Icons.document_scanner),
                      title: Text("Add Live Practice Paper"),
                      trailing: Icon(Icons.arrow_forward),
                    ),
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
                  height: 60,
                  width: double.infinity,
                  child: Center(
                    child: ListTile(
                      leading: Icon(Icons.document_scanner),
                      title: Text("Add Practice Paper"),
                      trailing: Icon(Icons.arrow_forward),
                    ),
                  ),
                ),
              ),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AvailableStudymaterialSub(),
                ));
              },
              child: Card(
                child: SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: Center(
                    child: ListTile(
                      leading: Icon(Icons.document_scanner),
                      title: Text("Add Study Material"),
                      trailing: Icon(Icons.arrow_forward),
                    ),
                  ),
                ),
              ),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Avlmocktest(),
                ));
              },
              child: Card(
                child: SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: Center(
                    child: ListTile(
                      leading: Icon(Icons.document_scanner),
                      title: Text("Add Mock Test"),
                      trailing: Icon(Icons.arrow_forward),
                    ),
                  ),
                ),
              ),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Avlupcomingexam(),
                ));
              },
              child: Card(
                child: SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: Center(
                    child: ListTile(
                      leading: Icon(Icons.document_scanner),
                      title: Text("Add Upcoming Exam"),
                      trailing: Icon(Icons.arrow_forward),
                    ),
                  ),
                ),
              ),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AvailableWebUpdate(),
                ));
              },
              child: Card(
                child: SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: Center(
                    child: ListTile(
                      leading: Icon(Icons.document_scanner),
                      title: Text("Add Website Update"),
                      trailing: Icon(Icons.arrow_forward),
                    ),
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
