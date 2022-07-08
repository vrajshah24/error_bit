import 'dart:io';
import 'dart:math';
import 'package:error_bit/addcomment.dart';
import 'package:error_bit/comment1.dart';
import 'package:error_bit/videoplayer_actual.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Videoplayer extends StatefulWidget {
  final String videoid;
  final String video;
  final String thumbnail;
  final int likecount;
  final int dislikecount;
  const Videoplayer(
      {Key? key,
      required this.videoid,
      required this.video,
      required this.thumbnail,
      required this.likecount,
      required this.dislikecount})
      : super(key: key);
  @override
  State<Videoplayer> createState() => _VideoplayerState();
}

class _VideoplayerState extends State<Videoplayer> {
  late VlcPlayerController _videoPlayerController;
  Future<void> initializePlayer() async {}
  final int playerWidth = 640;
  final int playerHeight = 360;
  @override
  void initState() {
    super.initState();
    _videoPlayerController = VlcPlayerController.network(
      widget.video,
      hwAcc: HwAcc.full,
      autoPlay: true,
      options: VlcPlayerOptions(),
    );
  }

  @override
  void dispose() async {
    super.dispose();
    await _videoPlayerController.stopRendererScanning();
  }

  TextEditingController comment = TextEditingController();
  bool dislike = false;
  bool like = false;
  bool playing = true;
  bool visible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                  width: MediaQuery.of(context).size.width,
                  child: InkWell(
                      onTap: (() {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              videoPlayer_actual(video: widget.video),
                        ));
                      }),
                      child: Image.network(widget.thumbnail))),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                          onTap: (() async {
                            int flag = 0;
                            if (flag != 0 && like == false) {
                              await FirebaseFirestore.instance
                                  .collection('Videos')
                                  .doc(widget.videoid)
                                  .update({'LikeCount': widget.likecount - 1});
                            } else {
                              flag++;
                              await FirebaseFirestore.instance
                                  .collection('Videos')
                                  .doc(widget.videoid)
                                  .update({'LikeCount': widget.likecount + 1});
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
                                  : Icons.thumb_up_alt_outlined),
                              Text(widget.likecount.toString())
                            ],
                          )),
                      TextButton.icon(
                        onPressed: (() {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                videoPlayer_actual(video: widget.video),
                          ));
                        }),
                        icon: playing
                            ? Icon(Icons.pause)
                            : Icon(Icons.play_arrow),
                        label: Text(""),
                      ),
                      InkWell(
                          onTap: (() async {
                            int flag = 0;
                            if (flag != 0 && dislike == false) {
                              await FirebaseFirestore.instance
                                  .collection('Videos')
                                  .doc(widget.videoid)
                                  .update({
                                'Dislikecount': widget.dislikecount - 1
                              });
                            } else {
                              await FirebaseFirestore.instance
                                  .collection('Videos')
                                  .doc(widget.videoid)
                                  .update({
                                'Dislikecount': widget.dislikecount + 1
                              });
                              flag++;
                            }
                            setState(() async {
                              if (!dislike) {
                                dislike = true;
                              } else {
                                dislike = false;
                              }
                            });
                          }),
                          child: Column(
                            children: [
                              Icon(dislike
                                  ? Icons.thumb_down_alt
                                  : Icons.thumb_down_alt_outlined),
                              Text(widget.dislikecount.toString())
                            ],
                          ))
                    ],
                  ),
                  Container(
                    height: 500,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("Videos")
                          .doc(widget.videoid)
                          .collection('Comments')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: ((context, index) {
                                String comid = snapshot.data!.docs[index].id;
                                return Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text(snapshot.data!.docs[index]
                                            ['comment']),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            TextButton.icon(
                                                onPressed: (() {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              comment1(
                                                                  videoid: widget
                                                                      .videoid,
                                                                  comid:
                                                                      comid)));
                                                }),
                                                icon: Icon(Icons.podcasts),
                                                label: Text('Reply')),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }));
                        } else {
                          return Image.asset('assets/nodata.png');
                        }
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: (() {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => addComment(
                    video: widget.video,
                    id: widget.videoid,
                  )));
        }),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xFF2196F3)),
            height: 50,
            child: Padding(
              padding: const EdgeInsets.only(left: 28, right: 28),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Post your comment here'),
                  IconButton(
                    onPressed: () => null,
                    icon: Icon(Icons.send),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
