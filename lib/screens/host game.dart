import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_p2p_connection/flutter_p2p_connection.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HostGame extends StatefulWidget {
  const HostGame({super.key});

  @override
  State<HostGame> createState() => _HostGameState();
}

class _HostGameState extends State<HostGame> with WidgetsBindingObserver{

  bool _Visible = true;
  final TextEditingController hostname = TextEditingController();
  final TextEditingController msgText = TextEditingController();
  final _flutterP2pConnectionPlugin = FlutterP2pConnection();
  List<DiscoveredPeers> peers = [];
  WifiP2PInfo? wifiP2PInfo;
  StreamSubscription<WifiP2PInfo>? _streamWifiInfo;
  StreamSubscription<List<DiscoveredPeers>>? _streamPeers;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _init();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _flutterP2pConnectionPlugin.unregister();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _flutterP2pConnectionPlugin.unregister();
    } else if (state == AppLifecycleState.resumed) {
      _flutterP2pConnectionPlugin.register();
    }
  }

  void _init() async {
    await _flutterP2pConnectionPlugin.initialize();
    await _flutterP2pConnectionPlugin.register();
    _streamWifiInfo = _flutterP2pConnectionPlugin.streamWifiP2PInfo().listen((event) {
      setState(() {
        wifiP2PInfo = event;
      });
    });
    _streamPeers = _flutterP2pConnectionPlugin.streamPeers().listen((event) {
      setState(() {
        peers = event;
      });
    });
  }

  Future startSocket() async {
    if (wifiP2PInfo != null) {
      bool started = await _flutterP2pConnectionPlugin.startSocket(
        groupOwnerAddress: wifiP2PInfo!.groupOwnerAddress,
        downloadPath: "/storage/emulated/0/Download/",
        maxConcurrentDownloads: 2,
        deleteOnError: true,
        onConnect: (name, address) {
          snack("$name connected to socket with address: $address");
        },
        transferUpdate: (transfer) {
          if (transfer.completed) {
            snack(
                "${transfer.failed ? "failed to ${transfer.receiving ? "receive" : "send"}" : transfer.receiving ? "received" : "sent"}: ${transfer.filename}");
          }
          print(
              "ID: ${transfer.id}, FILENAME: ${transfer.filename}, PATH: ${transfer.path}, COUNT: ${transfer.count}, TOTAL: ${transfer.total}, COMPLETED: ${transfer.completed}, FAILED: ${transfer.failed}, RECEIVING: ${transfer.receiving}");
        },
        receiveString: (req) async {
          print(req);
          snack(req);
        },
      );
      snack("open socket: $started");
    }
  }

  Future sendMessage() async {
    _flutterP2pConnectionPlugin.sendStringToSocket(msgText.text);
  }

  void _onPressed() async{
    bool? created = await _flutterP2pConnectionPlugin.createGroup();
    snack("created group");
    print('creted group: $created');
    bool? discovering = await _flutterP2pConnectionPlugin.discover();
    snack("discovering: $discovering");
    print('discovering: $discovering');
    setState(() {
       _Visible = false;
    });
  }

  void snack(String msg) async{
    Fluttertoast.showToast(msg: msg,toastLength: Toast.LENGTH_SHORT);
    print("fluttertoast $msg");
    //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ScaffoldMessenger(
        child: Scaffold(
          backgroundColor: Colors.white70,
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
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                CutomButton(context),
                SizedBox(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: peers.length,
                    itemBuilder: (context, index) => Center(
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => Center(
                              child: AlertDialog(
                                content: SizedBox(
                                  height: 200,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("name: ${peers[index].deviceName}"),
                                      Text(
                                          "address: ${peers[index].deviceAddress}"),
                                      Text(
                                          "isGroupOwner: ${peers[index].isGroupOwner}"),
                                      Text(
                                          "isServiceDiscoveryCapable: ${peers[index].isServiceDiscoveryCapable}"),
                                      Text(
                                          "primaryDeviceType: ${peers[index].primaryDeviceType}"),
                                      Text(
                                          "secondaryDeviceType: ${peers[index].secondaryDeviceType}"),
                                      Text("status: ${peers[index].status}"),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () async {
                                      Navigator.of(context).pop();
                                      bool? bo = await _flutterP2pConnectionPlugin
                                          .connect(peers[index].deviceAddress);
                                      snack("connected: $bo");
                                    },
                                    child: const Text("connect"),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child: Text(
                              peers[index]
                                  .deviceName
                                  .toString()
                                  .characters
                                  .first
                                  .toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    startSocket();
                  },
                  child: const Text("open a socket"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    bool? removed = await _flutterP2pConnectionPlugin.removeGroup();
                    snack("removed group: $removed");
                  },
                  child: const Text("remove group/disconnect"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget CutomButton(BuildContext context)
  {
    return _Visible
        ? ElevatedButton(
        onPressed: _onPressed,
          child: const Text('Host Game',
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
            fontWeight: FontWeight.bold
        ),
      ),
    )
        : const SizedBox.shrink();
  }
}
// body: Column(
//   children: [
//     Padding(
//       padding: EdgeInsets.all(15.0),
//       child: TextField(
//         decoration: InputDecoration(
//             hintText: 'Enter host name',
//             border: const OutlineInputBorder(),
//             suffixIcon: IconButton(
//                 icon: const Icon(Icons.clear_sharp),
//                 onPressed: () => hostname.clear() ),
//             suffixIconColor: Colors.black45
//         ),
//         controller: hostname,
//       ),
//     ),
//     Padding(
//       padding: const EdgeInsets.all(15.0),
//       child: Container(
//         constraints: const BoxConstraints(minHeight: 30.0,minWidth: 50.0),
//         alignment: Alignment.topCenter,
//         padding: const EdgeInsets.all(20.0),
//         color: Colors.brown,
//         child: const Text('Players Found:',
//           style: TextStyle(
//               fontSize: 20.0,
//               color: Colors.white,
//               fontWeight: FontWeight.bold
//           ),
//         ),
//       ),
//     ),
// Row(
//   mainAxisAlignment: MainAxisAlignment.center,
//   crossAxisAlignment: CrossAxisAlignment.start,
//   children: [
//     OutlinedButton(
//         onPressed: () {
//           Fluttertoast.showToast(
//               msg: 'turn on wifi',
//               toastLength: Toast.LENGTH_SHORT
//
//           );
//         },
//         style: OutlinedButton.styleFrom(
//           backgroundColor: Colors.green,
//           foregroundColor: Colors.white,
//         ),
//         child: const Text('Start Game')
//     ),
//     const SizedBox(width: 10.0),
//     OutlinedButton(
//         onPressed: () {
//           Navigator.pop(context);
//           Fluttertoast.showToast(msg: 'game canceled');
//         },
//         style: OutlinedButton.styleFrom(
//           backgroundColor: Colors.red,
//           foregroundColor: Colors.white,
//         ),
//         child: const Text('Cancel'))
//       ],
//     )
//   ]
// ),

