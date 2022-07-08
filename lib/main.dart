import 'package:error_bit/forgot_password.dart';
import 'package:error_bit/home.dart';
import 'package:error_bit/question.dart';
import 'package:error_bit/question_list.dart';
import 'package:error_bit/signin.dart';
import 'package:error_bit/video_upload.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    routes: {
      '/': (context) => const HomeScreen(),
      '/forgotpassword': (context) => const Forgotpassword(),
      '/home': (context) => const Main(),
      '/signin': (context) => const Signin(),
      '/video_upload': (context) => const Video_upload(),
      '/question': (context) => question(),
      '/questionList': (context) => questionList(),
    },
  ));
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  var _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Sign Up'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade400,
        //   shadowColor: Colors.black54,
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
                Image.asset('assets/signup.png', height: 380, width: 380),
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
                            focusColor: Colors.blue.shade400),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter your Email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        obscureText: true,
                        controller: passwordcontroller,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              //      borderSide: BorderSide(color: Colors.yellow, width: 3),
                            ),
                            hintText: 'Password',
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              color: Colors.blue.shade400,
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                    color: Colors.blue.shade400, width: 2)),
                            icon: Icon(
                              LineIcons.alternateShield,
                              color: Colors.blue.shade400,
                              size: 30,
                            ),
                            focusColor: Colors.blue.shade400),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter your password';
                          }
                          return null;
                        },
                      ),
                    ])),
                SizedBox(
                  height: 10,
                ),
                TextButton.icon(
                    onPressed: () => setState(() {
                          if (_formkey.currentState!.validate()) {
                            FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: emailcontroller.text,
                                    password: passwordcontroller.text)
                                .then((FirebaseUser) =>
                                    Navigator.popAndPushNamed(context, '/'));
                          }
                        }),
                    icon: Icon(LineIcons.pen),
                    label: Text('Sign Up')),
                TextButton.icon(
                    onPressed: () => Navigator.pushNamed(context, '/signin'),
                    icon: Icon(LineIcons.doorOpen),
                    label: Text('Sign In')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
