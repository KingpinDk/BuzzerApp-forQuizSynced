import 'package:buzzer_prototype/screens/home.dart';
import 'package:buzzer_prototype/screens/offline mode.dart';
import 'package:buzzer_prototype/screens/host game.dart';
import 'package:buzzer_prototype/screens/play%20game.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  initialRoute: 'home',
  routes: {
    'home':(context) => Home(),
    'offline mode': (context) => const Offbuzz(),
    'host game':(context) => const HostGame(),
    'play game':(context) => const PlayGame()
  },
));

