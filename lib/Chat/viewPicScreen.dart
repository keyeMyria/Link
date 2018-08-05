import 'package:flutter/material.dart';
import 'dart:async';
import 'package:camera/camera.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/widgets.dart';
//import 'package:image/image.dart' as ui;
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'dart:io';


List<CameraDescription> cameras;



class viewPic extends StatefulWidget {
  viewPic(this.img);
  final File img;
  final String title;
  Offset postition = Offset(0.0, 0.0);
  @override
  _viewPicState createState() => new _viewPicState();
}

class _viewPicState extends State<viewPic> with TickerProviderStateMixin {

  AnimationController _controller;
  static const int kStartValue = 10;

  String timestamp() => new DateTime.now().millisecondsSinceEpoch.toString();
  GlobalKey globalKey = new GlobalKey();




  CameraController controller;
  Color caughtColor = Colors.grey;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: kStartValue),
    );

    _controller.forward(from: 0.0);

    Future.delayed(new Duration(seconds: 10)).then((E){
      Navigator.pop(context);
    });
  }



  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }





  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Stack(
          children: <Widget>[

            new Container(
              height: double.infinity,
              width: double.infinity,
              decoration: new BoxDecoration(
                image: new DecorationImage(image: FileImage(widget.img))
              ),
            ),

            new Align(
              alignment: new Alignment(0.9, 0.9),
              child:new Countdown(
                animation: new StepTween(
                  begin: kStartValue,
                  end: 0,
                ).animate(_controller),
              ),
            ),

          ],
        )
    );
  }

}

class Countdown extends AnimatedWidget {
  Countdown({ Key key, this.animation }) : super(key: key, listenable: animation);
  Animation<int> animation;

  @override
  build(BuildContext context){
    return new Text(
      animation.value.toString(),
      style: new TextStyle(fontSize: 15.0,color: Colors.white),
    );
  }

}