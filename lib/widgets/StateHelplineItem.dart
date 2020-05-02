import 'package:coronashak/widgets/StateHelpLine.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;

class StateHelplineItem extends StatelessWidget {

  final String stateName, contactNumber;
  final Color color;

  StateHelplineItem(this.stateName, this.contactNumber, this.color);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.grey,
      onTap: () {
        callNumber(contactNumber);
      },
      child: StateHelpLine(stateName, contactNumber, color),
    );
  }

  void callNumber(String number) {
    urlLauncher.launch('tel://$number');
  }
}