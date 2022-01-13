import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttera2/model/user.dart';
import 'package:fluttera2/view/hotel/hotelservice.dart';
import 'package:fluttera2/view/nearby/nearby.dart';
import 'package:fluttera2/view/ride/rideservice.dart';
import 'package:fluttera2/view/tour/tablatestgrams.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';

import '../loginscreen.dart';

class Home extends StatefulWidget {
   final User user;
  const Home({Key key, this.user}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
 
  bool _loading = true;
  File _image;
  List _output;
  final picker =ImagePicker();

  

  @override
  void initState(){
    super.initState();
    loadModel().then((value){
      setState(() {
        
      });
    });
    pickImage();
  }

  dectectImage(File image) async {
    var output =await Tflite.runModelOnImage(
      path:image.path,
      numResults: 2,
      threshold: 0.6,
      imageMean: 127.5,
      imageStd: 127.5,

    );
    setState(() {
      _output=output;
      _loading=false;
    });
  }

  loadModel() async{
    await Tflite.loadModel(model: "assets/assets/model_unquant2.tflite", labels: "assets/assets/labels2.txt");
    
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  pickImage()async{
    var image= await picker.getImage(source:ImageSource.camera);
    if(image==null) return null;
    
    setState(() {
      _image = File(image.path);
    });

    dectectImage(_image);
  }

    pickGalleryImage()async{
    var image= await picker.getImage(source:ImageSource.gallery);
    if(image==null) return null;

    setState(() {
      _image = File(image.path);
    });

    dectectImage(_image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      body: Container(
        padding:EdgeInsets.symmetric(horizontal: 24),
        height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
        child: Column(crossAxisAlignment:CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height:50),
          SizedBox(height:50),
          Center(child:_loading ?
          Container(
            width: 400,
            child: Column(children:<Widget>[
              Image.asset("assets/assets/entoto.jpg"),
              SizedBox(height: 50),

            ],),

          ):Container(
            child: Column(children:<Widget>[
              Container(
                height: 350,
                width: double.infinity,
                child: Image.file(_image),
                ),
                SizedBox(height:20),
                _output !=null? Text("${_output[0]["label"]}", 
                style:TextStyle(
                color:Colors.black,
                fontSize: 15),
                )
                :Container(),
                SizedBox(height:10),
            ]),
          ),
          ),
          Container(
            width:MediaQuery.of(context).size.width,
            child: Column(
              children:<Widget>[
                GestureDetector(
                  onTap: (){
                    pickImage();
                  },
                  child:Container(
                    width: MediaQuery.of(context).size.width-100,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal:10,vertical:18),
                    decoration:BoxDecoration(
                      color:Colors.orangeAccent, 
                      borderRadius:BorderRadius.circular(6),
                      ),
                    child: Text(
                      "You can capture photo again",
                      style:TextStyle(color:Colors.black,fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(height:10),

                GestureDetector(
                  onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (content)=>Tour()));
                  },
                  child:Container(
                    width: MediaQuery.of(context).size.width-100,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal:10,vertical:18),
                    decoration:BoxDecoration(
                      color:Colors.yellow, 
                      borderRadius:BorderRadius.circular(6),
                      ),
                    child: Text(
                      "Tour and travel agencies",
                      style:TextStyle(color:Colors.black,fontSize: 16),
                    ),
                  ),
                ),

                SizedBox(height:10),

                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (content)=>Ride()));
                  },
                  child:Container(
                    width: MediaQuery.of(context).size.width-100,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal:10,vertical:18),
                    decoration:BoxDecoration(
                      color:Colors.yellow, 
                      borderRadius:BorderRadius.circular(6),
                      ),
                    child: Text(
                      "Ride hailing services",
                      style:TextStyle(color:Colors.black,fontSize: 16),
                    ),
                  ),
                ),

                                SizedBox(height:10),

                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (content)=>Hotel()));
                  },
                  child:Container(
                    width: MediaQuery.of(context).size.width-100,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal:10,vertical:18),
                    decoration:BoxDecoration(
                      color:Colors.yellow, 
                      borderRadius:BorderRadius.circular(6),
                      ),
                    child: Text(
                      "Hotel and hospitality services",
                      style:TextStyle(color:Colors.black,fontSize: 16),
                    ),
                  ),
                ),

                 SizedBox(height:10),

                GestureDetector(
                  onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (content)=>MyHomePage()));
                  },
                  child:Container(
                    width: MediaQuery.of(context).size.width-100,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal:10,vertical:18),
                    decoration:BoxDecoration(
                      color:Colors.yellow, 
                      borderRadius:BorderRadius.circular(6),
                      ),
                    child: Text(
                      "Nearby Landmarks",
                      style:TextStyle(color:Colors.black,fontSize: 16),
                    ),
                  ),
                ),
              ]
            ),
          )
        ],
        ),
      ),
      
    );
  }


  
   Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: new Text(
              'Do you want to back to login?',
              style: TextStyle(),
            ),
            content: new Text(
              'Are your sure?',
              style: TextStyle(),
            ),
            actions: <Widget>[
              MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context,
                        MaterialPageRoute(builder: (content) => LoginScreen()));
                  },
                  child: Text(
                    "Yes",
                    style: TextStyle(),
                  )),
              MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "No",
                    style: TextStyle(),
                  )),
            ],
          ),
        ) ??
        false;
  }
}