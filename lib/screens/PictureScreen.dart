import 'dart:io';
import 'package:coronashak/screens/CameraPicCaptureScreen.dart';
import 'package:coronashak/widgets/ShowPicturesBody.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PictureScreen extends StatefulWidget {

  static var db;
  static PictureScreenState p1;

  @override
  State<StatefulWidget> createState() {
    _createDatabase();
    return p1 = PictureScreenState();
  }

  /// It should be called from main, but hell, we are just experimenting ///
  _createDatabase() async {
    db = await openDatabase(
      join(await getDatabasesPath(), 'storypicdb.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE storypics(filePath String PRIMARY KEY, description TEXT, dateTime String)",
        );
      },
      version: 1,
    );
  }
}

enum WhichBody { PICTURE, SHOWLIST }

class PictureScreenState extends State<PictureScreen> {
  WhichBody whichBody = WhichBody.PICTURE;

  _setWhichBodyToShow(WhichBody whichBody) {
    setState(() {
      this.whichBody = whichBody;
    });
  }

  @override
  void initState() {
    super.initState();
    _setWhichBodyToShow(WhichBody.PICTURE);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: PictureDrawer(),
        body: whichBody == WhichBody.PICTURE
            ? TakePictureScreenBody()
            : ShowPicturesBody(),
        appBar: AppBar(
          title: Text("My Corona-Days"),
          elevation: 4,
        ),
      ),
    );
  }

  @override
  void dispose() {
    PictureScreen.p1.dispose();
    PictureScreen.p1 = null;
    super.dispose();
  }
}

/// Work on the first option, take and save picture ///
class TakePictureScreenBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TakePictureScreenState();
  }
}

class TakePictureScreenState extends State<TakePictureScreenBody> {
  var imagePath;
  bool buttonSectionVisibility = true;
  bool captureSectionVisibility = false;
  TextEditingController storyDescriptionController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    storyDescriptionController = TextEditingController();

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Visibility(
              visible: buttonSectionVisibility,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 200,),
                  Text(
                    "You can start camera by clicking\nthe below button",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  RaisedButton(
                    child: Text(
                      "Start Camera",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.lightBlueAccent,
                    padding: EdgeInsets.only(
                        top: 13, bottom: 13, left: 25, right: 25),
                    elevation: 12,
                    splashColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    onPressed: () async {
                      await Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) =>
                              CameraPicCaptureScreen())).then((path) {
                        setState(() {
                          imagePath = path;
                          buttonSectionVisibility = false;
                          captureSectionVisibility = true;
                        });
                      });
                    },
                  ),
                  SizedBox(height: 20,),
                ],
              ),
            ),
            Visibility(
              visible: captureSectionVisibility,
              child: imagePath == null ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(height: 200,),
                    Text("No image was captured to show", style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),),
                    SizedBox(height: 20,),
                    RaisedButton(
                      color: Colors.lightBlueAccent,
                      child: Text("Get Back", style: TextStyle(
                        color: Colors.white,),),
                      splashColor: Colors.white,
                      elevation: 10,
                      onPressed: () {
                        setState(() {
                          captureSectionVisibility = false;
                          buttonSectionVisibility = true;
                        });
                      },
                    ),
                    SizedBox(height: 20,),
                  ]
                ),
              ) : Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Image.file(File(imagePath), height: 400, width: double.infinity,),
                      SizedBox(height: 10,),
                      Container(
                        margin: EdgeInsets.only(left: 13, right: 13),
                        child: TextField(
                          minLines: 6,
                          maxLines: 6,
                          controller: storyDescriptionController,
                          textAlign: TextAlign.start,
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            contentPadding: EdgeInsets.all(10),
                            hintText: "Enter the story",
                            labelText: "Shout Out!!",
                            helperText: "Enter the associated story of the clicked pic",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            )
                          ),
                        ),
                      ),
                      SizedBox(height: 13,),
                      Padding(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                elevation: 10,
                                splashColor: Colors.white,
                                color: Colors.redAccent,
                                child: Text("Cancel", style: TextStyle(color: Colors.white),),
                                padding: EdgeInsets.only(top: 14, bottom: 14),
                                onPressed: () {
                                  setState(() {
                                    captureSectionVisibility = false;
                                    buttonSectionVisibility = true;
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: 23,),
                            Expanded(
                              flex: 1,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                elevation: 10,
                                splashColor: Colors.white,
                                color: Colors.greenAccent,
                                child: Text("Save This Story", style: TextStyle(color: Colors.white),),
                                padding: EdgeInsets.only(top: 14, bottom: 14),
                                onPressed: () async {
                                  (await PictureScreen.db as Database).insert(
                                    'storypics',
                                    PicStoryModel(imagePath, storyDescriptionController.text, DateTime.now().toString()).toMap(),
                                    conflictAlgorithm: ConflictAlgorithm.replace,
                                  ).then((onValue) {
                                    print("============= Insertion Successful ==============");
                                    setState(() {
                                      captureSectionVisibility = false;
                                      buttonSectionVisibility = true;
                                    });
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30,)
                    ]
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PictureDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 8,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Pics Menu",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "A simple menu for your corona day pics",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/images/city.jpg"),
              fit: BoxFit.cover,
            )),
          ),
          ListTile(
            title: Text("Click A Pic"),
            subtitle: Text("Click a pic with a story"),
            leading: Icon(
              Icons.camera,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.of(context).pop();
              PictureScreen.p1._setWhichBodyToShow(WhichBody.PICTURE);
            },
          ),
          ListTile(
            title: Text("My Pics"),
            subtitle: Text("View saved pics and stories"),
            leading: Icon(
              Icons.camera,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.of(context).pop();
              PictureScreen.p1._setWhichBodyToShow(WhichBody.SHOWLIST);
            },
          ),
        ],
      ),
    );
  }
}

/// The model for storing corona days pics with stories ///
class PicStoryModel {
  String _filePath;
  String _description;
  String _dateTime;

  PicStoryModel(this._filePath, this._description, this._dateTime);

  Map<String, dynamic> toMap() {
    return {
      'filePath': _filePath,
      'description': _description,
      'dateTime': _dateTime,
    };
  }
}