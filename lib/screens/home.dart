import 'package:flutter/material.dart';
import 'package:flutter_p2p_connection/flutter_p2p_connection.dart';

class Home extends StatefulWidget{
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final _flutterP2pConnectionPlugin = FlutterP2pConnection();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white70,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.grey[850],
          title:const Text('Home'),
          titleTextStyle: const TextStyle(
              color: Colors.orange,
              fontFamily: 'Bungee',
              fontSize: 20.0,
              fontWeight: FontWeight.normal
          ),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20.0),
              const Text('Mode of use?',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: 'Bungee',
                fontSize: 30.0,
                color: Colors.black
              ),
              ),
              const SizedBox(height: 30.0,),
              TextButton(onPressed: () async {
                if( !await _flutterP2pConnectionPlugin.checkLocationEnabled())
                  {
                    _flutterP2pConnectionPlugin.enableLocationServices();
                  }
                if(!await _flutterP2pConnectionPlugin.checkWifiEnabled())
                  {
                    _flutterP2pConnectionPlugin.enableWifiServices();
                  }
                if(! await _flutterP2pConnectionPlugin.checkLocationPermission())
                  {
                    _flutterP2pConnectionPlugin.askStorageAndLocationPermission();
                  }

                if(!mounted) {
                  return;
                }

                //snack("created group: $created");
                Navigator.pushNamed(context,'host game');
                },
                  child: const Text('The Host',
                  style: TextStyle(
                    color: Colors.red,
                    fontFamily: 'Bungee'
                  ),
                  )
              ),
              const SizedBox(height: 20.0),
              TextButton(onPressed: () async {
                if( !await _flutterP2pConnectionPlugin.checkLocationEnabled())
                {
                _flutterP2pConnectionPlugin.enableLocationServices();
                }
                if(!await _flutterP2pConnectionPlugin.checkWifiEnabled())
                {
                _flutterP2pConnectionPlugin.enableWifiServices();
                }
                if(! await _flutterP2pConnectionPlugin.checkLocationPermission())
                {
                _flutterP2pConnectionPlugin.askStorageAndLocationPermission();
                }
                if(!mounted) {
                return;
                }
                Navigator.pushNamed(context,'play game');
                },
                  child: const Text('Player',
                    style: TextStyle(
                        color: Colors.red,
                        fontFamily: 'Bungee'
                    ),
                  )
              ),
              const SizedBox(height: 20.0),
              TextButton(onPressed: (){ Navigator.pushNamed(context,'offline mode');},
                  child: const Text('Offline Mode',
                    style: TextStyle(
                        color: Colors.red,
                        fontFamily: 'Bungee'
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}