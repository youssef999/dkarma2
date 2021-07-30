


import 'dart:io';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire99/adsManger.dart';
import 'package:fire99/catlog.dart';
import 'package:fire99/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fire99/login.dart';
import 'package:fire99/saveImage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';



class AddPost extends StatefulWidget {
  String name, price, des, imgLocation, category , kinds;

   final String ud;
   AddPost(this.ud);
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  //String imagepath;
  String valuechoose;
  List listitem =["Landscape","Portrait","Wildlife","Aerial","Others"];
 
  final _nativeAdController = NativeAdmobController();
   AdmobBannerSize bannerSize;
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
   AdmobInterstitial intersitialAd;
  @override
  void initState() {
    setState(() {
    
    });
    super.initState();
  bannerSize = AdmobBannerSize.BANNER;

    intersitialAd = AdmobInterstitial(
        adUnitId:   AdsManger.interstitialAd,
        listener: (AdmobAdEvent event, Map<String, dynamic> args) {
          if (event == AdmobAdEvent.closed) intersitialAd.load();
        //  handleEvent(event, args, 'Interstitial');
        });
        intersitialAd.load();
       
  _nativeAdController.reloadAd(forceRefresh:true);
    



    void showSnackBar(String content) {

      scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text(content),
          duration: Duration(milliseconds: 1500),
        ),
      );
    }
  }
  

  final _formkey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();

  TextEditingController des = TextEditingController();

  TextEditingController price = TextEditingController();

  TextEditingController cat = TextEditingController();

  TextEditingController img = TextEditingController();

  TextEditingController mob = TextEditingController();
  File _image;
  String _url;

  /*sendData2() async {
    if (_formkey.currentState.validate()) {
      var storageImage = FirebaseStorage.instance.ref().child(_image.path);

      var task = storageImage.putFile(_image);

      _url = await (await task.onComplete).ref.getDownloadURL();

      await Firestore.instance.collection('posts5').add({
        'name': name.text,
        'img': _url.toString,
        'cat': valuechoose,
       'price': price.text,
        'mobile': mob.text,
        'nameUs':widget.ud,
      });
    }
  }
*/
  @override
  void dispose() {
    name.dispose();
    des.dispose();
    price.dispose();
    mob.dispose();
   intersitialAd.dispose();
   _nativeAdController.dispose();
    super.dispose();
  }
  updatePost(String ID) {
    Firestore.instance.collection('posts5').document(ID).setData({
      'title': "Title Edited",
      'description': "Description Edited"
    }).then((value) {
      print('record updated successflly');
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor:Colors.white,
       appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            title:Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      // Colors.white,
                      Colors.white,
                      //Colors.lightBlueAccent,
                      Colors.white,
                      // Colors.lightBlueAccent,
                      //Colors.white,
                    ])),
                height:30,
                child: Center(
                    child: Row(
                      children: [
                        SizedBox(
                          width:29,
                        ),
                        /* Container(
                 width:80,
                 child:Image.asset('assets/l1.jfif')
               ),*/
                        Text(" D",style:TextStyle(color:Colors.purple,fontWeight:FontWeight.w300,fontSize:22)),
                        Text(" k",style:TextStyle(color:Colors.pink,fontWeight:FontWeight.w300,fontSize:22)),
                        //  Text("  Broker",style:TextStyle(color:Colors.lightBlue,fontWeight:FontWeight.bold,fontSize:21)),
                      ],
                    ))
            ),
            //backgroundColor: Colors.lightBlueAccent,
            actions: <Widget>[
              SizedBox(
                height:5,
              ),
              IconButton(
                  color:Colors.red,
                  icon: Icon(Icons.logout,size:32,),
                  onPressed: () async {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return  LoginScreen();
                        }));

                  })



            ]
        ),
      //  drawer: SidebarPage2(),
        body:
        Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color:Colors.purple,
                // color:Colors.lightBlueAccent,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  topLeft:Radius.circular(30),
                  topRight:Radius.circular(30),
                  bottomRight: Radius.circular(50),
                )
            ),
            child:
            Form(
                key: _formkey,
                child: ListView(children: <Widget>[
                   Container(
                      width:200,
                      height:60,
                      child:NativeAdmob(
                        adUnitID:AdsManger.nativeAdunit,
                        numberAds:3,
                        controller: _nativeAdController,
                        type:NativeAdmobType.banner,
                      )
                  ),

                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),

                      Column(
                        children: [
                          GestureDetector(
                              child: Icon(Icons.image,size:40,color:Colors.white,),
                              onTap: pickImage
                          ),
                          SizedBox(
                            height:30
                          ),
                          GestureDetector(
                              child: Icon(Icons.camera,size:40,color:Colors.white,),
                              onTap: pickImage2
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage:
                        _image == null ? null : FileImage(_image),
                        radius: 80,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        child: Icon(Icons.clear,size:25,color:Colors.red),
                        onTap: clearr,
                      ),
                     
/*SizedBox(
  height:200,
  width:160,
  child:InkWell(
  child: Container(decoration: BoxDecoration(
  image: DecorationImage(image: AssetImage('assets/addphoto.png')),
  borderRadius: BorderRadius.all(Radius.circular(200))
  ),

  ),
  onTap:(){pickImage();
 setState(() {
  _image == null ? null : FileImage(_image);
 });


  },


  ),

),*/

                    ],
                  ),

                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: name,
                        cursorColor:Colors.blue,
                        style: TextStyle(fontSize:21, color: Colors.blue),
                        decoration: InputDecoration(
                            hintText: ' Name',
                            hintStyle:TextStyle(color:Colors.blue,),
                            border:OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white, width: 2.0),
                              borderRadius: BorderRadius.circular(25.0),

                            )
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Enter Name ';
                          }

                        },

                      ),
                      SizedBox(
                        height: 5,
                      ),

                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: des,
                        cursorColor:Colors.blue,
                        style: TextStyle(fontSize:21, color: Colors.blue),
                        decoration: InputDecoration(
                            hintText: 'Description',
                            hintStyle:TextStyle(color:Colors.blue,),
                            border:OutlineInputBorder(

                              borderSide: const BorderSide(color: Colors.red, width: 2.0),
                              borderRadius: BorderRadius.circular(25.0),

                            )


                        ),
                       /* validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Enter Description';
                          }
                        },*/
                      ),
                       SizedBox(
                        height: 30,
                      ),
                       TextFormField(
                        controller: price,
keyboardType: TextInputType.number,
                        cursorColor:Colors.blue,
                        style: TextStyle(fontSize:21, color: Colors.blue),
                        decoration: InputDecoration(
                            hintText: 'price',
                            hintStyle:TextStyle(color:Colors.blue,),
                            border:OutlineInputBorder(

                              borderSide: const BorderSide(color: Colors.red, width: 2.0),
                              borderRadius: BorderRadius.circular(25.0),

                            )


                        ),
                       /* validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Enter Description';
                          }
                        },*/
                      ),
                      SizedBox(
                        height: 30,
                      ),
                       TextFormField(
                        controller: mob,
             keyboardType: TextInputType.number,
                        cursorColor:Colors.red,
                        style: TextStyle(fontSize:21, color: Colors.blue),
                        decoration: InputDecoration(
                            hintText: 'Mobile number',
                            hintStyle:TextStyle(color:Colors.blue,),
                            border:OutlineInputBorder(

                              borderSide: const BorderSide(color: Colors.red, width: 2.0),
                              borderRadius: BorderRadius.circular(25.0),

                            )


                        ),
                       /* validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Enter Description';
                          }
                        },*/
                      ),

                        SizedBox(
                        height: 30,
                      ),


                    /*  Container(
                        padding: EdgeInsets.only(left:25,right:25),
                        decoration:BoxDecoration(border: Border.all(color:Colors.grey,width:1)
                            ,borderRadius: BorderRadius.circular(25)),
                        child:   DropdownButton(

                          hint: Text("Select Category",style:TextStyle(color:Colors.red,fontSize:17,fontWeight:FontWeight.w900),
                         ),
                          icon: Icon(Icons.arrow_drop_down),

                          iconSize: 36,

                          isExpanded: true,
                          underline: SizedBox(),

                          value: valuechoose,style:TextStyle(color:Colors.red,fontSize:17,fontWeight:FontWeight.w900),
                          onChanged:(newvalue)
                          {
                            setState(() {
                              valuechoose=newvalue;
                            });

                          },

                          items: listitem.map((valueitem){

                            return DropdownMenuItem(value: valueitem,

                              child: Text(valueitem),


                            );

                          }).toList(),


                        ),

                      ),
                      */
                      SizedBox(
                        height: 5,
                      ),





                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        width:200,
                        child: RaisedButton(
                            color: Colors.white,

                            shape: StadiumBorder(),
                            splashColor: Colors.red,
                            child: Text(
                              'Share ',

                              style: TextStyle(color: Colors.black,fontSize:21),
                            ),

                            onPressed: ()
                           async
                            {


                              if (_formkey.currentState.validate()) {


                                var storageImage = FirebaseStorage.instance
                                    .ref()
                                    .child(_image.path);

                                var task = storageImage.putFile(_image);

                                _url = await (await task)
                                    .ref
                                    .getDownloadURL();


                                FirebaseFirestore.instance.collection('posts5').document()
                                    .setData({
                                  'name': name.text ,
                                  'img': _url.toString(),
                                  'des': des.text,
                                  'cat': valuechoose,
                                  'price': "x",
                                  'mob': mob.text,
                                  'uname':widget.ud,
                                  'user': {
                                   // 'uid': currentUser.uid,
                                  //  'email': currentUser.email,
                                    'name':widget.ud,
                                  }
                                });
                                showDialog(
                                    context: context,
                                    builder: (_) => new AlertDialog(
                                      title: new Text("Done "),
                                      content: new Text("you Share new item "),
                                    ));
                                    final user = FirebaseAuth.instance.currentUser;
                    final userData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
                    String ud=userData['username'];
                                    Navigator.push(
                    context,
                              MaterialPageRoute(builder: (context) {
                              
                                return PostsScreen(ud);
                              }));
                              }
                            }),
                      ),
                      /* RaisedButton(
                        color: Colors.blue,
                        child: Text(
                          'images',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return HomeImg();
                            }),
                          );
                        },
                      ),
                      RaisedButton(
                        color: Colors.blue,
                        child: Text(
                          'Delete Post',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formkey.currentState.validate()) {
                            // Delete post

                            Firestore.instance
                                .collection('posts5')
                                .document('Wefs9XsNTeND7UXW7aXi')
                                .delete()
                                .then((onValue) {
                              print('Post Deleted Successfully');
                            });
                          }
                        },
                      )*/
                    ],
                  )
                ]))));
  }

  Future pickImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    //set state bt3ml update kol shwya

    setState(() {
      _image = image;
    });
  }

  Future pickImage2() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    //set state bt3ml update kol shwya

    setState(() {
      _image = image;
    });
  }




 /* Future uploadImage(context) async {
    try {
      FirebaseStorage storage =
      FirebaseStorage(storageBucket: 'gs://fire999-6d8b9.appspot.com');

      StorageReference ref = storage.ref().child(_image.path);
      StorageUploadTask storageUploadTask = ref.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;

      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('success'),
      ));
      String url = await taskSnapshot.ref.getDownloadURL();
      print('url $url');
      setState(() {
        _url = url;
      });
    } catch (ex) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(ex.message),
      ));
    }
  }
  Future clearr() {

    setState(() {
      _image = null;
    });
  }

}
*/


  Future clearr() {

    setState(() {
      _image = null;
    });
  }




