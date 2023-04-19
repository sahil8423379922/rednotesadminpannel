import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:red_note_admin_pannel/upcomingquiz/upcoming.dart';

import '../dashboard.dart';
import 'addquestion.dart';
import 'addquizsubject.dart';
import 'avialblesets.dart';

class AddQuestionSubjectsForRajasthanGK extends StatefulWidget {
  final String code;
  const AddQuestionSubjectsForRajasthanGK({super.key, required this.code});

  @override
  State<AddQuestionSubjectsForRajasthanGK> createState() =>
      _AvailableSubjectState();
}

class _AvailableSubjectState extends State<AddQuestionSubjectsForRajasthanGK> {
  List<String> sub = [];
  List<String> subkey = [];
  final TextEditingController setname = new TextEditingController();

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
          title: Text("Available Sets for " + widget.code),
          actions: <Widget>[],
        ),
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 8,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: TextFormField(
                              controller: setname,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter Set Name",
                                  label: Text("Set")),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          child: MaterialButton(
                        onPressed: () {
                          String subname = setname.text;
                          if (subname.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Please Enter Set Name"),
                            ));
                          } else {
                            send_set_name_to_database(subname);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: Card(
                            color: Colors.red,
                            child: SizedBox(
                              height: double.infinity,
                              width: double.infinity,
                              child: Center(
                                  child: Text(
                                "ADD",
                                style: TextStyle(color: Colors.white),
                              )),
                            ),
                          ),
                        ),
                      ))
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Container(
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
                                  trailing: IconButton(
                                    onPressed: () {
                                      deletedata(
                                          (sub[position]).toString(), context);
                                    },
                                    icon: Icon(Icons.delete),
                                  ),
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
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
              ),
            ),
          ],
        ));
  }

  Future<void> deletedata(String sub1, BuildContext context) async {
    print("Data received =" + sub1);
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('mcq_questions').child(widget.code).get();
    Iterable<DataSnapshot> values = snapshot.children;
    int length = values.length;
    String l = "";
    for (var x in values) {
      if (x.value == sub1) {
        l = x.key.toString();
      }
    }
    //int li = int.parse(l);

    print("Data receive to delete = " + sub1);

    FirebaseDatabase.instance
        .reference()
        .child("mcq_questions")
        .child(widget.code)
        .child(l)
        .remove()
        .whenComplete(() => {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Subject Deleted"),
              )),
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Dashboard(),
              )),
              // deletefirestoredata(sub1)
            });
    setState(() {});
  }

  fetch_data_from_firestore() async {
    int i = 1;
    int? count;

    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child("mcq_questions").child(widget.code).get();
    if (snapshot.exists) {
      Iterable<DataSnapshot> data = snapshot.children;
      for (var x in data) {
        sub.add(x.value.toString());
        setState(() {});
      }
    }
  }

  Future<void> send_set_name_to_database(String setname) async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('mcq_questions').child(widget.code).get();
    if (snapshot.exists) {
      Iterable<DataSnapshot> values = snapshot.children;
      int length = values.length;
      ref
          .child("mcq_questions")
          .child(widget.code)
          .child(length.toString())
          .set(setname)
          .then((value) => {
                setState(() {}),
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Set Inserted"),
                ))
              });
    } else {
      ref
          .child("mcq_questions")
          .child(widget.code)
          .child("0")
          .set(setname)
          .then((value) => {
                setState(() {}),
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Set Inserted"),
                ))
              });
    }
  }
}
