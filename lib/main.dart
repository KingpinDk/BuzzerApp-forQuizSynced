import 'package:buzzer_prototype/screens/home.dart';
import 'package:buzzer_prototype/screens/offline mode.dart';
import 'package:buzzer_prototype/screens/time.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  initialRoute: 'home',
  routes: {
    'times':(context) => Time(),
    'home':(context) => Home(),
    'offline mode': (context) => Offbuzz()
  },
));

