import 'package:fire99/colorr.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'screen2.dart';

class videoScreen extends StatefulWidget {



  final String ud;

  videoScreen(this.ud);

  @override
  videoScreenState createState() => videoScreenState();
}

class videoScreenState extends State<videoScreen> {
  //
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.asset(
        "assets/v1.mp4");
    //_controller = VideoPlayerController.asset("videos/sample_video.mp4");
    _initializeVideoPlayerFuture = _controller.initialize();
    // _controller.setLooping(true);
    _controller.setVolume(1.0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor:Colors.deepPurple,
          title: Center(child: Text("",style:TextStyle(color:Colors.white,fontSize:24,fontStyle:FontStyle.italic))),

          actions: <Widget>[
            IconButton(
              color:Colors.white,
              icon: Icon(Icons.auto_awesome_mosaic),

            ),

            IconButton(
              color:Colors.pinkAccent,
              icon: Icon(Icons.auto_awesome,),

            ),

          ]),
      body: Container(

        child: FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Container(
                height:500,
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      floatingActionButton: Row(
        children: [

          SizedBox(
            width:20,
          ),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                if (_controller.value.isPlaying) {
                  _controller.pause();
                } else {
                  _controller.play();
                }
              });
            },
            child:
            Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
          ),
          SizedBox(
            width:10,
          ),
          //  Text("Click Here", style:TextStyle( color: Colors.deepOrange,fontSize:23,fontWeight:FontWeight.bold,fontStyle:FontStyle.italic)),

          SizedBox(
            width:30,
          ),


          Expanded(
            child: RaisedButton(
                hoverElevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              color: Colors.deepPurple,
              child: Text(
                ' Start App',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),

              onPressed:(){
                Navigator
                    .pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (
                            context) {
                          return screen2(
                              widget
                                  .ud);
                        }));
              },

            ),
          )

        ],
      ),
    );
  }
}