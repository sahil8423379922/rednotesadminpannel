import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:red_note_admin_pannel/dashboard.dart';

class AddStudymaterial extends StatefulWidget {
  final String subname;
  final String setname;
  const AddStudymaterial(
      {super.key, required this.subname, required this.setname});

  @override
  State<AddStudymaterial> createState() => _UpcomingQuizState();
}

class _UpcomingQuizState extends State<AddStudymaterial> {
  final TextEditingController question = new TextEditingController();
  final TextEditingController bannerlink = new TextEditingController();
  String title = "";
  String pdflink = "";
  String n = "";

  @override
  Widget build(BuildContext context) {
    n = widget.subname;
    return Scaffold(
      appBar: AppBar(
        title: Text("Study Material $n"),
      ),
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
                      label: Text("Topic Name"),
                      hintText: "Enter Topic Name"),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Card(
            color: Colors.white,
            child: SizedBox(
              height: 60,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: TextFormField(
                  controller: bannerlink,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      label: Text("PDF File Link"),
                      hintText: "Enter PDF File Link"),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          MaterialButton(
            onPressed: () {
              title = question.text;
              pdflink = bannerlink.text;
              if (title.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Enter Subject Name"),
                ));
              } else if (pdflink.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Enter Banner Link"),
                ));
              } else {
                send_set_name_to_database(
                    title, pdflink, widget.subname, widget.setname);
              }
              //sendtoserver(chaptername);
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

  // Future<void> sendtoserver(String chaptername) async {
  //   int count = 0;

  //   DatabaseReference ref = FirebaseDatabase.instance.ref();
  //   ref = FirebaseDatabase.instance.ref();
  //   final snapshot = await ref.child('OnLine_Quiz_Subjects').get();
  //   if (snapshot.exists) {
  //     Iterable<DataSnapshot> values = snapshot.children;
  //     count = values.length;
  //     ref
  //         .child("OnLine_Quiz_Subjects")
  //         .child(count.toString())
  //         .set(chaptername)
  //         .then((value) => {
  //               Navigator.of(context).push(MaterialPageRoute(
  //                 builder: (context) => Dashboard(),
  //               ))
  //             });
  //   }
  // }

  Future<void> send_set_name_to_database(
      String title, String pdflink, String subname, String setname) async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref
        .child('subject_wise_topic_studymaterial')
        .child(subname)
        .child(setname)
        .get();
    if (snapshot.exists) {
      Iterable<DataSnapshot> values = snapshot.children;
      int length = values.length;
      ref
          .child("subject_wise_topic_studymaterial")
          .child(subname)
          .child(setname)
          .child(title)
          .set(pdflink)
          .then((value) => {
                setState(() {}),
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Set Inserted"),
                ))
              });
    } else {
      ref
          .child("subject_wise_topic_studymaterial")
          .child(subname)
          .child(setname)
          .child(title)
          .set(pdflink)
          .then((value) => {
                setState(() {}),
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Set Inserted"),
                ))
              });
    }
  }
}
