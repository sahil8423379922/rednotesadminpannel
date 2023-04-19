import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:red_note_admin_pannel/upcomingquiz/upcoming.dart';

import '../dashboard.dart';
import 'addquestion.dart';
import 'addquestionsubjectsForRajasthanGK.dart';

class AvailableSubject extends StatefulWidget {
  const AvailableSubject({super.key});

  @override
  State<AvailableSubject> createState() => _AvailableSubjectState();
}

class _AvailableSubjectState extends State<AvailableSubject> {
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
            IconButton(
              icon: Icon(
                Icons.add,
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
                            trailing: IconButton(
                              onPressed: () {
                                showAlertDialog(
                                    context,
                                    (subkey[position]).toString(),
                                    sub[position]);

                                print("Value of subkey =" + subkey[position]);
                                print("Value of subkey =" + sub[position]);
                              },
                              icon: Icon(Icons.delete),
                            ),
                            onTap: () {
                              if (sub[position] == "Rajasthan GK" ||
                                  sub[position] == "Hindi") {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      AddQuestionSubjectsForRajasthanGK(
                                    code: sub[position],
                                  ),
                                ));
                              } else {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AddQuestion(
                                    examname: sub[position],
                                  ),
                                ));
                              }
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
        .collection("onlineexamquiz")
        .doc("examname")
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

  void deletedata(String sub1, BuildContext context, String filename) {
    FirebaseFirestore.instance
        .collection("onlineexamquiz")
        .doc("examname")
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
        .collection("onlineexamquiz")
        .doc("bannerlinks")
        .update({sub1: FieldValue.delete()});
    print(filename);

    FirebaseFirestore.instance
        .collection('onlineexamquiz')
        .doc("quiz")
        .collection(filename)
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
  }

  showAlertDialog(BuildContext context, String sub1, String filename) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context, false);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed: () {
        deletedata(sub1, context, filename);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete Subject"),
      content: Text("Would you like to delete Subject?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
