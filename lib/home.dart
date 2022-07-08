import 'package:error_bit/forgot_password.dart';
import 'package:error_bit/screen2.dart';
import 'package:error_bit/screen3.dart';
import 'package:error_bit/screen4.dart';
import 'package:error_bit/signin.dart';
import 'package:error_bit/video_upload.dart';
import 'package:error_bit/videoplayer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, value}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentindex = 0;
  final screens = [HomeScreen(), Signin(), Video_upload(), Forgotpassword()];
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
              'Error Bit',
              style: GoogleFonts.sacramento(fontSize: 25, color: Colors.black),
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
        drawer: Drawer(
          backgroundColor: Colors.blue.shade300,
          child: Container(
            child: ListView(
              children: [
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  title: Text(
                    'Home',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  leading: Icon(
                    LineIcons.campground,
                    color: Colors.white,
                    size: 35,
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  onTap: () {
                    Navigator.pushNamed(context, '/');
                  },
                ),
                Divider(
                  thickness: 1.0,
                  indent: 20,
                  endIndent: 0,
                  // color: Colors.black45,
                ),
                ListTile(
                  title: Text('Forget Password',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  leading: Icon(
                    LineIcons.passport,
                    color: Colors.white,
                    size: 35,
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  onTap: () {
                    Navigator.pushNamed(context, '/forgotpassword');
                  },
                ),
                Divider(
                  thickness: 1.0,
                  indent: 20,
                  endIndent: 30,
                  //color: Colors.black45,
                ),
                ListTile(
                  title: Text('Sign In',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  leading: Icon(
                    LineIcons.phone,
                    color: Colors.white,
                    size: 35,
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  onTap: () {
                    Navigator.pushNamed(context, '/signin');
                  },
                ),
                Divider(
                  thickness: 1.0,
                  indent: 20,
                  endIndent: 60,
                  //color: Colors.black45,
                ),
                ListTile(
                  title: Text('Upload Video',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  leading: Icon(
                    LineIcons.arrowCircleUp,
                    color: Colors.white,
                    size: 35,
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  onTap: () {
                    Navigator.pushNamed(context, '/video_upload');
                  },
                ),
                Divider(
                  thickness: 1.0,
                  indent: 20,
                  endIndent: 60,
                  //color: Colors.black45,
                ),
                ListTile(
                  title: Text('Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  leading: Icon(
                    LineIcons.userGraduate,
                    color: Colors.white,
                    size: 35,
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  onTap: () {
                    Navigator.pushNamed(context, '/home');
                  },
                ),
                Divider(
                  thickness: 1.0,
                  indent: 20,
                  endIndent: 60,
                  //color: Colors.black45,
                ),
                ListTile(
                  title: Text('Upload Question',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  leading: Icon(
                    LineIcons.userGraduate,
                    color: Colors.white,
                    size: 35,
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  onTap: () {
                    Navigator.pushNamed(context, '/question');
                  },
                ),
                Divider(
                  thickness: 1.0,
                  indent: 20,
                  endIndent: 40,
                  //color: Colors.black45,
                ),
                ListTile(
                  title: Text('View Question',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  leading: Icon(
                    LineIcons.question,
                    color: Colors.white,
                    size: 35,
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  onTap: () {
                    Navigator.pushNamed(context, '/questionList');
                  },
                ),
              ],
            ),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("Videos").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final services = snapshot.data!.docs;
              return Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 5),
                  itemCount: services.length,
                  itemBuilder: (context, index) {
                    var videoURL = snapshot.data!.docs[index]['Video'];
                    var thumbnail = snapshot.data!.docs[index]['Thumbnail'];
                    var likeCounter = snapshot.data!.docs[index]['LikeCount'];
                    var dislikeCounter =
                        snapshot.data!.docs[index]['Dislikecount'];
                    var id = snapshot.data!.docs[index].id;
                    return InkWell(
                      onTap: (() => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => Videoplayer(
                                      videoid: id,
                                      video: videoURL,
                                      thumbnail: thumbnail,
                                      likecount: likeCounter,
                                      dislikecount: dislikeCounter,
                                    )),
                          )),
                      child: Container(
                        padding: EdgeInsets.only(bottom: 30),
                        child: Container(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              // side: BorderSide(
                              //   width: 1,
                              //   // color: Colors.blue.shade500,
                              // )
                            ),
                            child: Container(
                              margin: EdgeInsets.only(bottom: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height / 5,
                                    width: 355,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        services[index]['Thumbnail'],
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.only(left: 20, right: 20),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          services[index]['Title'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              color: Colors.black,
                                              fontSize: 12),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          services[index]['Content'],
                                          style: TextStyle(
                                              color: Colors.blue.shade300,
                                              fontSize: 9),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
            return CircularProgressIndicator();
          },
        )
        //   body: screens[currentindex],
        //   bottomNavigationBar: ClipRRect(
        //     borderRadius: const BorderRadius.only(
        //       topRight: Radius.circular(25),
        //       topLeft: Radius.circular(25),
        //     ),
        //     child: Container(
        //       decoration: BoxDecoration(
        //         color: Colors.orange,
        //         border: Border(
        //           top: BorderSide(color: Colors.orange.shade700, width: 4.0),
        //         ),
        //       ),
        //       child: BottomNavigationBar(
        //         selectedIconTheme: IconThemeData(size: 35),
        //         unselectedIconTheme: IconThemeData(size: 25),
        //         showSelectedLabels: true,
        //         fixedColor: Colors.orange.shade700,
        //         //backgroundColor: Colors.blue.shade400,
        //         type: BottomNavigationBarType.shifting,
        //         currentIndex: currentindex,
        //         onTap: (value) => setState(() {
        //           currentindex = value;
        //         }),
        //         items: [
        //           BottomNavigationBarItem(
        //             icon: Icon(
        //               LineIcons.campground,
        //               color: Colors.blue.shade400,
        //             ),
        //             label: 'Home',
        //             // backgroundColor: Colors.blue.shade400,
        //           ),
        //           BottomNavigationBarItem(
        //             icon: Icon(
        //               LineIcons.calendarCheck,
        //               color: Colors.blue.shade400,
        //             ),
        //             label: 'Calender',
        //             //backgroundColor: Colors.blue.shade400,
        //           ),
        //           BottomNavigationBarItem(
        //             icon: Icon(
        //               LineIcons.comment,
        //               color: Colors.blue.shade400,
        //             ),
        //             label: 'News',
        //             //backgroundColor: Colors.blue.shade400,
        //           ),
        //           BottomNavigationBarItem(
        //             icon: Icon(
        //               LineIcons.image,
        //               color: Colors.blue.shade400,
        //             ),
        //             label: 'Gallery',
        //             //backgroundColor: Colors.blue.shade400,
        //           )
        //         ],
        //       ),
        //     ),
        //   ),
        );
  }
}