/*

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire99/posts.dart';
import 'package:fire99/testing/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'language.dart';
import 'new.dart';
import 'new3.dart';

class AddPost extends StatefulWidget {
  String name, price, des, imgLocation, category , kinds;


  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
   final FirebaseMessaging _fcm = FirebaseMessaging();

  String valuechoose;
  List listitem =["Sports رياضي","Technology تكنولوجي","Clothes ملابس","Accessories اكسسوارات","Others اخري"];

   Language _language =Language();


  @override
  void initState() {
    super.initState();
    setState(() {
      _language.getLanguage();
    });

  }

  final _formkey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();

  TextEditingController des = TextEditingController();

  TextEditingController price = TextEditingController();

  TextEditingController cat = TextEditingController();

  TextEditingController img = TextEditingController();

  TextEditingController kind = TextEditingController();
  File _image;
  String _url;

  sendData2() async {
    if (_formkey.currentState.validate()) {
      var storageImage = FirebaseStorage.instance.ref().child(_image.path);

      var task = storageImage.putFile(_image);

      _url = await (await task.onComplete).ref.getDownloadURL();

      await Firestore.instance.collection('posts5').add({
        'name': name.text,
        'img': _url.toString,
        'cat': valuechoose,
        'price': price.text,
        'kind': kind.text,
      //  'usershare':
      });
    }
  }




  @override
  void dispose() {
    name.dispose();
    des.dispose();
    price.dispose();
    kind.dispose();
    super.dispose();
  }
  updatePost(String ID) {
    Firestore.instance.collection('posts5').document(ID).setData({
      'title': "Title Edited",
      'description': "Description Edited"
    }).then((value) {
      print('record updated successflly');
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor:Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            title:Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      // Colors.white,
                      Colors.white,
                      //Colors.lightBlueAccent,

                      // Colors.lightBlueAccent,
                      Colors.white,
                    ])),
                height:30,
                child: Center(
                    child: Row(
                      children: [
                        SizedBox(
                          width:80,
                        ),
                        Text(_language.tlanguage() ?? "MA",style:TextStyle(color:Colors.lightBlueAccent[200],fontWeight:FontWeight.bold,fontSize:23)),
                        Text(_language.tlanguage2() ?? "LL",style:TextStyle(color:Colors.black,fontWeight:FontWeight.bold,fontSize:23)),
                        //  Text("  Broker",style:TextStyle(color:Colors.lightBlue,fontWeight:FontWeight.bold,fontSize:21)),
                      ],
                    ))
            ),
            //backgroundColor: Colors.lightBlueAccent,
            actions: <Widget>[
              SizedBox(
                height:10,
              ),

              IconButton(
                  color:Colors.redAccent,
                  icon: Icon(Icons.note,size:35,),
                  onPressed: () async {
                    final user = FirebaseAuth.instance.currentUser;
                    final userData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
                    String ud=userData['username'];
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return ChatScreen(ud);
                        }));

                  })]
        ),
        drawer: SidebarPage2(),
        body:
        Container(
            padding: EdgeInsets.all(10),
            color:Colors.blueGrey[100],
            child:
            Form(
                key: _formkey,
                child: ListView(children:
                <Widget>[
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),



                      GestureDetector(
                          child: Icon(Icons.camera_alt,size: 40,),
                          onTap: pickImage
                      ),
                      SizedBox(
                        width: 30,
                      ),

                      CircleAvatar(
                        backgroundColor:Colors.lightBlueAccent[200],
                        backgroundImage:
                        _image == null ? null : FileImage(_image),
                        radius: 80,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        child: Icon(Icons.clear,size: 40,),
                        onTap: clearr,
                      ),
                      */
