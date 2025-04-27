import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'camera_screen.dart';
import 'infoscreen.dart';
import 'video_screen.dart';

class HomePage extends StatefulWidget {
  final String userName;

  HomePage({required this.userName});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _command = '';

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _requestMicrophonePermission();
  }

  void _requestMicrophonePermission() async {
    var status = await Permission.microphone.request();
    if (status.isGranted) {
      print('Microphone permission granted');
    } else {
      print('Microphone permission denied');
    }
  }

  void _processCommand(String command) {
    if (command.contains('navigation')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CameraScreen()),
      );
    } else if (command.contains('recognition')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => VideoScreen()),
      );
    } else {
      _showMessage('Processing please wait!');
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E88E5),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header with Greeting and Logo
                Column(
                  children: [
                    Icon(
                      Icons.remove_red_eye,
                      size: 100.0,
                      color: Color(0xFF1E88E5),
                    ),
                    Text(
                      'Welcome, ${widget.userName}!',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF888888),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                // Feature Buttons
                _buildFeatureButton(
                  icon: Icons.navigation,
                  title: 'Navigation',
                  subtitle: 'Navigate your surroundings',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CameraScreen()),
                    );
                  },
                ),
                const SizedBox(height: 20),
                _buildFeatureButton(
                  icon: Icons.camera,
                  title: 'Scene Recognition',
                  subtitle: 'Recognize the scenario',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VideoScreen()),
                    );
                  },
                ),
                const SizedBox(height: 20),
                // Settings and Info in a Single Row
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _buildSmallFeatureButton(
                          icon: Icons.settings,
                          title: 'Settings',
                          onTap: () {
                            _showMessage('Settings feature coming soon!');
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _buildSmallFeatureButton(
                          icon: Icons.info_outline,
                          title: 'Info',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InfoScreen()),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                // Mic Button
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      if (!_isListening) {
                        bool available = await _speech.initialize();
                        if (available) {
                          setState(() => _isListening = true);
                          _speech.listen(
                            onResult: (result) {
                              setState(() {
                                _command = result.recognizedWords;
                                _processCommand(_command);
                              });
                            },
                          );
                        }
                      } else {
                        setState(() => _isListening = false);
                        _speech.stop();
                      }
                    },
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: const Color(0xFF1E88E5),
                      child: Icon(
                        _isListening ? Icons.mic : Icons.mic_none,
                        size: 80,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Version Text
                Center(
                  child: Text(
                    'Version 1.0',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureButton({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 40, color: const Color(0xFF1E88E5)),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E88E5),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSmallFeatureButton({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            child: Icon(icon,
                size: 30, color: const Color.fromARGB(255, 127, 127, 127)),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 127, 127, 127),
            ),
          ),
        ],
      ),
    );
  }
}
