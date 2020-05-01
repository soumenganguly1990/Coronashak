import 'package:coronashak/widgets/BottomAppBarItem.dart';
import 'package:coronashak/widgets/SymptomsItem.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SymptomScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SymptomScreenState();
  }
}

class SymptomScreenState extends State<SymptomScreen> {
  String symptomTag = "Symptom";
  static int selectedPosition = 0;
  var selectedBody;
  MyNotesBody m1 = MyNotesBody();

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedPosition = 0;
      selectedBody = _symptomsBody();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showNoteWritingDialog();
          },
          tooltip: 'Add Note',
          child: Icon(Icons.note_add),
          elevation: 5.0,
          backgroundColor: Colors.orange,
        ),
        bottomNavigationBar: _buildBottomAppBar(),
        body: selectedBody,
      ),
    );
  }

  BottomAppBar _buildBottomAppBar() {
    return BottomAppBar(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          BottomAppBarItem(
              "Symptoms", Icons.report_problem, selectedPosition == 0, () {
            setState(() {
              selectedPosition = 0;
              selectedBody = _symptomsBody();
            });
          }),
          SizedBox(
            width: 50,
          ),
          BottomAppBarItem(
              "Notes", Icons.format_list_bulleted, selectedPosition == 1, () {
            setState(() {
              selectedPosition = 1;
              selectedBody = m1;
            });
          }),
        ],
      ),
      color: Colors.blue,
      shape: CircularNotchedRectangle(),
    );
  }

  /// We could have used this as a widget, but we do not have any reloading of data necessary, otherwise we could have done something more with the build method
  _symptomsBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: double.infinity,
            height: 200,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Hero(
                  tag: 'tag$symptomTag',
                  child: Container(
                    height: 200,
                    padding: EdgeInsets.only(bottom: 16, left: 13, right: 13),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/symptoms.jpg'),
                            fit: BoxFit.cover)),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 14, left: 14, bottom: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        "Symptoms",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Know the symptoms of Coronavirus Covid19 or SARS-CoV2 infection. Better be safe than sorry",
                        style: TextStyle(
                            fontWeight: FontWeight.normal, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SymptomsItem(
              "High Fever",
              "Please check if you have high fever. Generally anything more than 100 degree Farenheit is a crucial symptom of infection, but only fever does not mean you have it",
              'assets/images/highfever.png'),
          SymptomsItem(
              "Dry Cough",
              "Notice whether you have dry cough. A high intensity dry cough along with fever is a crucial symptom",
              "assets/images/cough.png"),
          SymptomsItem("Pain", "Are you having body aches or pains?",
              "assets/images/pain.png"),
          SymptomsItem(
              "Congestion",
              "Nasal congestion and problem with breathing is a vital symptom of infection. Check if you also have fever and dry cough",
              "assets/images/nasal.png"),
          SymptomsItem(
              "Sore throat",
              "Pain or irritation like sensation in the throat that can occur with or without swallowing",
              "assets/images/sorethroat.png"),
          SymptomsItem(
              "Remember",
              "Remember a lot of the above mentioned symptoms are also symptoms of common flu. The symptoms do not occur at the same time and comes gradually. Almost 80% patients do not need hospitalization and get cured. Do not panic.",
              ""),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  _showNoteWritingDialog() {
    String symptom = '';
    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Symptom'),
          content: Row(
            children: <Widget>[
              Expanded(
                  child: TextField(
                autofocus: false,
                decoration: InputDecoration(
                    labelText: 'Specify Any Symptom You Noticed',
                    hintText: 'eg. Fever of 100.8 degree'),
                onChanged: (value) {
                  symptom = value;
                },
              ))
            ],
          ),
          actions: <Widget>[
            Text("Saving as of ${_getCurrentDateTime(Type.DATE)}"),
            FlatButton(
              child: Text('Save'),
              onPressed: () {
                _saveSymptomWithDateTime("$symptom||${_getCurrentDateTime(Type.BOTH)}");
                Navigator.of(context).pop(symptom);
              },
            ),
          ],
        );
      },
    );
  }

  _saveSymptomWithDateTime(String value) async {
    var pref = await SharedPreferences.getInstance();
    var listSymptoms = pref.getStringList("lstSymptoms");
    if (listSymptoms == null) listSymptoms = List<String>();
    listSymptoms.add(value);
    pref.setStringList("lstSymptoms", listSymptoms);
    m1.getNoteState().getMySavedNotes();
  }

  _getCurrentDateTime(Type t) {
    var now = DateTime.now();
    switch (t) {
      case Type.DATE: {
        return "Date ${now.day}/${now.month}/${now.year}";
        break;
      }
      case Type.TIME: {
        return "Time ${now.hour}:${now.minute}:${now.second}";
        break;
      }
      case Type.BOTH: {
        return "Time ${now.hour}:${now.minute}:${now.second} Date ${now.day}/${now.month}/${now.year}";
        break;
      }
    }
  }
}

enum Type {
  DATE,
  TIME,
  BOTH
}

class MyNotesBody extends StatefulWidget {
  MyNotesState m1;
  @override
  State<StatefulWidget> createState() {
    return m1 = MyNotesState();
  }
  MyNotesState getNoteState() {
    return m1;
  }
}

class MyNotesState extends State<MyNotesBody> {

  static List<String> notes;

  @override
  void initState() {
    super.initState();
    getMySavedNotes();
  }

  getMySavedNotes() async {
    await SharedPreferences.getInstance().then((prefs) {
      setState(() {
        notes = prefs.getStringList("lstSymptoms");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 13, right: 13),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(height: 13,),
          Text("My Notes", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
          SizedBox(height: 10,),
          (notes == null || notes.length == 0) ? Expanded(
            child: Center(
              child: Container(
                height: 200,
                width: 200,
                padding: EdgeInsets.all(13),
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 10, offset: Offset(0, 5))]
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("Sorry !!", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),),
                    SizedBox(height: 13,),
                    Text("It seems like you have not saved any notes till now. Save one now and see the list here.", textAlign: TextAlign.center, style: TextStyle(color: Colors.white),)
                  ],
                ),
              ),
            ),
          ) : Expanded(
            child: ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(notes.elementAt(index).split("||").elementAt(1)),
                  subtitle: Text(notes.elementAt(index).split("||").elementAt(0)),
                  leading: Icon(Icons.note),
                  onTap: () { setState(() {
                    SharedPreferences.getInstance().then((pref) {
                      notes.removeAt(index);
                      pref.setStringList("lstSymptoms", notes);
                    });
                  }); },
                );
              },
            ),
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}