/*
SizedBox(
  height:200,
  width:200,
  child:InkWell(
  child: Container(decoration: BoxDecoration(
  image: DecorationImage(image: AssetImage('assets/addphoto.png')),
  borderRadius: BorderRadius.all(Radius.circular(200))
  ),

  ),
  onTap:(){pickImage();
 setState(() {
  _image == null ? null : FileImage(_image);
 });


  },


  ),

),
*//*







                    ],
                  ),

                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: name,
                        decoration: InputDecoration(
                            hintText: _language.tAdd1()??"Product Name  ",

                            border:OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white, width: 2.0),
                              borderRadius: BorderRadius.circular(25.0),

                            )
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Enter Product Name ';
                          }

                        },



                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        controller: price,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: _language.tAdd2()??"Product Price ",
                            border:OutlineInputBorder(

                              borderSide: const BorderSide(color: Colors.white, width: 2.0),
                              borderRadius: BorderRadius.circular(25.0),

                            )

                        ),
                        validator: ( value) {
                          if (value.isEmpty) {
                            return 'Please Enter Product price ';
                          }
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        controller: des,
                        decoration: InputDecoration(
                            hintText: _language.tAdd3()??"Details",
                            border:OutlineInputBorder(

                              borderSide: const BorderSide(color: Colors.white, width: 2.0),
                              borderRadius: BorderRadius.circular(25.0),

                            )


                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Enter Description';
                          }
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),


                      Container(
                        padding: EdgeInsets.only(left:25,right:25),
                        decoration:BoxDecoration(border: Border.all(color:Colors.grey,width:1)
                            ,borderRadius: BorderRadius.circular(25)),
                        child:   DropdownButton(

                          hint: Text(_language.tAdd4()??"Category"),

                          icon: Icon(Icons.arrow_drop_down),

                          iconSize: 36,

                          isExpanded: true,
                          underline: SizedBox(),

                          value: valuechoose,
                          onChanged:(newvalue)
                          {
                            setState(() {
                              valuechoose=newvalue;
                            });

                          },

                          items: listitem.map((valueitem){

                            return DropdownMenuItem(value: valueitem,

                              child: Text(valueitem),


                            );

                          }).toList(),


                        ),

                      ),
                      SizedBox(
                        height: 5,
                      ),

                      TextFormField(
                        controller: kind,
                        decoration: InputDecoration(
                            hintText: _language.tAdd5()??"KIND",

                            border:OutlineInputBorder(

                              borderSide: const BorderSide(color: Colors.white, width: 2.0),
                              borderRadius: BorderRadius.circular(25.0),

                            )
                        ),

                      ),



                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width:200,
                        child: RaisedButton(
                            color: Colors.white,

                            shape: StadiumBorder(),
                            splashColor: Colors.white,
                            child: Text(
                              _language.tshare()??"Share Product",

                              style: TextStyle(color: Colors.black,fontSize:21),
                            ),

                            onPressed: () async {


                              if (_formkey.currentState.validate()) {
                                var currentUser =
                                    FirebaseAuth.instance.currentUser;
                               // final user = FirebaseAuth.instance.currentUser;
                                final userData = await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).get();

                                var storageImage = FirebaseStorage.instance
                                    .ref()
                                    .child(_image.path);

                                var task = storageImage.putFile(_image);

                                _url = await (await task.onComplete)
                                    .ref
                                    .getDownloadURL();

                                Firestore.instance.collection('posts5').document()


                                    .setData({
                                  'name': name.text,
                                  'img': _url.toString(),
                                  'des': des.text,
                                  'cat': valuechoose,
                                  'price': price.text,
                                  'kind': kind.text,
                                  'nameUs':userData['username'],
                                  'user': {
                                    'uid': currentUser.uid,
                                    'email': currentUser.email,
                                    'nameUs':userData['username'],
                                  }
                                });
                                showDialog(
                                    context: context,
                                    builder: (_) =>
                                    new AlertDialog(
                                      title: new Text(" Done "),
                                      content: new Text("You Shared new Product "),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text(' OK '),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) {
                                                  return PostsScreen();
                                                }));

                                          },
                                        )
                                      ],
                                    ));
                              }
                            }),
                      ),
                      */
