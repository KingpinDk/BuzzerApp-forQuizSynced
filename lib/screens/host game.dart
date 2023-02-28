import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HostGame extends StatefulWidget {
  const HostGame({Key? key}) : super(key: key);

  @override
  State<HostGame> createState() => _HostGameState();
}

class _HostGameState extends State<HostGame> {

  final hostname = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[700],
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.grey[850],
          title: const Text('ADD PLAYERS'),
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
              padding: EdgeInsets.all(15.0),
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Enter host name',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                        icon: const Icon(Icons.clear_sharp),
                        onPressed: () => hostname.clear() ),
                    suffixIconColor: Colors.black45
                ),
                controller: hostname,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                constraints: const BoxConstraints(minHeight: 30.0,minWidth: 50.0),
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.all(20.0),
                color: Colors.brown,
                child: const Text('Players Found:',
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
                  Fluttertoast.showToast(
                      msg: 'turn on wifi',
                      toastLength: Toast.LENGTH_SHORT

                  );
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Start Game')
            ),
            const SizedBox(width: 10.0),
            OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Fluttertoast.showToast(msg: 'game canceled');
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Cancel'))
              ],
            )
          ]
        ),
      ),
    );
  }
}
