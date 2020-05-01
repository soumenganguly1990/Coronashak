import 'package:flutter/material.dart';

class SymptomsItem extends StatelessWidget {

  final String title, description;
  final String imagePath;

  SymptomsItem(this.title, this.description, this.imagePath);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: imagePath.length != 0 ? Image(
              image: AssetImage(imagePath),
              height: 45,
              width: 45,
            ) : Icon(
                Icons.warning,
              color: Colors.red,
            ),
          ),
          SizedBox(width: 11,),
          Expanded(
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 2,),
                Text(title, style: TextStyle(fontSize: 18, color: Colors.black),),
                SizedBox(height: 5,),
                Text(description, style: TextStyle(color: Colors.grey),),
              ],
            ),
          )
        ],
      ),
    );
  }
}