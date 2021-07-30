import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire99/home_screen.dart';
import 'package:fire99/register2.dart';
import 'package:fire99/reset.dart';
import 'package:fire99/screen2.dart';
import 'package:fire99/videoscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/painting.dart';
import 'Helpers/remember_me.dart';
import 'colorr.dart';
import 'licence2.dart';
import 'register2.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

class LoginScreen3 extends StatefulWidget {
  static const routeName = './login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen3> {
 // bool isRememberMe = false;
 // final GoogleSignIn _googleSignIn = GoogleSignIn();

  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }

  final _formkey = GlobalKey<FormState>();

  TextEditingController _emailcontroller = TextEditingController();

  TextEditingController _passwordcontroller = TextEditingController();

  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:btnforGroundColr,
        /* appBar: AppBar(
          backgroundColor: Colors.indigo[900],
          iconTheme: IconThemeData(color: Colors.red),
          title:Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                     Colors.white,

                    Colors.lightBlueAccent,

                    // Colors.lightBlueAccent,
                    //Colors.white,
                  ])),
              height:30,
              child: Center(
                  child: Row(
                    children: [
                      SizedBox(
                        width:40,
                      ),
                      / / Container(
                 width:80,
                 child:Image.asset('assets/l1.jfif')
               ),/ /
                      Text( " Coin",style:TextStyle(color:Colors.red,fontWeight:FontWeight.bold,fontSize:23)),
                      Text( "s",style:TextStyle(color:Colors.white,fontWeight:FontWeight.bold,fontSize:23)),
                      //  Text("  Broker",style:TextStyle(color:Colors.lightBlue,fontWeight:FontWeight.bold,fontSize:21)),
                    ],
                  ))
          ),
          //backgroundColor: Colors.lightBlueAccent,
          actions: <Widget>[
            SizedBox(
              height:10,
            ),




          ]
      ),*/
        body: Container(
          color: btnforGroundColr,
          //Color.fromRGBO(41, 30, 83, 1),
          padding: EdgeInsets.all(16),

          child: SingleChildScrollView(
            child: Form(
                key: _formkey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    Row(children: <Widget>[

                      Center(
                          child: Text(
                            'Login',
                            style: TextStyle(
                                fontFamily:'',
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w900),
                          )),

                    ]),
                    Container(
                      width: 400,
                      height: 150,
                      color: Colors.lightBlueAccent[300],
                      child: Image.asset('assets/signup.png'),
                    ),
                    SizedBox(height: 15),

                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      //Password/
                      cursorColor: Colors.deepPurple,
                      obscureText: true,
                      controller: _passwordcontroller,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      decoration: InputDecoration(
                        labelText: ' Password',
                        hintText: 'Enter Admin password ',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.deepPurple, width: 2.0),
                          borderRadius: BorderRadius.circular(30.0),

                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide()
                        ),
                        // fillColor: Colors.white,
                        filled: true,
                        fillColor: Colors.white,


                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 15,

                        ),
                        labelStyle:TextStyle(
                          fontSize: 18,
                          color: Colors.deepPurple,

                        ),
                        prefixIcon: Icon(Icons.lock, color: Colors.deepPurple),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Fill Password Input';
                        }
                        return null;
                      },
                    ),
                  /*  CheckboxListTile(
                        activeColor: Colors.deepPurple,
                        title: Text('Remember me',
                            style: TextStyle(color: Colors.deepPurple)),
                        value: isRememberMe,
                        onChanged: (value) async {
                          isRememberMe = value;

                          setState(() {});
                        }),*/
                    SizedBox(
                      height: 3,
                    ),
                    Container(
                      width: 320,
                      child: Container(
                        // color:  Colors.purple,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius:
                            BorderRadius.all(Radius.circular(30)),),
                          child: FlatButton(
                            color: Colors.transparent,
                            child: Text(
                              'Login',
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () async {


                              if (_formkey.currentState.validate()) {

                                 if(_passwordcontroller.text=='123456'){
                                   Navigator.push(
                                       context,
                                       MaterialPageRoute(builder: (context) {
                                         return licence2();
                                       }));
                                 }
                                 else{
                                   showDialog(
                                       context: context,
                                       builder: (_) => new AlertDialog(
                                         title: new Text("wrong "),
                                         content: new Text("you Entered Wrong password"),
                                       ));
                                 }
                              }
                            },
                          ),
                        ),

                      ),
                    ),
                 /*   TextButton(
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResetScreen()),);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        //padding: EdgeInsets.only(left:15,bottom:15,right:15),
                        //alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text('Forgot Password ?',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400,
                                    color: kPrimaryColor)),


                          ],
                        ),
                      ),
                    ),*/

                    Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Divider(
                                  thickness: 1,
                                ),
                              ),
                            ),

                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Divider(
                                  thickness: 1,
                                ),
                              ),
                            ),
                          ],
                        )),





                    SizedBox(
                      height: 10,
                    ),




                  ],
                )),
          ),
        ));
  }


}
