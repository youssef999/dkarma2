
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire99/home_screen.dart';
import 'package:fire99/sendl.dart';
import 'package:fire99/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fire99/login.dart';
import 'package:fire99/saveImage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';


class licences extends StatefulWidget {
  String name, price, des, imgLocation, category , kinds;

  final String ud;
  licences(this.ud);
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<licences> {
  //String imagepath;
  String valuechoose;
  List listitem =["Landscape","Portrait","Wildlife","Aerial","Others"];



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

      _url = await (await task).ref.getDownloadURL();

      await Firestore.instance.collection('posts5').add({
        'name': name.text,
        'img': _url.toString,
        'cat': valuechoose,
        'price': price.text,
        'kind': kind.text,
        'nameUs':widget.ud,
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

        backgroundColor:Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.grey[850],
            iconTheme: IconThemeData(color: Colors.white),
            title:Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      // Colors.white,
                      Colors.grey[850],
                      //Colors.lightBlueAccent,
                      Colors.grey[850],
                      // Colors.lightBlueAccent,
                      //Colors.white,
                    ])),
                height:30,
                child: Center(
                    child: Row(
                      children: [
                        SizedBox(
                          width:8,
                        ),
                        /* Container(
                 width:80,
                 child:Image.asset('assets/l1.jfif')
               ),*/
                        Text( "Deal",style:TextStyle(color:Colors.red,fontWeight:FontWeight.w700,fontSize:17)),
                        Text(" Karma",style:TextStyle(color:Colors.white,fontWeight:FontWeight.w700,fontSize:17)),
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
                  color:Colors.amber,
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
        //drawer: SidebarPage2(),
        body:
        Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color:Colors.grey[850],
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
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
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
                        width: 30,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.red,
                        backgroundImage:
                        _image == null ? null : FileImage(_image),
                        radius: 80,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        child: Icon(Icons.clear,size: 40,color:Colors.red),
                        onTap: clearr,
                      ),
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
*/






                    ],
                  ),

                  Column(
                    children: <Widget>[
                /*      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: name,
                        cursorColor:Colors.red,
                        style: TextStyle(fontSize: 18, color: Colors.red),
                        decoration: InputDecoration(
                            hintText: ' Name',
                            hintStyle:TextStyle(color:Colors.red,),
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
                        cursorColor:Colors.red,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                        decoration: InputDecoration(
                            hintText: 'Description',
                            hintStyle:TextStyle(color:Colors.red,),
                            border:OutlineInputBorder(

                              borderSide: const BorderSide(color: Colors.red, width: 2.0),
                              borderRadius: BorderRadius.circular(25.0),

                            )


                        ),
                        *//* validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Enter Description';
                          }
                        },*//*
                      ),
                      SizedBox(
                        height: 30,
                      ),


                      Container(
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
                      SizedBox(
                        height: 5,
                      ),

*/



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
                              'Send the licences ',

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

                               //  send(_url.toString());

                             //   Share.share(_url.toString());
                           /*  Utils.openEmail(
                                  toEmail:'Info@dealkarma.net',
                                  sub:(_url.toString()),
                                    body:'licences'
                                );*/
                                FirebaseFirestore.instance.collection('lic').document()
                                    .setData({
                                  'img': _url.toString(),
                                  'user': {
                                    'name':widget.ud,
                                  }
                                });
                               // sendWhatsApp('+201097970465',_url.toString());
                                final user = FirebaseAuth.instance.currentUser;
                                final userData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
                                String ud=userData['username'];

                              /*  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return sendl(ud,_url.toString());
                                    }));*/
                              }
                            }),
                      ),
                     /* Container(
                        child:RaisedButton(
                          onPressed:,
                        )
                      )
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




  /*Future uploadImage(context) async {
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
  }*/

  Future clearr() {
    setState(() {
      _image = null;
    });
  }

  sendWhatsApp(String phone,String msg)async{

    String url(){
      if(Platform.isAndroid){
        return 'whatsapp://send?phone=$phone&text=$msg';
        //  return 'whatsapp://wa.me/$phone/?text=${Uri.parse(msg)}';
      }
      else{
        return 'whatsapp://send?phone=$phone&text=$msg';
        //  return 'whatsapp://send?$phone=phone&text=$msg';
        //   return 'whatsapp://wa.me/$phone&text=$msg';
      }
    }

    await canLaunch(url())?launch(url()) : ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('there is no whats app in your device')));
  }

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
