import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';

class Forgotpassword extends StatefulWidget {
  const Forgotpassword({Key? key}) : super(key: key);

  @override
  _ForgotpasswordState createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
  TextEditingController emailcontroller = TextEditingController();
//  TextEditingController passwordcontroller = TextEditingController();
  var _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: Text('ErrorBit'),
        centerTitle: true,
        // flexibleSpace: Image(
        //   image: AssetImage(
        //     'images/appbar2.png',
        //   ),
        //   fit: BoxFit.cover,
        // ),
        backgroundColor: Colors.blue.shade400,
        foregroundColor: Colors.white,
        iconTheme: IconThemeData(size: 30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(200),
            bottomLeft: Radius.circular(0),
          ),
        ),
      ),
      //drawer: Mainappbar(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(5, 20, 20, 0),
          child: Form(
            key: _formkey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/forgotpass.json', height: 380, width: 380),
                SizedBox(
                  height: 80,
                ),
                Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Column(children: [
                      TextFormField(
                        controller: emailcontroller,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              //borderSide: BorderSide(color: Colors.yellow, width: 3),
                            ),
                            hintText: 'Email',
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              color: Colors.blue.shade400,
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                    color: Colors.blue.shade400, width: 2)),
                            icon: Icon(
                              LineIcons.mailBulk,
                              color: Colors.blue.shade400,
                              size: 30,
                            ),
                            focusColor: Colors.teal.shade200),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter your Email';
                          }
                          return null;
                        },
                      ),
                    ])),
                SizedBox(
                  height: 20,
                ),
                FloatingActionButton.extended(
                  hoverColor: Colors.blue.shade400,
                  backgroundColor: Colors.blue.shade400,
                  elevation: 0,
                  label: Text('Send Link'),
                  onPressed: () => setState(() {
                    if (_formkey.currentState!.validate()) {
                      FirebaseAuth.instance
                          .sendPasswordResetEmail(email: emailcontroller.text);
                    }
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
