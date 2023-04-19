import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../dashboard.dart';
import 'AvlQuestion.dart';

class EditLiveBannerQuestion extends StatefulWidget {
  final String subjectname;
  final String setname;
  final String questionid;
  final String question;
  final String opt1;
  final String opt2;
  final String opt3;
  final String opt4;
  final String answer;

  const EditLiveBannerQuestion(
      {super.key,
      required this.question,
      required this.opt1,
      required this.opt2,
      required this.opt3,
      required this.opt4,
      required this.answer,
      required this.subjectname,
      required this.setname,
      required this.questionid});

  @override
  State<EditLiveBannerQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<EditLiveBannerQuestion> {
  final TextEditingController question = new TextEditingController();
  final TextEditingController optiona = new TextEditingController();
  final TextEditingController optionb = new TextEditingController();
  final TextEditingController optionc = new TextEditingController();
  final TextEditingController optiond = new TextEditingController();
  final TextEditingController answer = new TextEditingController();

  String txtquestion = "";
  String txtoptiona = "";
  String txtoptionc = "";
  String txtoptiond = "";
  String txtoptionb = "";
  String txtanswer = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Question"),
      ),
      body: Container(
        color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(children: [
            SizedBox(
              height: 20,
            ),
            Card(
              child: SizedBox(
                width: double.infinity,
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: TextFormField(
                    controller: null,
                    onChanged: (value) {
                      txtquestion = value;
                    },
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    initialValue: widget.question,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.document_scanner),
                        border: InputBorder.none,
                        label: Text("Question"),
                        hintText: "Add Question"),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: TextFormField(
                    controller: null,
                    onChanged: (value) {
                      txtoptiona = value;
                    },
                    initialValue: widget.opt1,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.document_scanner),
                        border: InputBorder.none,
                        label: Text("Option A"),
                        hintText: "Add Option A"),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: TextFormField(
                    initialValue: widget.opt2,
                    controller: null,
                    onChanged: (value) {
                      txtoptionb = value;
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.document_scanner),
                        border: InputBorder.none,
                        label: Text("Option B"),
                        hintText: "Add Option B"),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: TextFormField(
                    controller: null,
                    onChanged: (value) {
                      txtoptionc = value;
                    },
                    initialValue: widget.opt3,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.document_scanner),
                        border: InputBorder.none,
                        label: Text("Option C"),
                        hintText: "Add Option C"),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: TextFormField(
                    initialValue: widget.opt4,
                    controller: null,
                    onChanged: (value) {
                      txtoptiond = value;
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.document_scanner),
                        border: InputBorder.none,
                        label: Text("Option D"),
                        hintText: "Add Option D"),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: TextFormField(
                    controller: null,
                    initialValue: widget.answer,
                    onChanged: (value) {
                      txtanswer = value;
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.document_scanner),
                        border: InputBorder.none,
                        label: Text("Answer"),
                        hintText: "Add Correct Answer Number"),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: MaterialButton(
                        onPressed: () {
                          showAlertDialog(context);
                        },
                        child: Card(
                          color: Colors.blue,
                          child: SizedBox(
                            height: double.infinity,
                            width: double.infinity,
                            child: Center(
                                child: Text(
                              "Delete",
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        ),
                      )),
                  Expanded(
                      flex: 1,
                      child: MaterialButton(
                        onPressed: () {
                          if (txtquestion.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Enter Question"),
                            ));
                          } else if (txtoptiona.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Enter Option A"),
                            ));
                          } else if (txtoptionb.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Enter Option B"),
                            ));
                          } else if (txtoptionc.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Enter Option C"),
                            ));
                          } else if (txtoptiond.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Enter Option D"),
                            ));
                          } else if (txtanswer.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Enter Answer"),
                            ));
                          } else {
                            setquestion(txtquestion, txtoptiona, txtoptionb,
                                txtoptionc, txtoptiond, txtanswer, context);
                          }
                        },
                        child: Card(
                          color: Colors.blue,
                          child: SizedBox(
                            height: double.infinity,
                            width: double.infinity,
                            child: Center(
                                child: Text(
                              "Submit",
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        ),
                      ))
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }

  setquestion(
      String txtquestion,
      String txtoptiona,
      String txtoptionb,
      String txtoptionc,
      String txtoptiond,
      String txtanswer,
      BuildContext context) {
    FirebaseFirestore.instance
        .collection("onlineexamquiz")
        .doc("quiz")
        .collection(widget.setname)
        .doc(widget.questionid)
        .set({
      "QUESTION": txtquestion,
      "ANSWER": txtanswer,
      "A": txtoptiona,
      "B": txtoptionb,
      "C": txtoptionc,
      "D": txtoptiond
    }).then((value) => {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Question Inserted"),
              )),
              question.text = "",
              answer.text = "",
              optiona.text = "",
              optionb.text = "",
              optionc.text = "",
              optiond.text = "",
              setState(() {})
            });
  }

  void deletedata() {
    FirebaseFirestore.instance
        .collection("onlineexamquiz")
        .doc("quiz")
        .collection(widget.setname)
        .doc(widget.questionid)
        .delete()
        .whenComplete(() => {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Question Deleted"),
              )),
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Dashboard(),
              ))
            });
    setState(() {});

    // FirebaseFirestore.instance
    //     .collection("onlineexamquiz")
    //     .doc("bannerlinks")
    //     .update({sub1: FieldValue.delete()});
    // print(filename);

    // FirebaseFirestore.instance
    //     .collection('onlineexamquiz')
    //     .doc("quiz")
    //     .collection(filename)
    //     .get()
    //     .then((snapshot) {
    //   for (DocumentSnapshot ds in snapshot.docs) {
    //     ds.reference.delete();
    //   }
    // });
  }

  showAlertDialog(BuildContext context) {
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
        deletedata();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete Question"),
      content: Text("Would you like to delete question?"),
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
