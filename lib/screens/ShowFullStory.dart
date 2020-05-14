import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowFullStory extends StatefulWidget {

  final Map<String, dynamic> picStoryModel;
  ShowFullStory(this.picStoryModel);

  @override
  State<StatefulWidget> createState() => ShowFullStoryState();
}

class ShowFullStoryState extends State<ShowFullStory> {
  bool areDateAndDescriptionShown = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () {
          setState(() {
            areDateAndDescriptionShown = !areDateAndDescriptionShown;
          });
        },
        child: Stack(children: [
          Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                  image:
                      Image.file(File(widget.picStoryModel['filePath'])).image,
                  fit: BoxFit.contain,
                )),
          ),
          Visibility(
            visible: areDateAndDescriptionShown,
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: EdgeInsets.only(top: 50, left: 13),
                child: Row(
                  children: <Widget>[
                    InkWell(
                      onTap: () { Navigator.of(context).pop(); },
                      splashColor: Colors.white,
                      child: Icon(Icons.arrow_back, color: Colors.white,),
                    ),
                    SizedBox(width: 16,),
                    Text(
                      widget.picStoryModel['dateTime'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: areDateAndDescriptionShown,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                height: 200,
                width: double.infinity,
                color: Colors.black38,
                padding: EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Text(
                    widget.picStoryModel['description'],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                    ),
                  ),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}