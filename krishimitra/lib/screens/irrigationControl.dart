import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class IrrigationControlScreen extends StatefulWidget {
  @override
  _IrrigationControlScreenState createState() => _IrrigationControlScreenState();
}

class _IrrigationControlScreenState extends State<IrrigationControlScreen> {
  bool _isMotorOn = false; // Track the motor state

  Future<void> _toggleMotor(bool turnOn) async {
    String message = turnOn ? "on" : "off";
    String url = "https://devicecontrolservice-through-sms.onrender.com/$message";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          _isMotorOn = turnOn; // Update the motor state
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Motor is now ${turnOn ? "On" : "Off"}')),
        );
      } else {
        throw Exception("Failed to control motor");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> _testServer() async {
    String url = "https://devicecontrolservice-through-sms.onrender.com/commands"; // Command endpoint

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // Assuming you get a JSON response
        String serverResponse = response.body;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Server Response: $serverResponse')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Server responded with status: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('నీటి పారుదల నియంత్రణ',
          style: TextStyle(fontWeight: FontWeight.bold,
            fontSize: 20,
          )),
        backgroundColor: Colors.green,

      ),
      body: Container(
        color: Colors.lightGreenAccent[100], // Light and friendly background
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Irrigation Control',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              'Current Status: ${_isMotorOn ? "Irrigation On" : "Irrigation Off"}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: _isMotorOn ? Colors.green : Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Button to Turn On Motor
                ElevatedButton(
                  onPressed: () => _toggleMotor(true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                    textStyle: const TextStyle(fontSize: 20),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  child: const Text(
                    'Motor On',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                // Button to Turn Off Motor
                ElevatedButton(
                  onPressed: () => _toggleMotor(false),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                    textStyle: const TextStyle(fontSize: 20),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  child: const Text(
                    'Motor Off',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Button to Test Server
            ElevatedButton(
              onPressed: _testServer,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                textStyle: const TextStyle(fontSize: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              child: const Text(
                'Test Server',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
