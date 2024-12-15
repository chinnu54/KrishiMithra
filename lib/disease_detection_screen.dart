import 'package:flutter/material.dart';

class DiseaseDetectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Disease Detection')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Disease Detected'),
                content: Text('This plant has been affected by a blight disease.'),
                actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('OK'))],
              ),
            );
          },
          child: Text('Simulate Detection'),
        ),
      ),
    );
  }
}
