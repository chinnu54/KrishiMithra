import 'dart:convert'; // For base64 encoding
import 'dart:io'; // For file operations
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class WebViewScreen extends StatefulWidget {
  final String url = "https://huggingface.co/spaces/AshokGorle/PlantDiseaseDetctionApp";

  WebViewScreen({Key? key}) : super(key: key);

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late InAppWebViewController _controller;
  String remedies = "";

  @override
  void initState() {
    super.initState();
    // Register a handler for picking a file
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.addJavaScriptHandler(
        handlerName: 'pickFile',
        callback: (_) async {
          await _showFilePickerDialog();
        },
      );
    });
  }

  Future<void> _showFilePickerDialog() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      await _uploadFileToWeb(image);
      await _fetchRemedy("Based on the uploaded image, identify the disease and provide remedies."); // Fetch remedy using text description
    }
  }

  Future<void> _uploadFileToWeb(XFile image) async {
    final String base64Image = await image.readAsBytes().then((bytes) => base64Encode(bytes));

    await _controller.evaluateJavascript(
      source: '''
        const inputFile = document.querySelector('input[type="file"]');
        const dataTransfer = new DataTransfer();
        const fileBlob = new Blob([Uint8Array.from(atob("$base64Image").split("").map(c => c.charCodeAt(0)))], {type: "image/jpeg"});
        const fileObj = new File([fileBlob], "${image.name}", {type: "image/jpeg"});
        dataTransfer.items.add(fileObj);
        inputFile.files = dataTransfer.files;
        const event = new Event('change', { bubbles: true });
        inputFile.dispatchEvent(event);
      ''',
    );
  }

  Future<void> _fetchRemedy(String description) async {
    final String apiKey = ""; // Replace with your OpenAI API key

    try {
      final response = await http.post(
        Uri.parse("https://api.openai.com/v1/chat/completions"),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $apiKey',
          HttpHeaders.contentTypeHeader: 'application/json'
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo',
          'messages': [
            {
              'role': 'user',
              'content': description
            }
          ],
          'max_tokens': 100,
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        setState(() {
          remedies = jsonResponse["choices"][0]["message"]["content"];
        });
      } else {
        print("Error fetching remedies: ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Disease Detection', style: TextStyle(fontSize: 24)),
        centerTitle: true,
        backgroundColor: Colors.green[700],
      ),
      body: Column(
        children: [
          Expanded(
            child: InAppWebView(
              initialUrlRequest: URLRequest(url: WebUri(widget.url)),
              onWebViewCreated: (controller) {
                _controller = controller;
              },
              onLoadStop: (controller, url) async {
                // Additional functionality can be placed here
              },
            ),
          ),
          if (remedies.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Remedies:\n$remedies",
                style: TextStyle(fontSize: 18, color: Colors.green[800]),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _showFilePickerDialog();
        },
        child: Icon(Icons.add_a_photo),
        backgroundColor: Colors.green,
        tooltip: "Upload Image for Disease Detection",
      ),
    );
  }
}
