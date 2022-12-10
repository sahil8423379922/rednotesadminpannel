import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:red_note_admin_pannel/upcomingquiz/upcoming.dart';

import 'addquestion.dart';

class AvailableSubject extends StatefulWidget {
  const AvailableSubject({super.key});

  @override
  State<AvailableSubject> createState() => _AvailableSubjectState();
}

class _AvailableSubjectState extends State<AvailableSubject> {
  List<String> sub = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sendtoserver();
    //send_data_to_firestore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Available Subjects"),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () {
                // do something
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => UpcomingQuiz(),
                ));
              },
            )
          ],
        ),
        body: Container(
          color: Colors.grey[200],
          child: ListView.builder(
              itemCount: sub.length,
              itemBuilder: (context, position) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
                  child: Card(
                    child: SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: Center(
                        child: ListTile(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AddQuestion(),
                              ));
                            },
                            leading: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: CircleAvatar(
                                  child: Text((position + 1).toString())),
                            ),
                            title: Text(sub[position])),
                      ),
                    ),
                  ),
                );
              }),
        ));
  }

  sendtoserver() async {
    int count = 0;

    DatabaseReference ref = FirebaseDatabase.instance.ref();
    ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('OnLine_Quiz_Subjects').get();
    if (snapshot.exists) {
      Iterable<DataSnapshot> values = snapshot.children;
      for (var element in values) {
        sub.add(element.value.toString());
        print("value from server =" + element.value.toString());
        setState(() {});
      }
    }
  }

  // send_data_to_firestore() {
  //   int? count = 0;
  //   FirebaseFirestore.instance
  //       .collection("onlineexamquiz")
  //       .doc("examname")
  //       .get()
  //       .then((querySnapshot) {
  //     count = querySnapshot.data()?.length;

  //     print(count);

  //     FirebaseFirestore.instance
  //         .collection("onlineexamquiz")
  //         .doc("examname")
  //         .set({count.toString():});
  //   });
  // }
}
