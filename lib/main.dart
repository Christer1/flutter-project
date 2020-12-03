import 'package:flutter/material.dart';
import 'package:load/load.dart';
import 'pages/home.dart';
import 'pages/loading.dart';
import 'pages/choose_location.dart';

void main() => runApp(LoadingProvider(
  
  child:   MaterialApp(
    debugShowCheckedModeBanner: true,
      initialRoute: '/',
      routes: {
        '/': (context) => Loading(),
        '/home': (context) => Home(),
        '/location': (context) => ChooseLocation(),
      }
    ),
    
));