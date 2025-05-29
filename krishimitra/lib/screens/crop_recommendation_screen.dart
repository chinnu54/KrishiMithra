import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class CropRecommendationScreen extends StatefulWidget {
  @override
  _CropRecommendationScreenState createState() =>
      _CropRecommendationScreenState();
}

class _CropRecommendationScreenState extends State<CropRecommendationScreen> {
  late InAppWebViewController _webViewController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crop Recommendation'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: InAppWebView(
        initialUrlRequest:
        URLRequest(url: WebUri("https://huggingface.co/spaces/AshokGorle/croprecomender")),
        onWebViewCreated: (controller) {
          _webViewController = controller;
        },
        onLoadStop: (controller, url) async {
          // JavaScript to remove all logos and branding

            await controller.evaluateJavascript(source: '''
    document.querySelector('header').style.display = 'none'; // Hide <header>
    document.querySelector('#navbar').style.display = 'none'; // Hide element with id 'navbar'
    document.querySelectorAll('.ads').forEach(el => el.style.display = 'none'); // Hide all elements with class 'ads'
    document.querySelector('footer').style.display = 'none'; // Hide <footer>
  ''');
           // Call this function after the page loads
        },
      ),
    );
  }
}
