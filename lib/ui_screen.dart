import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/weadher.dart';
import 'city_screen.dart';
import 'weadher.dart';

class ui_screen extends StatefulWidget {
  const ui_screen({super.key, this.weadherdata});
  final weadherdata;
  @override
  State<ui_screen> createState() => _ui_screenState();
}

class _ui_screenState extends State<ui_screen> {
  Weadhermodel weather=new Weadhermodel();
  Color c1=Colors.black;
  final date = new DateTime.now();
  getdate() {
    String currentdate = DateFormat('d MMM y').format(DateTime.now());
    return currentdate;
  }
  getday() {
    String day = DateFormat('EEEE').format(date);
    return day;
  }



  int temp=0;
  int mintemp=0;
  int maxtemp=0;
  String weadherIcon='';
  String description='';
  String cityname='';
  double visibility=0;
  String feellike='';
  String preasure='';
  String humidility='';
  String wind='';



  void initState() {
    super.initState();
    updateui(widget.weadherdata);
  }


  void updateui(var weadherdata){
    if(weadherdata==null){
      temp= 0;
      mintemp=0;
      maxtemp=0;
      var condition=0;
      weadherIcon= '';
      description='';
      cityname='';
      visibility=0;
      feellike='';
      preasure='';
      humidility='';
      wind='';
      return;
    }
    print(weadherdata);

     temp= weadherdata['main']['temp'].toInt();
     mintemp=weadherdata['main']['temp_min'].toInt();
     maxtemp=weadherdata['main']['temp_max'].toInt();
     var condition=weadherdata['weather'][0]['id'];
     weadherIcon= weather.getWeatherIcon(condition);
     description=weadherdata['weather'][0]['description'];
     cityname=weadherdata['name'];
     visibility=weadherdata['visibility']/1000;
     feellike=weadherdata['main']['feels_like'].toString();
     preasure=weadherdata['main']['pressure'].toString();
     humidility=weadherdata['main']['humidiity'].toString();
     wind=weadherdata['wind']['speed'].toString();


  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: Scaffold(
        backgroundColor:c1 ,
        appBar: AppBar(
          forceMaterialTransparency: true,
          actions: [
            IconButton(
              onPressed: () async{
                var cityname= await  Navigator.push(context, MaterialPageRoute(builder: (context){
                  return CityScreen();

                }));
                print(cityname);
                if(cityname!= null){
                  var weadherdata=await weather.getcityweadher(cityname);
                  if(weadherdata!=null) {
                    updateui(weadherdata);
                  }
                  else{
                    print('404');
                  }
                }
              },

              icon: Icon(
                Icons.location_city,
                //Platform.isAndroid ? Icons.more_vert : Icons.more_horiz,
                color: Colors.white,
              ),
            ),
          ],
          title: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(getday(),
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.white)),
                Text(',',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.white)),
                SizedBox(
                  width: 5,
                ),
                Text(getdate(),
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.white)),
              ],
            ),
          ),
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.all(25),
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.blue.withOpacity(0.9),
                  ),
                  child: Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          cityname,
                          style: GoogleFonts.titanOne(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.w200),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          description.toUpperCase(),
                          style: GoogleFonts.labrada(
                              color: Colors.black, fontSize: 20),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(weadherIcon,style: TextStyle(fontSize: 50),),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '$temp C',
                          style: GoogleFonts.labrada(
                              color: Colors.black, fontSize: 60),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('min\n$mintemp C',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black)),
                            Text(
                              '|',
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w200,
                                  color: Colors.black),
                            ),
                            Text('max\n$maxtemp C',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
                child: Row(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Text(
                            'NOW',
                            style: GoogleFonts.lato(
                                color: Colors.white, fontSize: 15),
                          ),
                          Icon(
                            CupertinoIcons.moon_fill,
                            color: Colors.yellowAccent,
                          ),
                          Text(
                            '25C',
                            style: GoogleFonts.labrada(
                                color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Text(
                            '1 : 00',
                            style: GoogleFonts.lato(
                                color: Colors.white, fontSize: 15),
                          ),
                          Icon(
                            CupertinoIcons.moon_fill,
                            color: Colors.yellowAccent,
                          ),
                          Text(
                            '25C',
                            style: GoogleFonts.labrada(
                                color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Text(
                            'NOW',
                            style: GoogleFonts.lato(
                                color: Colors.white, fontSize: 15),
                          ),
                          Icon(
                            CupertinoIcons.moon_fill,
                            color: Colors.yellowAccent,
                          ),
                          Text(
                            '25C',
                            style: GoogleFonts.labrada(
                                color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.blue.withOpacity(0.9),
                )),
            Container(
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'Tommorw\'s Temprature',
                      style: GoogleFonts.lato(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Expect the same as today',
                      style:
                          GoogleFonts.lato(color: Colors.black, fontSize: 15),
                    ),
                  ),
                ],
              ),
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.blue.withOpacity(0.9),
              ),
            ),
            Container(
              child: Column(
                children: [
                  Text(
                    '15-day weadher forecast',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Day',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.sunny,
                            color: Colors.yellowAccent,
                          ),
                          Text(
                            'sunny',
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                        ],
                      ),
                      Text(
                        '25C',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Day',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.sunny,
                            color: Colors.yellowAccent,
                          ),
                          Text(
                            'sunny',
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                        ],
                      ),
                      Text(
                        '25C',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Day',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.sunny,
                            color: Colors.yellowAccent,
                          ),
                          Text(
                            'sunny',
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                        ],
                      ),
                      Text(
                        '25C',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Day',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.sunny,
                            color: Colors.yellowAccent,
                          ),
                          Text(
                            'sunny',
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                        ],
                      ),
                      Text(
                        '25C',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Day',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.sunny,
                            color: Colors.yellowAccent,
                          ),
                          Text(
                            'sunny',
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                        ],
                      ),
                      Text(
                        '25C',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Day',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.sunny,
                            color: Colors.yellowAccent,
                          ),
                          Text(
                            'sunny',
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                        ],
                      ),
                      Text(
                        '25C',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.blue.withOpacity(0.9),
              ),
            ), // Container(
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            CupertinoIcons.thermometer,
                            color: Colors.white,
                          ),
                          Text(
                            'Feels like',
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                          Text(
                            '25C',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blue.withOpacity(0.9),
                      ),
                    ),
                    Container(
                      width: 150,
                      height: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            CupertinoIcons.wind,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'N wind',
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            '$wind'+'mi/h',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blue.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            CupertinoIcons.drop,
                            color: Colors.white,
                          ),
                          Text(
                            'Humidiity',
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                          Text(
                            '$humidility'+'%',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blue.withOpacity(0.9),
                      ),
                    ),
                    Container(
                      width: 150,
                      height: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            CupertinoIcons.sun_max,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'UV',
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            '0 very week',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blue.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            CupertinoIcons.eye_fill,
                            color: Colors.white,
                          ),
                          Text(
                            'Visibility',
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                          Text(
                            '$visibility'+' KM',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blue.withOpacity(0.9),
                      ),
                    ),
                    Container(
                      width: 150,
                      height: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            CupertinoIcons.rectangle_compress_vertical,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Air Pressure',
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            '$preasure'+'hPa',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blue.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Icon(
                        CupertinoIcons.sunset,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'sunset',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '6:19 pm',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(
                        CupertinoIcons.sunrise,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'sunrise',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '7:19 am',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.blue.withOpacity(0.9),
              ),
            )
          ],
        ),


      ),
    );
  }
}
