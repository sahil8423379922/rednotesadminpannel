import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:red_note_admin_pannel/dashboard.dart';

class Addquizsubject extends StatefulWidget {
  const Addquizsubject({super.key});

  @override
  State<Addquizsubject> createState() => _UpcomingQuizState();
}

class _UpcomingQuizState extends State<Addquizsubject> {
  final TextEditingController question = new TextEditingController();
  final TextEditingController bannerlink = new TextEditingController();
  String txtquestion = "";
  String txtbannerlink = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Upcoming Quiz Topic"),
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
                      label: Text("Examname"),
                      hintText: "Enter Exam Name"),
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
                      label: Text("Banner Link"),
                      hintText: "Enter Banner Link"),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          MaterialButton(
            onPressed: () {
              txtquestion = question.text;
              txtbannerlink = bannerlink.text;
              if (txtquestion.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Enter Subject Name"),
                ));
              } else if (txtbannerlink.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Enter Banner Link"),
                ));
              } else {
                send_data_to_firestore(txtquestion, txtbannerlink);
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

  send_data_to_firestore(String chaptername, String bannerlink) {
    int? count = 0;
    FirebaseFirestore.instance
        .collection("quiztopics")
        .doc("title")
        .get()
        .then((querySnapshot) {
      count = querySnapshot.data()?.length;

      print(count);
      FirebaseFirestore.instance.collection("quiz").doc(chaptername).set({});

      FirebaseFirestore.instance
          .collection("quiztopics")
          .doc("title")
          .update({(count! + 1).toString(): chaptername}).then((value) => {
                FirebaseFirestore.instance
                    .collection("quiztopics")
                    .doc("banner")
                    .update({(count! + 1).toString(): bannerlink}).then(
                        (value) => {
                              send_set_name_to_database(chaptername),
                            })
              });
    });
  }

  Future<void> send_set_name_to_database(String setname) async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('quiz').child(setname).get();
    if (snapshot.exists) {
      Iterable<DataSnapshot> values = snapshot.children;
      int length = values.length;
      ref
          .child("quiz")
          .child(setname)
          .child(length.toString())
          .set("Set 1")
          .then((value) => {
                setState(() {}),
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Dashboard(),
                ))
              });
    } else {
      ref.child("quiz").child(setname).child("0").set("Set 1").then((value) => {
            setState(() {}),
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Dashboard(),
            ))
          });
    }
  }
}
