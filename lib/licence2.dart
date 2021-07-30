
import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:fire99/adsManger.dart';
import 'package:fire99/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:url_launcher/url_launcher.dart';



class licence2 extends StatefulWidget {

 /* final ud;
  final img;
  licence2(this.ud,this.img);*/

  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<licence2> {
  String allposts;



  String v;
  TextEditingController _searchController = TextEditingController();
  Future resultsLoaded;



  final _nativeAdController = NativeAdmobController();
  AdmobBannerSize bannerSize;
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  AdmobInterstitial intersitialAd;

  @override
  void initState() {

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


    void handleEvent(
        AdmobAdEvent event, Map<String, dynamic> args, String adType) {
      switch (event) {
        case AdmobAdEvent.loaded:
          showSnackBar('New Admob $adType Ad loaded!');
          break;
        case AdmobAdEvent.opened:
          showSnackBar('Admob $adType Ad opened!');
          break;
        case AdmobAdEvent.closed:
          showSnackBar('Admob $adType Ad closed!');
          break;
        case AdmobAdEvent.failedToLoad:
          showSnackBar('Admob $adType failed to load. :(');
          break;
        case AdmobAdEvent.rewarded:
          showDialog(
            context: scaffoldState.currentContext,
            builder: (BuildContext context) {
              return WillPopScope(
                child: AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text('Reward callback fired. Thanks Andrew!'),
                      Text('Type: ${args['type']}'),
                      Text('Amount: ${args['amount']}'),
                    ],
                  ),
                ),
                onWillPop: () async {
                  scaffoldState.currentState.hideCurrentSnackBar();
                  return true;
                },
              );
            },
          );
          break;
        default:
      }
    }




  }

  @override
  void dispose() {
    intersitialAd.dispose();
    _nativeAdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final user = FirebaseAuth.instance.currentUser;
    // final userData =FirebaseFirestore.instance.collection('users').doc(user.uid).get();

    return Scaffold(
        backgroundColor: Colors.white,
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
                        Text(" D ",style:TextStyle(color:Colors.purple,fontWeight:FontWeight.w300,fontSize:22)),
                        Text(" K",style:TextStyle(color:Colors.pink,fontWeight:FontWeight.w300,fontSize:22)),
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
        // drawer: SidebarPage(),

        body:
        Container(
            color: Colors.white,
            child: Column(
                children: [
                  Container(
                      width:200,
                      height:20,
                      child:NativeAdmob(
                        adUnitID:AdsManger.nativeAdunit,
                        numberAds:3,
                        controller: _nativeAdController,
                        type:NativeAdmobType.banner,
                      )
                  ),
                  Container(
                      width:200,
                      height:60,
                      child:Center(
                        child: Text("All licences",style:TextStyle(color:Colors.red,fontWeight:FontWeight.w400,fontSize:23,)
                  ),
                      )
                  ),

                  SizedBox(
                    height:7,
                  ),
                  Flexible(
                    //child: Expanded(
                    child: StreamBuilder(

                        stream:
                        FirebaseFirestore.instance.collection('lic')
                            //.where("img",isEqualTo:widget.img)
                            .snapshots(),
                        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {

                          final docs =snapshot.data.docs;
                          // int len=docs.length;

                          if (!snapshot.hasData) return Center(child: Text('Loading'));

                          if(snapshot.hasData==null) return Center(child: Text('Loading'));

                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return new Text('Loading...');
//.where("category", isEqualTo:"tec")
                            default:

                              return ListView.builder(
                                  itemCount: snapshot.data.documents.length,
                                  itemBuilder: (context, index) {
                                    DocumentSnapshot posts = snapshot.data.documents[index];
                                    // int len=snapshot.data.documents.length;
                                    if(snapshot.data == null) return CircularProgressIndicator();
                                    // (profile.imgUrl == null) ? AssetImage('images/user-avatar.png') : NetworkImage(profile.imgUrl)
                                    return
                                      Container(
                                        color: Colors.white,
                                        child: Column(
                                          children: <Widget>[

                                            Container(
                                              padding: EdgeInsets.all(10),
                                              height: 320,
                                              //  color: Color.fromRGBO(41, 30, 83, 1),
                                              width: MediaQuery.of(context).size.width / 1.1,
                                              child: InkWell(
                                                child: Card(
                                                  child:
                                                  Container(
                                                    //backgroundImage: (profile.imgUrl == null) ? AssetImage('images/user-avatar.png') : NetworkImage(profile.imgUrl)
                                                    child:
                                                    Image.network(posts.data()['img']??" ",
                                                        fit: BoxFit.fill),
                                                  ),
                                                ),
                                                onTap: ()  {


                                                },
                                              ),
                                            ),


                                          ],
                                        ),

                                      );
                                  });
                          }
                        }
                    ),
                  ),
                  //),


                  /*      AdmobBanner(adUnitId: AdsManger.BannerAdUnitIdEX,
                       adSize:AdmobBannerSize.SMART_BANNER
                       ),
*/
                  /*       Container(
                    color: Colors.lightGreen,
                    //padding: const EdgeInsets.only(top:60),
                    child: CurvedNavigationBar(
                        color:Colors.white,
                        backgroundColor: Colors.lightGreenAccent,
                        //buttonBackgroundColor:Colors.blue,
                        items:<Widget>[

                          Icon(Icons.home,size:24,color:Colors.black),
                          //  Icon(Icons.add_box,size:24,color:Colors.blue),
                      //    Icon(Icons.messenger_rounded,size:24,color:Colors.black),
                          // Icon(IcoRns.account_circle,size:24,color:Colors.white),
                        ],

                        animationCurve:Curves.bounceOut,
                        onTap:(index) async {
                          final user = FirebaseAuth.instance.currentUser;
                          final userData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
                          String ud=userData['username'];


                          /* if(index==1)
                         {
                           intersitialAd.show();
                           Navigator.push(
                               context,
                               MaterialPageRoute(builder: (context) {
                             return AddPost();
                           }));
                      }*/
                          if(index==1){
                            intersitialAd.show();
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>ChatScreen2(ud)));
                          }
                        }

                    ),
                  )

                ]),
          ),
*/


                ])) );
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
