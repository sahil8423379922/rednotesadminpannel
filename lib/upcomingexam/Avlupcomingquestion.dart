import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:red_note_admin_pannel/upcomingexam/editquestion.dart';
import 'package:red_note_admin_pannel/upcomingquiz/upcoming.dart';

import '../dashboard.dart';
import '../upcomingquiz/editquestion.dart';
import 'addquestion.dart';

class AvlUpcomingQuestion extends StatefulWidget {
  final String setname;
  final String examname;
  const AvlUpcomingQuestion(
      {super.key, required this.setname, required this.examname});

  @override
  State<AvlUpcomingQuestion> createState() => _AvailableSubjectState();
}

class _AvailableSubjectState extends State<AvlUpcomingQuestion> {
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
                                  builder: (context) => EditUpcomingQuestion(
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
        .collection("upcomingexam")
        .doc(widget.examname)
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
        .collection('upcomingexam')
        .doc(examname)
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
}
