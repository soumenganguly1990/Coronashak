import 'dart:async';
import 'package:coronashak/screens/DashboardScreen.dart';
import 'package:coronashak/screens/IntroScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
          _visible = true;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg.jpg"),
                fit: BoxFit.fill
              )
            ),
            constraints: BoxConstraints.expand(),
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 1500),
              opacity: _visible ? 1.0 : 0.0,
              onEnd: () => timer(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      image: DecorationImage(
                          image: AssetImage("assets/images/covid19.png"),
                          fit: BoxFit.fill),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(70, 70, 70, .4),
                            blurRadius: 10,
                            offset: Offset(0, 5))
                      ],
                    ),
                  ),
                  SizedBox(height: 45,),
                  Text(
                    "Coronashak",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32.0,
                        color: Colors.white),
                  ),
                  SizedBox(height: 15,),
                  Text("Together we can\nLet\'s stay home so that everybody stays safe",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            )),
      ),
    );
  }

  void timer() {
    Timer(
        Duration(
          seconds: 2,
        ),
        () => _propagateoDesiredScreen()
    );
  }

  void _propagateoDesiredScreen() async {
    if (await _hasIntroBeenShown()) {
      Navigator.of(context).pushReplacement(_createRoute(false));
    } else {
      Navigator.of(context).pushReplacement(_createRoute(true));
    }
  }

  Route _createRoute(bool shouldWePropagateToIntro) {
    var page = shouldWePropagateToIntro ? IntroScreen() : DashboardScreen();
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Future<bool> _hasIntroBeenShown() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isIntroShown = prefs.getBool("isIntroShown") ?? false;
    if (isIntroShown == null || isIntroShown == false) {
      prefs.setBool("isIntroShown", true);
      return false;
    }
    else return true;
  }
}