/* RaisedButton(
                        color: Colors.blue,
                        child: Text(
                          'images',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return HomeImg();
                            }),
                          );
                        },
                      ),
                      RaisedButton(
                        color: Colors.blue,
                        child: Text(
                          'Delete Post',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formkey.currentState.validate()) {
                            // Delete post

                            Firestore.instance
                                .collection('posts5')
                                .document('Wefs9XsNTeND7UXW7aXi')
                                .delete()
                                .then((onValue) {
                              print('Post Deleted Successfully');
                            });
                          }
                        },
                      )*//*

                    ],
                  )
                ]))));
  }

  Future pickImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    //set state bt3ml update kol shwya

    setState(() {
      _image = image;
    });
  }




  Future uploadImage(context) async {
    try {
      FirebaseStorage storage =
      FirebaseStorage(storageBucket: 'gs://fire999-6d8b9.appspot.com');

      StorageReference ref = storage.ref().child(_image.path);
      StorageUploadTask storageUploadTask = ref.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;

      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('success'),
      ));
      String url = await taskSnapshot.ref.getDownloadURL();
      print('url $url');
      setState(() {
        _url = url;
      });
    } catch (ex) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(ex.message),
      ));
    }
  }
  Future clearr() {

    setState(() {
      _image = null;
    });
  }

}
*/
}