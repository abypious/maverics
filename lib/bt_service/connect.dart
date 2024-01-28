import 'package:bluetooth_classic/models/device.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:bluetooth_classic/bluetooth_classic.dart';
import 'package:flutter_blue/gen/flutterblue.pbjson.dart';
import 'package:maverics/loation.dart';
import 'package:maverics/tire_pressure.dart';

class Connect extends StatefulWidget {
  const Connect({super.key});

  @override
  State<Connect> createState() => _MyAppState();
}

class _MyAppState extends State<Connect> {
  String _platformVersion = 'Unknown';
  final _bluetoothClassicPlugin = BluetoothClassic();
  List<Device> _devices = [];
  List<Device> _discoveredDevices = [];
  bool _scanning = false;
  int _deviceStatus = Device.disconnected;
  Uint8List _data = Uint8List(0);

  @override
  void initState() {
    super.initState();
    initPlatformState();
    _bluetoothClassicPlugin.onDeviceStatusChanged().listen((event) {
      setState(() {
        _deviceStatus = event;
      });
    });
    _bluetoothClassicPlugin.onDeviceDataReceived().listen((event) {
      setState(() {
        _data = Uint8List.fromList([..._data, ...event]);
      });
    });
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await _bluetoothClassicPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future<void> requestBluetoothPermissions() async {
    await _bluetoothClassicPlugin.initPermissions();
    print("Permission granted");
  }

  Future<void> _getDevices() async {
    requestBluetoothPermissions();
    var res = await _bluetoothClassicPlugin.getPairedDevices();
    setState(() {
      _devices = res;
    });
  }

  Future<void> _scan() async {
    if (_scanning) {
      await _bluetoothClassicPlugin.stopScan();
      setState(() {
        _scanning = false;
      });
    } else {
      await _bluetoothClassicPlugin.startScan();
      _bluetoothClassicPlugin.onDeviceDiscovered().listen(
            (event) {
          setState(() {
            _discoveredDevices = [..._discoveredDevices, event];
          });
        },
      );
      setState(() {
        _scanning = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    
    String dataAsString = String.fromCharCodes(_data);

    String _extractSubstring(String data, int start, int end) {
      return data.length >= end ? data.substring(start, end) : '';
    }

    String b1_temperature = _extractSubstring(dataAsString, 0, 3);
    String b2_temperature = _extractSubstring(dataAsString, 3, 6);
    String b1_voltage = _extractSubstring(dataAsString, 6, 9);
    String b2_voltage = _extractSubstring(dataAsString, 9, 12);
    String drive_range = _extractSubstring(dataAsString, 12, 15);
    return WillPopScope(
      onWillPop: () async {
        // Return false to block the back navigation
        return false;
      },
    child: MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'CONNECT',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: _getDevices,
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text(
                "SHOW",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 10),
            Text(
              " $_deviceStatus   ",
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          ],
          backgroundColor: Colors.cyanAccent,
          toolbarHeight: 75.0,
          elevation: 5.0,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: _deviceStatus == Device.connected
                      ? () async {
                    await _bluetoothClassicPlugin.write("1");
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    onPrimary: Colors.black,
                    minimumSize: Size(320, 90),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 3.0,
                  ),
                  child: const Text(
                    "START VEHICLE",
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              _buildInfoTextField("BATTERY 1 TEMPERATURE", b1_temperature),
              _buildInfoTextField("BATTERY 2 TEMPERATURE", b2_temperature),
              _buildInfoTextField("BATTERY 1 VOLTAGE", b1_voltage),
              _buildInfoTextField("BATTERY 2 VOLTAGE", b2_voltage),
              _buildInfoTextField("DRIVING RANGE", drive_range),
              SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                onPressed: ()  {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Pressure()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.cyanAccent,
                  onPrimary: Colors.black,
                  minimumSize: Size(140, 120),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  elevation: 3.0,
                ),
                    child: Column(
                      children: [
                       const Text(
                        "TIRE",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 2.0,
                          color: Colors.black,
                        ),
                      ),
                        const Text(
                          "PRESSURE",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2.0,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )
              ),
              SizedBox(height: 20),
              Text("  "),
              ElevatedButton(
                onPressed: ()  {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Location()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.cyanAccent,
                  onPrimary: Colors.black,
                  minimumSize: Size(140, 120),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 3.0,
                ),
                  child: Column(
                    children: [
                      const Text(
                        "VEHICLE",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 2.0,
                          color: Colors.black,
                        ),
                      ),
                      const Text(
                        "LOCATION",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 2.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  )
              ),
                ],
              ),

              SizedBox(height: 8),
              ElevatedButton(
                onPressed: _deviceStatus == Device.connected
                    ? () async {
                  await _bluetoothClassicPlugin.disconnect();
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  // primary: Colors.deepOrange,
                  // onPrimary: Colors.black,
                  minimumSize: Size(150, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  elevation: 3.0,
                ),
                child: const Text(
                  "DISCONNECT DEVICE",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 20),
              ...[
                for (var device in _devices)
                  TextButton(
                    onPressed: () async {
                      await _bluetoothClassicPlugin.connect(
                        device.address,
                        "00001101-0000-1000-8000-00805f9b34fb",
                      );
                      setState(() {
                        _discoveredDevices = [];
                        _devices = [];
                      });
                    },
                    child: Center(
                      child: Text(
                        device.name ?? device.address,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
              ],
              SizedBox(height: 20),
              // Display only the first 20 characters to avoid overflow
            ],
          ),
        ),
      ),
    ),
    );
  }

  Widget _buildInfoTextField(String label, String value) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: TextEditingController(text: "$label: $value"),
        readOnly: true,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16.0,
          // You can customize other text styles here
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

}

// void main() {
//   runApp(MaterialApp(
//     home: Connect(),
//   ));
// }
