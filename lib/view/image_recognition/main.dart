import 'package:flutter/material.dart';
import 'package:fluttera2/view/image_recognition/splash_screen.dart';
void main() =>runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: "Zuret",
      home: MySplash(),
      debugShowCheckedModeBanner: false,

       );
  }
}




