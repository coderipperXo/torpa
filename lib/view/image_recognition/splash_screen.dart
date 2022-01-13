import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:fluttera2/view/image_recognition/home.dart';

class MySplash extends StatefulWidget {
  

  @override
  _MySplashState createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds:2,
      navigateAfterSeconds: Home(),
      title: Text("Zuret", 
        style:TextStyle(
          fontWeight:FontWeight.bold, 
          fontSize:25, 
          color:Colors.black,
          )
          ),
    /*image: Image.asset(
      "assets/entoto.jpg",
      ),*/
      backgroundColor: Colors.white,
      photoSize: 60,
      loaderColor: Colors.blue,
      
    );
  }
}