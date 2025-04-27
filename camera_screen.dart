import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_tts/flutter_tts.dart'; // For text-to-speech

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File? _image; // Holds the image file
  bool _isLoading = false;
  String _serverIp = ''; // Empty IP by default
  final FlutterTts _flutterTts = FlutterTts(); // Text-to-speech instance

  Future<void> _takePicture() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Picture taken: ${_image!.path.split('/').last}"),
        ),
      );
    }
  }

  Future<void> _uploadImage() async {
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please take an image first")),
      );
      return;
    }

    if (_serverIp.isEmpty) {
      _showIpDialog();
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final uri = Uri.parse('http://$_serverIp:5000/detect');
      final imageBytes = await _image!.readAsBytes();

      print("Uploading ${imageBytes.length} bytes to server...");

      final response = await http
          .post(
            uri,
            headers: {"Content-Type": "application/octet-stream"},
            body: imageBytes,
          )
          .timeout(const Duration(seconds: 100));

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Upload successful")),
        );

        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final String imageBase64 = responseData['image'];
        final List<dynamic> labels = responseData['labels'];

        // Show the processed image
        _showImageResponse(imageBase64);

        // Speak only the labels
        await _speakLabels(labels);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Server error: ${response.statusCode}")),
        );
      }
    } catch (error) {
      print("Error sending image: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error uploading image")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _speakLabels(List<dynamic> labels) async {
    if (labels.isEmpty) {
      await _flutterTts.speak("No objects detected.");
      return;
    }

    String labelNames =
        labels.map((label) => label['label'].toString()).join(", ");
    await _flutterTts.speak("Detected: $labelNames");
  }

  void _showImageResponse(String base64Image) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Processed Response Image"),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.6,
          child: InteractiveViewer(
            panEnabled: true,
            scaleEnabled: true,
            minScale: 1.0,
            maxScale: 5.0,
            child: Image.memory(
              base64Decode(base64Image),
              fit: BoxFit.contain,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }

  Future<void> _showIpDialog() async {
    String? newIp;
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Server IP Address'),
          content: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'e.g., 192.168.1.51'),
            onChanged: (value) => newIp = value,
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                if (newIp != null && newIp!.isNotEmpty) {
                  setState(() {
                    _serverIp = newIp!;
                  });
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera & Upload'),
        backgroundColor: Color(0xFF1E88E5),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: _showIpDialog,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image == null
                ? Text('No image selected.')
                : Image.file(
                    _image!,
                    height: 300,
                    width: 300,
                    fit: BoxFit.cover,
                  ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _takePicture,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFFEB3B),
              ),
              child: Text('Take Picture'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _isLoading ? null : _uploadImage,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isLoading ? Colors.grey : Color(0xFF4CAF50),
              ),
              child: _isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('Upload & Detect'),
            ),
          ],
        ),
      ),
    );
  }
}
