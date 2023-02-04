import 'package:flutter/material.dart';

class PlayGame extends StatefulWidget {
  const PlayGame({Key? key}) : super(key: key);

  @override
  State<PlayGame> createState() => _PlayGameState();
}

class _PlayGameState extends State<PlayGame> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[700],
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.grey[850],
          title: const Text('Join Game'),
          titleTextStyle: const TextStyle(
              color: Colors.orange,
              fontFamily: 'Bungee',
              fontSize: 20.0,
              fontWeight: FontWeight.normal
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                constraints: const BoxConstraints(minHeight: 30.0,minWidth: 50.0),
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.all(20.0),
                color: Colors.brown,
                child: const Text('Games Found:',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OutlinedButton(
                    onPressed: () {

                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Join')
                ),
                const SizedBox(width: 10.0),
                OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Cancel'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
