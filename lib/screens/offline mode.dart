
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';


class Offbuzz extends StatefulWidget {
  const Offbuzz({Key? key}) : super(key: key);

  @override
  State<Offbuzz> createState() => _OffbuzzState();
}

class _OffbuzzState extends State<Offbuzz> {

  final player = AudioPlayer();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[700],
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.grey[850],
          title:const Text('Buzzer'),
          titleTextStyle: const TextStyle(
              color: Colors.orange,
              fontFamily: 'Bungee',
              fontSize: 20.0,
              fontWeight: FontWeight.normal
          ),
        ),
        body: Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(50.0),
                backgroundColor: Colors.red,
                elevation: 20.0,
                shadowColor: Colors.black,
                shape: const CircleBorder()
            ),
            onPressed: () async{
              DateTime time = DateTime.now();
              await player.play(AssetSource('beep.mp3'));
              String strtime = time.toString().substring(10,time.toString().length);
              print(strtime);
            },
            child: const Text("Buzz me"),
          ),
        ),
      ),
    );
  }
}
