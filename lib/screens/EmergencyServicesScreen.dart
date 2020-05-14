import 'package:flutter/material.dart';

class EmergencyServicesScreen extends StatelessWidget {

  final gKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.only(left: 26, right: 26),
          child: Form(
            key: gKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Icon(Icons.warning,
                    color: Colors.red,
                    size: 70,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text("Register Here", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),)
                ),
                SizedBox(height: 3,),
                Align(
                    alignment: Alignment.center,
                    child: Text("Please fill up the form below", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14),)
                ),
                SizedBox(height: 23,),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Invalid input";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    labelText: "Enter your name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)
                    ),
                  ),
                ),
                SizedBox(height: 13,),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Invalid input";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    labelText: "Enter your Aadhar Number",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)
                    ),
                  ),
                ),
                SizedBox(height: 13,),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Invalid input";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    labelText: "(+91) Enter phone number",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)
                    ),
                  ),
                ),
                SizedBox(height: 13,),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Invalid input";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    labelText: "Enter Address",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)
                    ),
                  ),
                ),
                SizedBox(height: 13,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Invalid input";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            labelText: "City Name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5)
                            ),
                          ),
                        ),
                    ),
                    SizedBox(width: 20,),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Invalid input";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          labelText: "State Name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 13,),
                Text("* By pressing the below button, you automatically agree to be a part of the nationwide emergency network and can be directly contacted by government officials."),
                SizedBox(height: 7,),
                Text("** All fields are required"),
                SizedBox(height: 13,),
                Align(
                  alignment: Alignment.bottomRight,
                  child: RaisedButton(
                    onPressed: () {
                      if (gKey.currentState.validate()) {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text("Thank you for registering"),
                        ));
                      }
                    },
                    elevation: 8,
                    splashColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Container(
                      padding: EdgeInsets.only(top:11, bottom: 11, right: 33, left: 33),
                      child: Text("Submit", style: TextStyle(
                        color: Colors.white,
                        fontSize: 16
                      ),),
                    ),
                    color: Colors.lightBlueAccent,
                  ),
                ),
                SizedBox(height: 26,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}