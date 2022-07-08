import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class answer extends StatefulWidget {
  final String question;
  final String thumbnail;
  final String video;
  final String content;
  final int like;
  final String id;
  const answer(
      {Key? key,
      required this.content,
      required this.like,
      required this.thumbnail,
      required this.video,
      required this.id,
      required this.question})
      : super(key: key);

  @override
  State<answer> createState() => _answerState();
}

class _answerState extends State<answer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(widget.thumbnail),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Question : ',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Text(widget.question),
                        Text(
                          'Description of the Question : ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(widget.content),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 400,
              child: SingleChildScrollView(
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Question')
                        .doc(widget.id)
                        .collection('Answer')
                        .snapshots(),
                    builder: (context, snapshots) {
                      if (snapshots.hasData) {
                        return ListView.builder(
                            itemCount: snapshots.data!.docs.length,
                            itemBuilder: (context, index) {
                              return Container(
                                child:
                                    Text(snapshots.data!.docs[index]['Answer']),
                              );
                            });
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
