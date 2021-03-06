import 'dart:convert';
import 'package:coronashak/screens/EmergencyServicesScreen.dart';
import 'package:coronashak/screens/PrecautionScreen.dart';
import 'package:coronashak/screens/SymptomScreen.dart';
import 'package:coronashak/widgets/StateHelpLine.dart';
import 'package:coronashak/widgets/StateHelplineItem.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'AboutApp.dart';
import 'PictureScreen.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _DashboardBody(),
      ),
    );
  }
}

class _DashboardBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DashboardState();
  }
}

class _DashboardState extends State<_DashboardBody> {
  Future<List<IndiaData>> _indiaData;
  Future<WorldData> _worldData;
  String _confirmed = "--", _dead = "--", _recovered = "--", _active = "--";
  String _wConfirmed = "00", _wDead = "00", _wRecovered = "00";
  String symptomTag = "Symptom", precautionTag = "Precaution";

  @override
  void initState() {
    super.initState();
    _plotWorldDate();
    _plotIndiaData();
  }

  void _plotWorldDate() {
    setState(() {
      _wConfirmed = "Wait..";
      _wDead = "Wait..";
      _wRecovered = "Wait..";
    });
    _worldData = _getWorldData().then((onValue) {
      setState(() {
        _wConfirmed = "${onValue.totalConfirmed}";
        _wDead = "${onValue.totalDeaths}";
        _wRecovered = "${onValue.totalRecovered}";
      });
      return null;
    });
  }

