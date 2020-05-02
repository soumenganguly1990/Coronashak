import 'package:coronashak/widgets/SymptomsItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrecautionScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: PrecautionFloatingActionButton(),
        body: PrecautionBody(),
      ),
    );
  }
}

class PrecautionBody extends StatelessWidget {

  String precautionTag = "Precaution";

  @override
  Widget build(BuildContext context) {
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
                  tag: 'tag$precautionTag',
                  child: Container(
                    height: 200,
                    padding: EdgeInsets.only(bottom: 16, left: 13, right: 13),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/cardbg.jpg'),
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
                        "Precautions",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Learn what rules to follow, what to do to save yourself and others from the Covid19 infection",
                        style: TextStyle(
                            fontWeight: FontWeight.normal, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 13,),
          SymptomsItem("Social Distancing", "Try to maintain a minimum distance of 2 meters or 6 feet with other persons. It decreases the chance of getting infected", "assets/images/social.png"),
          SymptomsItem("Wear Mask", "Wear face masks whenever you venture out of your home for anything necessary. Use good quality 3 layer masks for better protection", "assets/images/health.png"),
          SymptomsItem("Wash Hands", "Wash your hands for atleast 20 seconds with soap from time to time. It kills the virus by destroying the outer fat layer", "assets/images/cleaning.png"),
          SymptomsItem("Use Hand Sanitizers", "Use good quality high-alcohol hand sanitizers or hand rubs. Carry a bottle of it with you. Apply carefully on both sides of your hand when rubbing", "assets/images/spray.png")
        ],
      )
    );
  }
}

class PrecautionFloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.lightBlueAccent,
      splashColor: Colors.white,
      elevation: 5,
      child: Icon(Icons.more, color: Colors.white,),
      onPressed: () {
        showModalBottomSheet(context: context, builder: (context) {
          return Container(
            color: Colors.white,
            height: 250,
            padding: EdgeInsets.all(13),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                Text("Remember", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28, color: Colors.black),),
                SizedBox(height: 19,),
                Text("The easiest way to avoid Coronavirus Covid19 infection is to stay home. Do not venture out without absolute necessity. If you know of someone who are not doing so, do not hesitate to let the authority know about it."),
                SizedBox(height: 15,),
                Text("We all are warriors in a war we have not seen in our lifetime. Stay home, stay safe"),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: double.infinity,
                      child: RaisedButton(
                        color: Colors.black,
                        elevation: 4,
                        splashColor: Colors.white,
                        padding: EdgeInsets.only(top: 13, bottom: 13),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)
                        ),
                        child: Text("OK, Got It", style: TextStyle(color: Colors.white),),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }
}