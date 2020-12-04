
import 'package:World_time/services/world_time.dart';
import 'package:flutter/material.dart';
import 'package:load/load.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  bool isActive = true;
  dynamic loader;
  bool loading = true;
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

 updateTime(index) async {
    try {
      await locations[index].getTime();
      //print(locations[index].flag);
    } catch (e) {
      print(e);
      setState(() {
        loading = false;
      });

      loader.dismiss();
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Oops!"),
              content: Text("Connection Error"),
              actions: [
                FlatButton(
                  child: Text("Close"),
                  onPressed: () {
                    Navigator.pop(
                      context,
                    );
                  },
                )
              ],
            );
          });
    }
    setState(() {
      loading = false;
    });

    loader.dismiss();
    //navigate back to home screen
    Navigator.pop(context, {
      'location': locations[index].location,
      'time': locations[index].time,
      'flag': locations[index].flag,
      'isDayTime': locations[index].isDayTime,
    });
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
              padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
              child: Card(
                child: ListTile(
                  onTap: () async {
                    setState(() {
                      loading = true;
                    });

                    if (loading) {
                      var dialog = await showLoadingDialog();
                      setState(() {
                        loader = dialog;
                      });
                    }

                    updateTime(index);
                  },
                  title: Text(locations[index].location),
                  leading: CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/${locations[index].flag}'),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
