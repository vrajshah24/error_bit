import 'package:error_bit/answer.dart';
import 'package:error_bit/videoplayer_actual.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class questionList extends StatefulWidget {
  const questionList({Key? key}) : super(key: key);

  @override
  State<questionList> createState() => _questionListState();
}

class _questionListState extends State<questionList> {
  bool dislike = false;
  bool like = false;
  bool playing = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue.shade400,
        //   shadowColor: Colors.black54,
        title: InkWell(
          onDoubleTap: () => Navigator.pushNamed(context, '/video_upload'),
          child: Text(
            'Questions',
          ),
        ),
        foregroundColor: Colors.white,
        iconTheme: IconThemeData(size: 30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(200),
            bottomLeft: Radius.circular(0),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Question').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  String id = snapshot.data!.docs[index].id;
                  int likecount = snapshot.data!.docs[index]['LikeCount'];
                  String thumbnail = snapshot.data!.docs[index]['Thumbnail'];
                  String question = snapshot.data!.docs[index]['Question'];
                  String content = snapshot.data!.docs[index]['Content'];
                  String video = snapshot.data!.docs[index]['Video'];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => answer(
                                    content: content,
                                    like: likecount,
                                    question: question,
                                    thumbnail: thumbnail,
                                    video: video,
                                    id: id,
                                  )));
                    },
                    child: Column(
                      children: [
                        Card(
                          color: Colors.blue.shade200,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height / 4,
                                width: MediaQuery.of(context).size.width - 10,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    thumbnail,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      question,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      content,
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                            onTap: (() async {
                                              int flag = 0;
                                              if (flag != 0 && like == false) {
                                                await FirebaseFirestore.instance
                                                    .collection('Question')
                                                    .doc(id)
                                                    .update({
                                                  'LikeCount': likecount - 1
                                                });
                                              } else {
                                                flag++;
                                                await FirebaseFirestore.instance
                                                    .collection('Question')
                                                    .doc(id)
                                                    .update({
                                                  'LikeCount': likecount + 1
                                                });
                                              }
                                              setState(() {
                                                if (!like) {
                                                  like = true;
                                                } else {
                                                  like = false;
                                                }
                                              });
                                            }),
                                            child: Column(
                                              children: [
                                                Icon(like
                                                    ? Icons.thumb_up_alt
                                                    : Icons
                                                        .thumb_up_alt_outlined),
                                                Text(likecount.toString())
                                              ],
                                            )),
                                        TextButton.icon(
                                          onPressed: (() {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  videoPlayer_actual(
                                                      video: video),
                                            ));
                                          }),
                                          icon: playing
                                              ? Icon(
                                                  Icons.pause,
                                                  color: Colors.black,
                                                )
                                              : Icon(
                                                  Icons.play_arrow,
                                                  color: Colors.black,
                                                ),
                                          label: Text(
                                            "Play Video",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  );
                });
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
