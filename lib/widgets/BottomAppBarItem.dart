import 'package:flutter/material.dart';

class BottomAppBarItem extends StatelessWidget {

  final String text;
  final IconData icon;
  final bool isSelected;
  final Function onTap;

  BottomAppBarItem(this.text, this.icon, this.isSelected, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: InkWell(
          splashColor: Colors.grey,
          child: Container(
            height: 52,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(icon, color: isSelected ? Colors.white : Colors.white54),
                Text(text, style: TextStyle(color: isSelected ? Colors.white : Colors.white54),),
              ],
            ),
          ),
          onTap: onTap,
        ),
      );
  }
}