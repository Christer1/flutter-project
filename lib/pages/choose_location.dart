import 'dart:async';
import 'package:time/time.dart';
import 'package:World_time/services/world_time.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:load/load.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  bool isActive = true;
  List<WorldTime> locations = [
    WorldTime(url: 'Africa/Lagos', location: 'Lagos', flag: 'nigeria.png'),
    WorldTime(url: 'Africa/Tunis', location: 'Tunis', flag: 'tunis.jpg'),
    WorldTime(url: 'America/Bogota', location: 'Bogota', flag: 'bogota.png'),
    WorldTime(url: 'Europe/Berlin', location: 'Berlin', flag: 'greece.png'),
    WorldTime(url: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
    WorldTime(url: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),
    WorldTime(url: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
    WorldTime(url: 'America/New_York', location: 'New York', flag: 'usa.png'),
    WorldTime(url: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png'),
    WorldTime(url: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'),
  ];

  void updateTime(index) async {
    try {
      WorldTime instance = locations[index];
      await instance.getTime();

      hideLoadingDialog(); //close dialog

      //navigate to home screen
      Navigator.pop(context, {
        'location': instance.location,
        'flag': instance.flag,
        'time': instance.time,
        'isDayTime': instance.isDayTime,
      });
    } catch (e) {
      hideLoadingDialog();
      _onAlertButtonsPressed(context, AlertType.none, 'Network Error',
          'OOP! unable to connect...');
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
            Color.fromRGBO(59, 0, 0, 1.0),
            Color.fromRGBO(159, 0, 0, 1.0)
          ]),
        )
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Choose a location'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
            child: Card(
              child: ListTile(
                onTap: () async {
                  if (isActive) {
                    await showLoadingDialog(); //load dialog
                    setState(() {
                      isActive = false;
                      showLoadingDialog(); //load dialog
                      Timer(Duration(seconds: 5), () => setState(() => isActive = true));
                    });
                    updateTime(index);
                  }
                },
                title: Text(locations[index].location),
                leading: CircleAvatar(
                  backgroundImage:
                      AssetImage('assets/${locations[index].flag}'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
