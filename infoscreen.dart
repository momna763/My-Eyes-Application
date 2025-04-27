import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About MY Eyes'),
        backgroundColor: Color(0xFF1E88E5),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo and Title
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.remove_red_eye,
                    size: 100.0,
                    color: Color(0xFF1E88E5),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'MY Eyes',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E88E5),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Description
              Text(
                'MY Eyes is an innovative mobile application designed to assist visually impaired users through features such as navigation, scene recognition, and voice command functionalities.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[800],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),

              // Instructions Section
              Text(
                'How to Use MY Eyes:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),

              // Instructions List
              Expanded(
                child: ListView(
                  children: [
                    _instructionItem(
                        '1. Tap on "Navigation" to start guided walking.'),
                    _instructionItem(
                        '2. Use "Scene Recognition" to identify objects and surroundings.'),
                    _instructionItem(
                        '3. Activate "Speech-to-Text" for voice input commands.'),
                    _instructionItem(
                        '4. Contact support for any issues or feedback at support@myeyesapp.com'),
                  ],
                ),
              ),

              // Version Info
              Text(
                'Version 1.0',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _instructionItem(String instruction) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Text(
        instruction,
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey[700],
        ),
      ),
    );
  }
}
