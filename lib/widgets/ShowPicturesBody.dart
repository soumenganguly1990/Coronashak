import 'dart:io';
import 'package:coronashak/screens/PictureScreen.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class ShowPicturesBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ShowPicturesState();
}

class ShowPicturesState extends State<ShowPicturesBody> {
  List<Map<String, dynamic>> stories;

  @override
  void initState() {
    super.initState();
    (PictureScreen.db as Database).query('storypics').then((onValue) {
      setState(() {
        stories = onValue;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return (stories == null || stories.length == null || stories.length == 0)
        ? Text("Nothing to show for now")
        : GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 18,
            crossAxisSpacing: 18,
            padding: EdgeInsets.only(top: 13, left: 13, right: 13, bottom: 20),
            children: List.generate(stories.length, (index) {
              return Container(
                constraints: BoxConstraints.expand(),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 10,
                        offset: Offset(0, 6))
                  ],
                  image: DecorationImage(
                      image: Image.file(File(stories[index]['filePath'])).image,
                      fit: BoxFit.cover),
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                      padding: EdgeInsets.all(8),
                      child: Text(stories[index]['description'],
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            backgroundColor: Colors.black45,
                          ))),
                ),
              );
            }),
          );
  }
}
