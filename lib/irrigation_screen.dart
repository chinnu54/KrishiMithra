import 'package:flutter/material.dart';

class IrrigationScreen extends StatefulWidget {
  @override
  _IrrigationScreenState createState() => _IrrigationScreenState();
}

class _IrrigationScreenState extends State<IrrigationScreen> {
  bool isIrrigationOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Irrigation Control')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isIrrigationOn ? Icons.water_drop : Icons.water_drop_outlined,
              size: 100,
              color: isIrrigationOn ? Colors.blue : Colors.grey,
            ),
            SwitchListTile(
              title: Text('Irrigation ${isIrrigationOn ? "On" : "Off"}'),
              value: isIrrigationOn,
              onChanged: (value) {
                setState(() {
                  isIrrigationOn = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
