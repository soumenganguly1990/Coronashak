import 'dart:io';
import 'package:coronashak/screens/PictureScreen.dart';
import 'package:coronashak/screens/ShowFullStory.dart';
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
    _getPicListFromDb();
  }

  _getPicListFromDb() {
    (PictureScreen.db as Database).query('storypics').then((onValue) {
      setState(() {
        stories = onValue;
      });
    });
  }

  _deletePicFromDb(String filePath) {
    (PictureScreen.db as Database).delete(
      'storypics',
      where: 'filePath = ?',
      whereArgs: [filePath]
    ).then((onValue) {
      setState(() {
        _getPicListFromDb();
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
              return Stack(children: [
                Container(
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
                        image:
                            Image.file(File(stories[index]['filePath'])).image,
                        fit: BoxFit.cover),
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                          ),
                        ),
                        width: double.infinity,
                        padding: EdgeInsets.all(8),
                        child: Text(stories[index]['description'],
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            ))),
                  ),
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: PopupMenuButton<String>(
                        onSelected: (String value) {
                          if (value.contains("view")) {
                            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => ShowFullStory(stories[index])));
                          } else if (value.contains("delete")) {
                            _deletePicFromDb(stories[index]['filePath']);
                          }
                        },
                        color: Colors.white,
                        icon: Icon(Icons.more_vert, color: Colors.white,),
                        elevation: 6,
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<String>>[
                              PopupMenuItem(
                                child: Text("View"),
                                value: "view",
                                textStyle: TextStyle(color: Colors.black),
                              ),
                              PopupMenuItem(
                                child: Text("Delete"),
                                value: "delete",
                                textStyle: TextStyle(color: Colors.black),
                              ),
                            ]))
              ]);
            }),
          );
  }
}