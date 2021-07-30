

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class survey extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

            ]
        ),
      body:Container(
        padding:EdgeInsets.all(20),
      child: WebView(
        javascriptMode:JavascriptMode.unrestricted,
      initialUrl: 'https://www.pollfish.com/dashboard/dev/',
      )
      )
    );
  }
}
