import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

class Screen3 extends StatefulWidget {
  const Screen3({Key? key}) : super(key: key);

  @override
  _Screen3State createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  int currentindex = 2;
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
