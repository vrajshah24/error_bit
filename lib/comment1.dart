import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:better_player/better_player.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class comment1 extends StatefulWidget {
  final String videoid;
  final String comid;
  const comment1({Key? key, required this.videoid, required this.comid})
      : super(key: key);

  @override
  State<comment1> createState() => _comment1State();
}

class _comment1State extends State<comment1> {
  TextEditingController comment = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Image.asset('assets/addcomment.png'),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  controller: comment,
                  maxLines: 4,
                  decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.grey),
                      hintText: 'Post your comment here',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              TextButton.icon(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFF2196F3))),
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection('Videos')
                        .doc(widget.videoid)
                        .collection('Comments')
                        .doc(widget.comid)
                        .collection('subcom-1')
                        .add({'comment': comment.text}).then(
                            (value) => Navigator.pop(context));
                  },
                  icon: Icon(
                    Icons.comment,
                    color: Colors.white70,
                  ),
                  label: Text(
                    'Post Comment',
                    style: TextStyle(color: Colors.white70),
                  ))
            ],
          ),
        ),
      ),
    ));
  }
}
