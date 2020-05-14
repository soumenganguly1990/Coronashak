import 'dart:ui';
import 'package:flutter/material.dart';

class AboutApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Text("About"),
              backgroundColor: Colors.black,
              elevation: 5,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                color: Colors.white,
                splashColor: Colors.white,
              ),
              expandedHeight: 240,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Image(
                  width: double.infinity,
                  image: AssetImage("assets/images/aboutbg.png"),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ];
        },
        scrollDirection: Axis.vertical,
        body: Container(
          padding: EdgeInsets.only(left: 19, right: 19, top: 13, bottom: 0),
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Why Was The App built", style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
                fontSize: 15
              ),),
              SizedBox(height: 10,),
              Card(
                color: Colors.white,
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("The main reason behind developing Coronashak was to learn Flutter. I tried to understand how things work in flutter, how stateless and stateful widgets work, how local db works, how apis are called etc"),
                      SizedBox(height: 6,),
                      Text("This app was not developed with any intention of taking advantage of the current pandemic.")
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Text("Developer", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                  fontSize: 15
              ),),
              SizedBox(height: 10,),
              Card(
                color: Colors.white,
                elevation: 6,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)
                ),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Developed by Soumen Ganguly.")
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Text("Disclaimer", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                  fontSize: 15
              ),),
              SizedBox(height: 10,),
              Card(
                color: Colors.white,
                elevation: 6,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)
                ),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("The app uses Postman Covid19 api for getting world and India statistics as is."),
                      SizedBox(height: 6,),
                      Text("The pics/icons used have been downloadd from Google.com, Pexels.com, Flaticon.com"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}