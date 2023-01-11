import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:red_note_admin_pannel/upcomingquiz/upcoming.dart';

import '../dashboard.dart';
import 'addquestion.dart';
import 'editquestion.dart';
import 'editquestionlivequestion.dart';

class AvlQuestionPracticePaperQuiz extends StatefulWidget {
  final String setname;
  final String examname;
  const AvlQuestionPracticePaperQuiz(
      {super.key, required this.setname, required this.examname});

  @override
  State<AvlQuestionPracticePaperQuiz> createState() => _AvailableSubjectState();
}

class _AvailableSubjectState extends State<AvlQuestionPracticePaperQuiz> {
  List<String> sub = [];
  List<String> subkey = [];
  List<String> questionname = [];
  List<String> option1 = [];
  List<String> option2 = [];
  List<String> option3 = [];
  List<String> option4 = [];
  List<String> answer = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // sendtoserver();
    getDocs();
    //send_data_to_firestore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Available Question for " + widget.setname),
        ),
        body: Container(
          color: Colors.grey[200],
          child: ListView.builder(
              itemCount: questionname.length,
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
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => EditLiveBannerQuestion(
                                    answer: answer[position],
                                    opt1: option1[position],
                                    opt2: option2[position],
                                    opt3: option3[position],
                                    opt4: option4[position],
                                    question: questionname[position],
                                    questionid: sub[position],
                                    setname: widget.setname,
                                    subjectname: widget.examname,
                                  ),
                                ));
                              },
                              icon: Icon(Icons.edit),
                            ),
                            leading: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: CircleAvatar(
                                  child: Text((position + 1).toString())),
                            ),
                            title: Text(sub[position] +
                                " : " +
                                questionname[position])),
                      ),
                    ),
                  ),
                );
              }),
        ));
  }

  Future getDocs() async {
    print("value of exam name from previous screen =" + widget.examname);
    print("value sent from previous screen =" + widget.setname.toString());
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("onlineexamquiz")
        .doc("quiz")
        .collection(widget.setname)
        .get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i];
      print(a.id);
      sub.add(a.id);
      getdatafromfeild(widget.examname, widget.setname, a.id);
      //setState(() {});
    }
  }

  void getdatafromfeild(String examname, String setname, String id) async {
    var collection = FirebaseFirestore.instance
        .collection('onlineexamquiz')
        .doc("quiz")
        .collection(setname);
    var docSnapshot = await collection.doc(id).get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data()!;

      questionname.add(data['QUESTION']);
      option1.add(data['A']);
      option2.add(data['B']);
      option3.add(data['B']);
      option4.add(data['D']);
      answer.add(data['ANSWER']);
      setState(() {});
    }
  }

  Future<void> send_set_name_to_database(String setname) async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('upcomingexam').get();
    if (snapshot.exists) {
      var collection = FirebaseFirestore.instance.collection('upcomingexam');
      collection.doc(setname).set({});
      Iterable<DataSnapshot> values = snapshot.children;
      int length = values.length;
      String l = "";

      for (var x in values) {
        l = x.key.toString();
      }
      int li = int.parse(l);

      print("Length of the sets =" + length.toString());
      ref
          .child("upcomingexam")
          .child((li + 1).toString())
          .set(setname)
          .then((value) => {
                setState(() {}),
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Set Inserted"),
                )),
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Dashboard(),
                )),
                setState(() {})
              });
    } else {
      ref.child("upcomingexam").child("0").set(setname).then((value) => {
            setState(() {}),
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Set Inserted"),
            )),
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Dashboard(),
            )),
            setState(() {})
          });
    }
  }
}
