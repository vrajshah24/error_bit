import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

class Screen4 extends StatefulWidget {
  const Screen4({Key? key}) : super(key: key);

  @override
  _Screen4State createState() => _Screen4State();
}

class _Screen4State extends State<Screen4> {
  int currentindex = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.only(left: 20),
                child: Lottie.asset('assets/welcome.json',
                    height: 350, width: 350)),
            Text(
              'Error Bit',
              style: GoogleFonts.sacramento(fontSize: 50),
            ),
          ],
        ),
      ),
    ));
  }
}
