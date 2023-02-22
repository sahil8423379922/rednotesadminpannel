import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:red_note_admin_pannel/dashboard.dart';

class AddWebUpdate extends StatefulWidget {
  const AddWebUpdate({super.key});

  @override
  State<AddWebUpdate> createState() => _UpcomingQuizState();
}

class _UpcomingQuizState extends State<AddWebUpdate> {
  final TextEditingController updatename = new TextEditingController();
  final TextEditingController weblink = new TextEditingController();
  final TextEditingController bannerlink = new TextEditingController();
  String txtupdatename = "";
  String txtweblink = "";
  String txtbannerlink = "";

  var values;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Web Update"),
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
                  controller: updatename,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      label: Text("Update Name"),
                      hintText: "Enter Update Name"),
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
                  controller: weblink,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      label: Text("Web Page Link"),
                      hintText: "Enter Web Page Link"),
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
              txtupdatename = updatename.text;
              txtweblink = weblink.text;
              txtbannerlink = bannerlink.text;

              if (txtupdatename.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Enter Web Update Name"),
                ));
              } else if (txtweblink.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Enter Web Link"),
                ));
              } else if (txtbannerlink.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Enter Banner Link"),
                ));
              } else {
                send_data_to_firestore(
                    txtupdatename, txtweblink, txtbannerlink, context);
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

  send_data_to_firestore(String webupdatename, String weblink,
      String txtbannerlink, BuildContext context) async {
    int count = 0;

    //var collection = FirebaseFirestore.instance.collection('websiteupdate');
    var collection = FirebaseFirestore.instance.collection('websiteupdate');
    var docSnapshot = await collection.doc('weblinks').get();

    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data()!;

      for (var x in data.keys) {
        count = int.parse(x);
      }

      setQuestion(count + 1, webupdatename, weblink, txtbannerlink, context);
    } else {
      setUpdateQuestion(
          count + 1, webupdatename, weblink, txtbannerlink, context);
    }
  }

  //count = count! + 1;
}

void setQuestion(int count, String webupdatename, String weblink,
    String txtbannerlink, BuildContext context) {
  FirebaseFirestore.instance
      .collection("websiteupdate")
      .doc("webname")
      .update({(count).toString(): webupdatename}).then((value) => {
            FirebaseFirestore.instance
                .collection("websiteupdate")
                .doc("weblinks")
                .update({(count).toString(): weblink}).then((value) => {
                      FirebaseFirestore.instance
                          .collection("websiteupdate")
                          .doc("webbanner")
                          .update({(count).toString(): txtbannerlink}).then(
                              (value) => {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => Dashboard(),
                                    ))
                                  })
                    })
          });
}

void setUpdateQuestion(int count, String webupdatename, String weblink,
    String txtbannerlink, BuildContext context) {
  FirebaseFirestore.instance
      .collection("websiteupdate")
      .doc("webname")
      .set({(count).toString(): webupdatename}).then((value) => {
            FirebaseFirestore.instance
                .collection("websiteupdate")
                .doc("weblinks")
                .set({(count).toString(): weblink}).then((value) => {
                      FirebaseFirestore.instance
                          .collection("websiteupdate")
                          .doc("webbanner")
                          .set({(count).toString(): txtbannerlink}).then(
                              (value) => {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => Dashboard(),
                                    ))
                                  })
                    })
          });
}
