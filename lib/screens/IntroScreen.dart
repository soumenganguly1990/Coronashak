import 'package:coronashak/screens/DashboardScreen.dart';
import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.red,
        body: IntroView()
      ),
    );
  }
}

class IntroView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntroViewsFlutter(
      getPages(),
      onTapDoneButton: () { _createRoute(); },
      showSkipButton: true,
      showNextButton: true,
      pageButtonTextStyles: new TextStyle(
        color: Colors.white,
        fontSize: 16.0,
        fontFamily: "Regular",
      ),
    );
  }

  List<PageViewModel> getPages() {
    List<PageViewModel> pages = List<PageViewModel>();
    var titles = ["The Pandemic", "Truly Devastating", "Be Cautious!!"];
    var bodies = ["The outbreak of Coronavirus Covid19 or Sars-Cov2 has been declared a pandemic by the World Health Organization or WHO in the month of March 2020", "The pandemic so far has infected"
        + "millions and has killed hundreds of thousands of people worldwide with no signs of relief anywhere",
      "Stay home, stay safe. Do not venture out of your house unless it is absolutely necessary and maintain all the precautions while on road"];
    var colors = [0xffbbb9bb, 0xff73E6F8, 0xffa2df98];
    var textcolors = [0xffffffff, 0xfffffffff, 0xffffffff];
    var images = ["assets/images/covid19.png", "assets/images/fever.png", "assets/images/stayhome.png"];
    for (int i = 0; i < 3; i++) {
      PageViewModel p1 = PageViewModel(
        pageColor: Color(colors[i]),
        mainImage: Image.asset(
          images[i],
          height: 170.0,
          width: 170.0,
          alignment: Alignment.center,
        ),
        title: Text(titles[i]),
        body: Text(bodies[i]),
        textStyle: TextStyle(color: Colors.white),
        titleTextStyle: TextStyle(fontSize: 35.0, color: Colors.white, fontWeight: FontWeight.bold),
        bodyTextStyle: TextStyle(fontSize: 20.0, color: Color(textcolors[i]), fontWeight: FontWeight.normal),
        iconColor: null,
        iconImageAssetPath: images[i],
      );
      pages.add(p1);
    }
    return pages;
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => DashboardScreen(),
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
}