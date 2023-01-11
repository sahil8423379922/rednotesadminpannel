import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:red_note_admin_pannel/upcomingquiz/addquestionforquiz.dart';
import 'package:red_note_admin_pannel/upcomingquiz/upcoming.dart';

import '../dashboard.dart';
import 'addstudymaterial.dart';

class AvailableSetsTopicWise extends StatefulWidget {
  final String subname;
  final String setname;
  const AvailableSetsTopicWise(
      {super.key, required this.subname, required this.setname});

  @override
  State<AvailableSetsTopicWise> createState() => _AvailableSubjectState();
}

class _AvailableSubjectState extends State<AvailableSetsTopicWise> {
  List<String> sub = [];
  List<String> subkey = [];
  final TextEditingController setname = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // sendtoserver();
    fetch_data_from_realtime_database(widget.subname);
    //send_data_to_firestore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Available Sets for " + widget.subname),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                // do something
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddStudymaterial(
                    setname: widget.setname,
                    subname: widget.subname,
                  ),
                ));
              },
            )
          ],
        ),
        body: Container(
          color: Colors.grey[200],
          child: Column(
            children: [
              Expanded(
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
    print("Subname =" + widget.subname);
    print("Set Name =" + widget.setname);
    print("Sub1 =" + sub1);

    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref
        .child('subject_wise_topic_studymaterial')
        .child(widget.subname)
        .child(widget.setname)
        .get();
    Iterable<DataSnapshot> values = snapshot.children;
    int length = values.length;
    String l = "";
    for (var x in values) {
      if (x.key == sub1) {
        l = x.key.toString();
      }
    }
    //int li = int.parse(l);

    print("Data receive to delete = " + sub1);

    FirebaseDatabase.instance
        .reference()
        .child("subject_wise_topic_studymaterial")
        .child(widget.subname)
        .child(widget.setname)
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

  Future<void> fetch_data_from_realtime_database(String subname) async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref
        .child('subject_wise_topic_studymaterial')
        .child(widget.subname)
        .child(widget.setname)
        .get();

    if (snapshot.exists) {
      Iterable<DataSnapshot> values = snapshot.children;
      for (var element in values) {
        sub.add((element.key).toString());
        setState(() {});
      }
    }
  }

  Future<void> send_set_name_to_database(String setname) async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref
        .child('subject_wise_topic_studymaterial')
        .child(widget.subname)
        .child(widget.setname)
        .get();
    if (snapshot.exists) {
      Iterable<DataSnapshot> values = snapshot.children;
      int length = values.length;
      ref
          .child("subject_wise_topic_studymaterial")
          .child(widget.subname)
          .child(widget.setname)
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
          .child("subject_wise_topic_studymaterial")
          .child(widget.subname)
          .child(widget.setname)
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
