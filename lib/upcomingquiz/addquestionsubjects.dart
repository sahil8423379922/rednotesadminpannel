import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:red_note_admin_pannel/upcomingquiz/upcoming.dart';

import '../dashboard.dart';
import 'addquestion.dart';
import 'addquizsubject.dart';
import 'avialblesets.dart';

class AddQuestionSubjects extends StatefulWidget {
  const AddQuestionSubjects({super.key});

  @override
  State<AddQuestionSubjects> createState() => _AvailableSubjectState();
}

class _AvailableSubjectState extends State<AddQuestionSubjects> {
  List<String> sub = [];
  List<String> subkey = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // sendtoserver();
    fetch_data_from_firestore();
    //send_data_to_firestore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Available Subjects"),
          actions: <Widget>[
            // IconButton(
            //   icon: Icon(
            //     Icons.settings,
            //     color: Colors.white,
            //   ),
            //   onPressed: () {
            //     // do something
            //     Navigator.of(context).push(MaterialPageRoute(
            //       builder: (context) => Addquizsubject(),
            //     ));
            //   },
            // )
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
                            // trailing: IconButton(
                            //   onPressed: () {
                            //     print(subkey[position]);
                            //     print(sub[position]);
                            //     deletedata((subkey[position]).toString(),
                            //         context, sub[position]);
                            //   },
                            //   icon: Icon(Icons.delete),
                            // ),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AvailableSets(
                                  subname: sub[position],
                                ),
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

  fetch_data_from_firestore() {
    int i = 1;
    int? count;
    FirebaseFirestore.instance
        .collection("quiztopics")
        .doc("title")
        .get()
        .then((querySnapshot) {
      Map<String, dynamic>? values = querySnapshot.data();
      values!.forEach(
        (key, value) => {sub.add(value), subkey.add(key), setState(() {})},
      );

      // i = i + 1;
      // }
    });
  }

  void deletedata(String sub1, BuildContext context, String name) {
    print(sub1);
    print(name);

    final ref = FirebaseDatabase.instance.ref();
    ref.child("quiz").child(name).remove();

    FirebaseFirestore.instance
        .collection("quiz")
        .doc(name)
        .delete()
        .whenComplete(() => {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Subject Deleted"),
              )),
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Dashboard(),
              ))
            });

    FirebaseFirestore.instance
        .collection("quiztopics")
        .doc("title")
        .update({sub1: FieldValue.delete()}).whenComplete(() => {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Subject Deleted"),
              )),
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Dashboard(),
              ))
            });
    setState(() {});

    FirebaseFirestore.instance
        .collection("quiztopics")
        .doc("banner")
        .update({sub1: FieldValue.delete()});
  }
}
