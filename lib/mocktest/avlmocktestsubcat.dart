import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:red_note_admin_pannel/upcomingquiz/addquestionforquiz.dart';
import 'package:red_note_admin_pannel/upcomingquiz/upcoming.dart';

import '../dashboard.dart';
import '../studymaterial/avialblesetstopicwise.dart';
import 'addquestion.dart';
import 'avlmocktest.dart';

class AvlmocktestSubcat extends StatefulWidget {
  final String subcatname;

  const AvlmocktestSubcat({super.key, required this.subcatname});

  @override
  State<AvlmocktestSubcat> createState() => _AvailableSubjectState();
}

class _AvailableSubjectState extends State<AvlmocktestSubcat> {
  List<String> sub = [];
  List<String> subkey = [];
  final TextEditingController setname = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // sendtoserver();
    fetch_data_from_realtime_database();
    //send_data_to_firestore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Available Mock Test " + widget.subcatname),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Avlmocktest(),
              ));
            },
          ),
        ),
        body: Container(
          color: Colors.grey[200],
          child: Column(
            children: [
              Expanded(
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
              )),
              Expanded(
                flex: 8,
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
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddMockTestQuestion(
                                                  examname: widget.subcatname,
                                                  setname: sub[position],
                                                )));
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
            ],
          ),
        ));
  }

  Future<void> deletedata(String sub1, BuildContext context) async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot =
        await ref.child('mocktestsubcat').child(widget.subcatname).get();
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
        .child("mocktestsubcat")
        .child(widget.subcatname)
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

  Future<void> fetch_data_from_realtime_database() async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot =
        await ref.child('mocktestsubcat').child(widget.subcatname).get();

    if (snapshot.exists) {
      Iterable<DataSnapshot> values = snapshot.children;
      for (var element in values) {
        sub.add((element.value).toString());
        setState(() {});
      }
    }
  }

  Future<void> send_set_name_to_database(String setname) async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot =
        await ref.child('mocktestsubcat').child(widget.subcatname).get();
    if (snapshot.exists) {
      //var collection = FirebaseFirestore.instance.collection('mocktestsubcat');
      //collection.doc(setname).set({});
      Iterable<DataSnapshot> values = snapshot.children;
      int length = values.length;
      String l = "";

      for (var x in values) {
        l = x.key.toString();
      }
      int li = int.parse(l);

      print("Length of the sets =" + length.toString());
      ref
          .child("mocktestsubcat")
          .child(widget.subcatname)
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
      ref
          .child("mocktestsubcat")
          .child(widget.subcatname)
          .child("0")
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
    }
  }

  // Future<void> send_set_name_to_database(String setname) async {
  //   final ref = FirebaseDatabase.instance.ref();
  //   final snapshot =
  //       await ref.child('mocktestsubcat').child(widget.subcatname).get();
  //   if (snapshot.exists) {
  //     Iterable<DataSnapshot> values = snapshot.children;
  //     int length = values.length;
  //     ref
  //         .child("mocktestsubcat")
  //         .child(widget.subcatname)
  //         .child(length.toString())
  //         .set(setname)
  //         .then((value) => {
  //               setState(() {}),
  //               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //                 content: Text("Set Inserted"),
  //               ))
  //             });
  //   } else {
  //     ref
  //         .child("mocktestsubcat")
  //         .child(widget.subcatname)
  //         .child("0")
  //         .set(setname)
  //         .then((value) => {
  //               setState(() {}),
  //               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //                 content: Text("Set Inserted"),
  //               ))
  //             });
  //   }
  // }

}
