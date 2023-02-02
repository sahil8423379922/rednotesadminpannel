import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../dashboard.dart';

class PinputExample extends StatefulWidget {
  const PinputExample({Key? key}) : super(key: key);

  @override
  State<PinputExample> createState() => _PinputExampleState();
}

class _PinputExampleState extends State<PinputExample> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  final TextEditingController userid = new TextEditingController();
  String txtuserid = "";
  String txtinputpin = "";
  String fetcheduserid = "";
  String fetcheduserpin = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_credentials();
  }

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    checkdevice();
    const focusedBorderColor = Color.fromARGB(255, 0, 0, 0);
    const fillColor = Color.fromARGB(0, 255, 255, 255);
    const borderColor = Color.fromARGB(102, 0, 0, 0);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );

    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 246, 255, 254),
        child: Row(
          children: [
            Expanded(flex: 2, child: Container()),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Admin Login",
                      style: TextStyle(fontSize: 30),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text("Enter Pin and User ID for login"),
                    SizedBox(
                      height: 30,
                    ),
                    Card(
                      color: Colors.white,
                      child: TextFormField(
                        controller: userid,
                        obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            label: Text("User ID"),
                            hintText: "Enter User ID"),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Pinput(
                          controller: pinController,
                          focusNode: focusNode,
                          obscureText: true,
                          defaultPinTheme: defaultPinTheme,
                          onCompleted: (pin) {
                            //debugPrint('onCompleted: $pin');
                            txtinputpin = pin;
                          },
                          onChanged: (value) {
                            //debugPrint('onChanged: $value');
                            // txtinputpin = value;
                          },
                          cursor: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 9),
                                width: 22,
                                height: 1,
                                color: focusedBorderColor,
                              ),
                            ],
                          ),
                          focusedPinTheme: defaultPinTheme.copyWith(
                            decoration: defaultPinTheme.decoration!.copyWith(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: focusedBorderColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      onPressed: () {
                        txtuserid = userid.text;
                        if (txtuserid.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Enter Valid User ID"),
                          ));
                        } else if (txtinputpin.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Enter Valid User Pin"),
                          ));
                        } else {
                          checkinput_credentials(txtuserid, txtinputpin);
                        }
                      },
                      child: Card(
                        color: Colors.blue,
                        child: SizedBox(
                          height: 50,
                          width: 280,
                          child: Center(
                              child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(),
              flex: 2,
            )
          ],
        ),
      ),
    );
  }

  get_credentials() async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('admin').get();
    final snapshot1 = await ref.child('admin').child("pass").get();
    if (snapshot.exists) {
      Iterable<DataSnapshot> values1 = snapshot.children;
      for (var p in values1) {
        if (p.key == "id") {
          fetcheduserid = p.value.toString();
        }
      }
    }
    if (snapshot1.exists) {
      Iterable<DataSnapshot> values2 = snapshot.children;
      for (var q in values2) {
        fetcheduserpin = q.value.toString();
      }
    }
  }

  void checkinput_credentials(String txtuserid, String txtinputpin) {
    if (txtuserid == fetcheduserid && txtinputpin == fetcheduserpin) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Login Sucessfull"),
      ));

      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Dashboard(),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Invalid User Credentials"),
      ));

      setState(() {
        userid.clear();
        pinController.clear();
      });
    }
  }

  void checkdevice() {
    if (kIsWeb) {
      // running on the web!
      print("This is web page");
    } else {
      print("This is android page");
      // NOT running on the web! You can check for additional platforms here.
    }
  }
}
