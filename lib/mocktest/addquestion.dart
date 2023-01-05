import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddMockTestQuestion extends StatefulWidget {
  final String examname;
  final String setname;
  const AddMockTestQuestion(
      {super.key, required this.examname, required this.setname});

  @override
  State<AddMockTestQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddMockTestQuestion> {
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
    // TODO: implement initState
    super.initState();
    print(widget.examname);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Question")),
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
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: TextFormField(
                    controller: question,
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
                    controller: optiona,
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
                    controller: optionb,
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
                    controller: optionc,
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
                    controller: optiond,
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
                    controller: answer,
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
                          question.text = "";
                          answer.text = "";
                          optiona.text = "";
                          optionb.text = "";
                          optionc.text = "";
                          optiond.text = "";
                          setState(() {});
                        },
                        child: Card(
                          color: Colors.blue,
                          child: SizedBox(
                            height: double.infinity,
                            width: double.infinity,
                            child: Center(
                                child: Text(
                              "Reset",
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        ),
                      )),
                  Expanded(
                      flex: 1,
                      child: MaterialButton(
                        onPressed: () {
                          txtquestion = question.text;
                          txtoptiona = optiona.text;
                          txtoptionb = optionb.text;
                          txtoptionc = optionc.text;
                          txtoptiond = optiond.text;
                          txtanswer = answer.text;
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
                            send_data_to_server(
                                txtquestion,
                                txtoptiona,
                                txtoptionb,
                                txtoptionc,
                                txtoptiond,
                                txtanswer,
                                context);
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

  void send_data_to_server(
      String txtquestion,
      String txtoptiona,
      String txtoptionb,
      String txtoptionc,
      String txtoptiond,
      String txtanswer,
      BuildContext context) {
    int i = 1;
    int count = 0;

    FirebaseFirestore.instance
        .collection('mocktest')
        .doc(widget.examname)
        .collection(widget.setname)
        .get()
        .then((value) => {
              //print(value.docs.length);
              print("Length of documnet =" + (value.docs.length).toString()),
              count = value.docs.length,
              count = count + 1,
              setquestion(count),
            });
  }

  setquestion(int count) {
    FirebaseFirestore.instance
        .collection("mocktest")
        .doc(widget.examname)
        .collection(widget.setname)
        .doc("Question" + count.toString())
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
}