  void _plotIndiaData() {
    setState(() {
      _confirmed = "Wait..";
      _recovered = "Wait..";
      _dead = "Wait..";
      _active = "Wait..";
    });
    _indiaData = _getIndiaData().then((onValue) {
      var last = onValue.last;
      setState(() {
        _confirmed = "${last.confirmed}";
        _dead = "${last.deaths}";
        _recovered = "${last.recovered}";
        _active = "${last.confirmed - last.deaths - last.recovered}";
      });
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  image: DecorationImage(
                      image: AssetImage("assets/images/covid19.png"),
                      fit: BoxFit.fill),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(70, 70, 70, .4),
                        blurRadius: 6,
                        offset: Offset(0, 5))
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    "The Coronashak Mobile App",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "An offering of assistance in this testing time",
                    style: TextStyle(
                        fontWeight: FontWeight.normal, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 8,
                child: Text(
                  "World Statistics",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.blueGrey),
                ),
              ),
              Expanded(
                flex: 2,
                child: InkWell(
                  splashColor: Colors.grey,
                  child: Text("Refresh", style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                  onTap: () {
                    _plotWorldDate();
                  },
                ),
              )
            ],
          ),
          Text(
            "As received from PostMan Api",
            style: TextStyle(fontSize: 9),
          ),
          SizedBox(
            height: 3,
          ),
          Image(
            image: AssetImage('assets/images/world.png',),
            width: double.infinity,
            height: 170,
            fit: BoxFit.fill,
          ),
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9.0),
                    ),
                    elevation: 20,
                    child: Container(
                      padding: EdgeInsets.only(
                          top: 10, bottom: 10, left: 5, right: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Infected",
                            style: TextStyle(color: Colors.orange),
                          ),
                          Text(
                            "$_wConfirmed",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: Colors.orange),
                          )
                        ],
                      ),
                    )),
              ),
              Expanded(
                flex: 1,
                child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9.0),
                    ),
                    elevation: 20,
                    child: Container(
                      padding: EdgeInsets.only(
                          top: 10, bottom: 10, left: 5, right: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Dead",
                            style: TextStyle(color: Colors.red),
                          ),
                          Text(
                            "$_wDead",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: Colors.red),
                          )
                        ],
                      ),
                    )),
              ),
              Expanded(
                flex: 1,
                child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9.0),
                    ),
                    elevation: 20,
                    child: Container(
                      padding: EdgeInsets.only(
                          top: 10, bottom: 10, left: 5, right: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Recovered",
                            style: TextStyle(color: Colors.green),
                          ),
                          Text(
                            "$_wRecovered",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: Colors.green),
                          )
                        ],
                      ),
                    )),
              ),
            ],
          ),
          SizedBox(
            height: 17,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 8,
                child: Text(
                  "India Statistics",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.blueGrey),
                ),
              ),
              Expanded(
                flex: 2,
                child: InkWell(
                  splashColor: Colors.grey,
                  child: Text("Refresh", style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                  onTap: () {
                    _plotIndiaData();
                  },
                ),
              )
            ],
          ),
          Text(
            "As received from PostMan Api",
            style: TextStyle(fontSize: 9),
          ),
          SizedBox(
            height: 3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage('assets/images/india.png'),
                width: 120,
                height: 100,
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 14,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.orangeAccent,
                                          Color(0xFFF57C00),
                                        ])),
                                padding: EdgeInsets.all(5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Infected",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      "$_confirmed",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 28,
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                              )),
                        ),
                        SizedBox(width: 7,),
                        Expanded(
                          flex: 1,
                          child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 14,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [Colors.redAccent, Color(0xFFF44336)])),
                                padding: EdgeInsets.all(5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Dead",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      "$_dead",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 28,
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                              )),
                        ),
                      ],
                    ),
                    SizedBox(height: 7,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 14,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [Color(0xFF8BC34A), Color(0xFF689F38)])),
                                padding: EdgeInsets.all(5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Recovered",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      "$_recovered",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 26,
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                              )),
                        ),
                        SizedBox(width: 7,),
                        Expanded(
                          flex: 1,
                          child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 14,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [Colors.grey, Colors.blueGrey])),
                                padding: EdgeInsets.all(5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Active",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      "$_active",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 26,
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                              )),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Hero(
            tag: "tag$symptomTag",
            child: Card(
              elevation: 12,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9)),
              child: Ink(
                  height: 160,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/symptoms.jpg'),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(9)),
                  padding: EdgeInsets.only(bottom: 13, left: 16, right: 16),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(9),
                    splashColor: Colors.blueGrey,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (build) => SymptomScreen()));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          "Symptoms",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Get to know what are the symptoms of Coronavirus Covid19 infection. Be an early detector and a responsible citizen",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  )),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Hero(
            tag: "tag$precautionTag",
            child: Card(
              elevation: 12,
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
              child: Ink(
                  height: 160,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/cardbg.jpg'),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(9)),
                  padding: EdgeInsets.only(bottom: 13, left: 16, right: 16),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(9),
                    splashColor: Colors.blueGrey,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PrecautionScreen()));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          "Precautions",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "What rules you need to follow to be safe yourself and keep everybody around you safe too",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  )),
            ),
          ),
          SizedBox(
            height: 9,
          ),
          Card(
            elevation: 12,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
            child: Ink(
                height: 160,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/city.jpg'),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(9)),
                padding: EdgeInsets.only(bottom: 13, left: 16, right: 16),
                child: InkWell(
                  borderRadius: BorderRadius.circular(9),
                  splashColor: Colors.blueGrey,
                  onTap: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        "State Wise Stat",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Get the latest statistics of every state of India. Stay updated, know the risk, do as you were told",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                )),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 110,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                StateHelpLine("Helpline", "Numbers\n(Tap to call)", Colors.lightBlueAccent),
                StateHelplineItem("Maharashtra", "020-26127394", Colors.red),
                StateHelplineItem("Gujarat", "104", Colors.redAccent),
                StateHelplineItem("Delhi", "011-22307145", Colors.deepOrange),
                StateHelplineItem("Madhya Pd.", "104", Colors.deepOrangeAccent),
                StateHelplineItem("Rajasthan", "0141-2225624", Colors.orange),
                StateHelplineItem("Tamilnadu", "044-29510500", Colors.orangeAccent),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              height: 216,
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(7)),
              child: ListView(
                  scrollDirection: Axis.vertical,
                  children: ListTile.divideTiles(
                      context: context,
                      color: Colors.grey,
                      tiles: [
                        InkWell(
                          splashColor: Colors.grey,
                          child: ListTile(
                            leading: Icon(Icons.perm_device_information),
                            title: Text("Emergency Services"),
                            subtitle: Text("Emergency services at doorstep"),
                            trailing: Icon(Icons.chevron_right),
                          ),
                          onTap: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => EmergencyServicesScreen())); },
                        ),
                        InkWell(
                          splashColor: Colors.grey,
                          child: ListTile(
                            leading: Icon(Icons.info_outline),
                            title: Text("About App"),
                            subtitle: Text("Know more about Coronashak"),
                            trailing: Icon(Icons.chevron_right),
                          ),
                          onTap: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => AboutApp())); },
                        ),
                        InkWell(
                          splashColor: Colors.grey,
                          child: ListTile(
                            leading: Icon(Icons.camera_alt),
                            title: Text("Camera"),
                            subtitle: Text("Open camera and take pic"),
                            trailing: Icon(Icons.chevron_right),
                          ),
                          onTap: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => PictureScreen())); },
                        ),
                      ]).toList())),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Future<List<IndiaData>> _getIndiaData() async {
    final indiaData =
        await http.get('https://api.covid19api.com/total/country/india');
    List<IndiaData> allIndiaData;
    if (indiaData.statusCode == 200) {
      allIndiaData = (json.decode(indiaData.body) as List)
          .map((i) => IndiaData.fromJson(i))
          .toList();
      return allIndiaData;
    } else {
      throw Exception("Could not retrieve data from Covid19 Api");
    }
  }

  Future<WorldData> _getWorldData() async {
    final worldData = await http.get('https://api.covid19api.com/world/total');
    if (worldData.statusCode == 200) {
      return WorldData.fromJson(json.decode(worldData.body));
    } else {
      throw Exception("Could not get world data from Covid19 Api");
    }
  }
}

class WorldData {
  int totalConfirmed;
  int totalDeaths;
  int totalRecovered;

  WorldData({this.totalConfirmed, this.totalDeaths, this.totalRecovered});

  factory WorldData.fromJson(Map<String, dynamic> json) {
    return WorldData(
        totalConfirmed: json['TotalConfirmed'],
        totalDeaths: json['TotalDeaths'],
        totalRecovered: json['TotalRecovered']);
  }
}

class IndiaData {
  String country;
  String countryCode;
  String province;
  String city;
  String cityCode;
  String lat;
  String lon;
  int confirmed;
  int deaths;
  int recovered;
  int active;
  String date;

  IndiaData(
      {this.country,
      this.countryCode,
      this.province,
      this.city,
      this.cityCode,
      this.lat,
      this.lon,
      this.confirmed,
      this.deaths,
      this.recovered,
      this.active,
      this.date});

  factory IndiaData.fromJson(Map<String, dynamic> json) {
    return IndiaData(
        country: json['Country'],
        countryCode: json['CountryCode'],
        province: json['Province'],
        city: json['City'],
        cityCode: json['CityCode'],
        lat: json['Lat'],
        lon: json['Lon'],
        confirmed: json['Confirmed'],
        deaths: json['Deaths'],
        recovered: json['Recovered'],
        active: json['Active'],
        date: json['Date']);
  }
}
