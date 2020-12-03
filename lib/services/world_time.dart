import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:load/load.dart';



class WorldTime {
  String location; //location name for the UI
  String time; //the time in the location
  String flag; //url to an asset flag icon
  String url; //location endpoint for api endpoint
  bool isDayTime = false; //true or false if daytime or not;

  WorldTime({this.location, this.flag, this.url});
  Future<void> getTime() async {

    try {
      //make the request
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      //print(data);

      //get the property from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      //print(datetime);
      //print(offset);

      //create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      //set time property
      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
            hideLoadingDialog();
      _onAlertButtonsPressed('Eror', AlertType.none, 'Network Error', 'Unable to connect');
  
    }

  }
_onAlertButtonsPressed(context, type, title, body) {
    Alert(
      context: context,
      type: type,
      title: title,
      desc: body,
      buttons: [
        DialogButton(
          child: Text(
            "Close",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
          gradient: LinearGradient(colors: [
            Color.fromRGBO(12, 20, 30, 120),
            Color.fromRGBO(159, 0, 0, 1.0)
          ]),
        )
      ],
    ).show();
  }

}
