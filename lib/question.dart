// ignore_for_file: empty_statements

import 'dart:io';
import 'dart:math';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class question extends StatefulWidget {
  const question({Key? key}) : super(key: key);

  @override
  State<question> createState() => _questionState();
}

class _questionState extends State<question> {
  var imgname = "";
  var imgpath = "";
  var videoname = "";
  var videopath = "";
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController contentcontroller = TextEditingController();
  var _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
            key: _form,
            child: Column(
              children: [
                Image.asset('assets/question.png'),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          width: 2,
                          color: Color(0xFF2196F3),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    height: 370,
                    child: Container(
                      child: Column(
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: titlecontroller,
                            decoration: InputDecoration(
                                focusColor: Colors.blue,
                                hoverColor: Colors.blue,
                                labelStyle: TextStyle(color: Colors.blue),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2)),
                                label: Text('Question'),
                                hintText: 'Question',
                                icon: Icon(LineIcons.questionCircleAlt,
                                    size: 30, color: Colors.blue)),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Title field can' 't be  null';
                              } else {
                                return null;
                              }
                            },
                          ),
                          TextFormField(
                            controller: contentcontroller,
                            decoration: InputDecoration(
                                focusColor: Colors.blue,
                                hoverColor: Colors.blue,
                                labelStyle: TextStyle(color: Colors.blue),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2)),
                                label: Text('Content / body'),
                                hintText: 'Content / body',
                                icon: Icon(
                                  LineIcons.pen,
                                  color: Colors.blue,
                                  size: 25,
                                )),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Content field can' 't be  null';
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: 17,
                          ),
                          ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blue),
                              ),
                              onPressed: () async {
                                final image =
                                    await FilePicker.platform.pickFiles(
                                        allowMultiple: false,
                                        allowedExtensions: [
                                          // 'png',
                                          'jpg',
                                          // 'jpeg',
                                        ],
                                        type: FileType.custom);
                                if (image == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text('No image selected')));
                                }
                                imgpath = image!.files.single.path!;
                                imgname = image.files.single.name;
                              },
                              child: Text(
                                'Upload Image',
                                style: TextStyle(color: Colors.white),
                              )),
                          ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blue),
                              ),
                              onPressed: () async {
                                final video =
                                    await FilePicker.platform.pickFiles(
                                        allowMultiple: false,
                                        allowedExtensions: [
                                          'mp4',
                                        ],
                                        type: FileType.custom);
                                if (video == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text('No Video selected')));
                                }
                                videopath = video!.files.single.path!;
                                videoname = video.files.single.name;
                              },
                              child: Text(
                                'Upload Video',
                                style: TextStyle(color: Colors.white),
                              )),
                          TextButton.icon(
                            icon: Icon(Icons.add, color: Colors.blue),
                            label: Text(
                              'Post Question',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () async {
                              if (_form.currentState!.validate()) {
                                File imagepath = File(imgpath);
                                File vidpath = File(videopath);
                                FirebaseStorage storage =
                                    FirebaseStorage.instance;
                                int number = Random().nextInt(10000);
                                var date = DateTime.now();
                                storage
                                    .ref()
                                    .child('Question Image')
                                    .child(
                                        "${number.toString() + date.toString()}")
                                    .putFile(imagepath)
                                    .whenComplete(() async {
                                  String imgurl = await storage
                                      .ref()
                                      .child('Question Image')
                                      .child(
                                          "${number.toString() + date.toString()}")
                                      .getDownloadURL();
                                  await storage
                                      .ref('Question video')
                                      .child(
                                          "${number.toString() + date.toString()}")
                                      .putFile(vidpath)
                                      .whenComplete(() async {
                                    String videourl = await storage
                                        .ref()
                                        .child('Question video')
                                        .child(
                                            "${number.toString() + date.toString()}")
                                        .getDownloadURL();
                                    await FirebaseFirestore.instance
                                        .collection('Question')
                                        .add({
                                      'Question': titlecontroller.text,
                                      'Content': contentcontroller.text,
                                      'Thumbnail': imgurl,
                                      'Video': videourl,
                                      'LikeCount': 0,
                                      'Dislikecount': 0
                                    });
                                    Navigator.pop(context);
                                  });
                                });
                              }
                              ;
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
