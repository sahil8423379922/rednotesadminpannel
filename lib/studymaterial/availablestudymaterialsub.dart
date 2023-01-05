import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:red_note_admin_pannel/upcomingquiz/upcoming.dart';

import '../dashboard.dart';
import '../upcomingquiz/addquestion.dart';
import 'avialblesets.dart';

class AvailableStudymaterialSub extends StatefulWidget {
  const AvailableStudymaterialSub({super.key});

  @override
  State<AvailableStudymaterialSub> createState() => _AvailableSubjectState();
}

class _AvailableSubjectState extends State<AvailableStudymaterialSub> {
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
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    AvailableTopicsStudymaterial(
                                  subname: sub[position],
                                ),
                              ));
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
        .collection("study_material")
        .doc("subject")
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
}
