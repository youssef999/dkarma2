import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire99/Helpers/alarm_manager.dart';
import 'package:fire99/Screens/alarm_screen.dart';
import 'package:fire99/addpost.dart';
import 'package:fire99/catlog.dart';
import 'package:fire99/licences.dart';
import 'package:fire99/log3.dart';
import 'package:fire99/profile.dart';
import 'package:fire99/screen2.dart';
import 'package:fire99/survey.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';

class HomeScreen extends StatefulWidget {


  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // to get size
    var size = MediaQuery.of(context).size;

    // style
    var cardTextStyle = TextStyle(


        fontSize: 14,
        color: Color.fromRGBO(63, 63, 63, 1));

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * .3,
            decoration: BoxDecoration(
              image: DecorationImage(
                  alignment: Alignment.topCenter,
                  image: AssetImage('assets/d3.png')),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 64,
                    margin: EdgeInsets.only(bottom: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 32,
                          backgroundImage: AssetImage(
                              'assets/home2.png'
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              r"""DK's Dashboard""",
                              style: TextStyle(

                                  color: Colors.white,
                                  fontSize: 20),
                            ),

                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: GridView.count(
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      primary: false,
                      crossAxisCount: 2,
                      children: <Widget>[
                        InkWell(
                          child: Card(
                            shape:RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)
                            ),
                            elevation: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                              Image.asset(
                                'assets/c1.jpg'
                                    ,height: 128,
                              ),
                                Text(
                                  'My Profile ',
                                  style: cardTextStyle,
                                )
                              ],
                            ),
                          ),
                          onTap: (){

                          },
                        ),

                        InkWell(
                          child: Card(
                            shape:RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)
                            ),
                            elevation: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                    'assets/c2.png',
height: 128,

                                ),
                                Text(
                                  ' Ads Waterfall ',
                                  style: cardTextStyle,
                                )
                              ],
                            ),
                          ),
                          onTap: (){}
                        ),

                        InkWell(
                          child: Card(
                            shape:RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)
                            ),
                            elevation: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  'assets/rr.gif'
                                  ,height: 128,
                                ),
                                Text(
                                  'Reminders ',
                                  style: cardTextStyle,
                                )
                              ],
                            ),
                          ),
                          onTap: (){Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AlarmScreen()),//navigation
                          );},
                        ),

                        InkWell(
                          child: Card(
                            shape:RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)
                            ),
                            elevation: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  'assets/c44.png'
                                  ,height: 128,
                                ),
                                Text(
                                  'Take A Survey ',
                                  style: cardTextStyle,
                                )
                              ],
                            ),
                          ),
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return survey();
                                }));
                          },
                        ),
                         InkWell(
                          child: Card(
                            shape:RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)
                            ),
                            elevation: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  'assets/c44.png'
                                  ,height: 128,
                                ),
                                Text(
                                  ' Add  ',
                                  style: cardTextStyle,
                                )
                              ],
                            ),
                          ),
                          onTap: () async {
                         final user = FirebaseAuth.instance.currentUser;
                    final userData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
                    String ud=userData['username'];

                             Navigator.push(
                                      context,
                              MaterialPageRoute(builder: (context) {
                                return AddPost(ud);
                              }));
                          },
                        ),

                        InkWell(
                          child: Card(
                            shape:RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)
                            ),
                            elevation: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  'assets/c5.png'
                                  ,height: 128,
                                ),
                                Text(
                                  'Catalog ',
                                  style: cardTextStyle,
                                )
                              ],
                            ),
                          ),
                          onTap: () async {
                                final user = FirebaseAuth.instance.currentUser;
                    final userData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
                    String ud=userData['username'];

                              Navigator.push(
                                      context,
                              MaterialPageRoute(builder: (context) {
                                return  PostsScreen(ud);
                              }));
                          },
                        ),

                        InkWell(
                          child: Card(
                            shape:RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)
                            ),
                            elevation: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  'assets/c6.png'
                                  ,height: 128,
                                ),
                                Text(
                                  'App Guide ',
                                  style: cardTextStyle,
                                )
                              ],
                            ),
                          ),
                          onTap: (){},
                        ),
                        InkWell(
                          child: Card(
                            shape:RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)
                            ),
                            elevation: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  'assets/c6.png'
                                  ,height: 128,
                                ),
                                Text(
                                  'Licences',
                                  style: cardTextStyle,
                                )
                              ],
                            ),
                          ),
                          onTap: () async {
                            final user = FirebaseAuth.instance.currentUser;
                            final userData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
                            String ud=userData['username'];

                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return licences(ud);
                                }));
                          },
                        ),
                        InkWell(
                          child: Card(
                            shape:RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)
                            ),
                            elevation: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  'assets/c6.png'
                                  ,height: 128,
                                ),
                                Text(
                                  'See All licences(for admin only) ',
                                  style: cardTextStyle,
                                )
                              ],
                            ),
                          ),
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return LoginScreen3();
                                }));
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
