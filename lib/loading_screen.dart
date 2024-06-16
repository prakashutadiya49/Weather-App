import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:weather/ui_screen.dart';
import 'package:weather/weadher.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';




class loading_screen extends StatefulWidget {
  const loading_screen({super.key});
  @override
  State<loading_screen> createState() => _loading_screenState();
}

// ignore: camel_case_types
class _loading_screenState extends State<loading_screen> {


  getlocationdata() async {
    var weatherdata= await Weadhermodel().getlocationweadher();
    //print(weatherdata);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ui_screen(weadherdata: weatherdata);
    }),);
  }

  @override
  void initState() {
    super.initState();
    getlocationdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

       body: Center(
         child: SpinKitSquareCircle(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
