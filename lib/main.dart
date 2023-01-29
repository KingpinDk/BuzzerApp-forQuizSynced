import 'package:flutter/material.dart';




void main() => runApp(Home());



class Home extends StatefulWidget{
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: Drawer(
          backgroundColor: Colors.grey[700],
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(

                  color: Colors.grey[850],
                ),
                child: const Text('Buzzer options',
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
                ),
              ),
              ListTile(
                title: const Text('Times'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: const Text('Settings'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
            ],
          ),
        ),
        backgroundColor: Colors.grey[700],
        appBar: AppBar(
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
            onPressed: () {
              DateTime time = DateTime.now();
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

