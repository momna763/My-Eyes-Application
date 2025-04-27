import 'package:firebase_core/firebase_core.dart'; //firebase libraary
import 'package:flutter/foundation.dart'; //extra helper funcitons
import 'package:flutter/material.dart'; //ui maker

import 'package:flutter_tts/flutter_tts.dart'; //text to speech
import 'second_screen.dart'; // Import the new file

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: kIsWeb
          ? const FirebaseOptions(
              apiKey: "AIzaSyCo7tJsGAHKCDPsnKbzOlsY_fLnN5J2ZnI",
              authDomain: "my-eyes-firebase-setup.firebaseapp.com",
              projectId: "my-eyes-firebase-setup",
              storageBucket: "my-eyes-firebase-setup.appspot.com",
              messagingSenderId: "226567335045",
              appId: "1:226567335045:web:ca862b6bdddbaef80bcdec")
          : null // Use the default options for mobile
      );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove debug banner
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _speakIntro(); // Speak when the screen initializes
  }

  Future<void> _speakIntro() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(
        "Welcome to My Eyes. Guiding vision beyond sight. Tap Get Started to continue.");
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F1F1), // Light grey background for balance
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo and App Name
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.remove_red_eye, // Placeholder for eye icon
                      size: 100.0,
                      color: Color(0xFF1E88E5), // Blue color for the logo
                    ),
                    SizedBox(height: 10.0), //space dy deta hai
                    Text(
                      'MY-EYES',
                      style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E88E5), // Blue color for app name
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                // Tagline
                const Text(
                  '"Guiding vision beyond sight."',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Color(0xFF555555), // Soft dark color for tagline
                    fontFamily: 'Roboto-Serif',
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40.0),
                // Get Started Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      // Speak when the button is pressed
                      await flutterTts.speak("Getting started. Please wait.");
                      // Navigate to the second screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SecondScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF1E88E5), // Blue color for the button
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'GET STARTED',
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.white, // White text for button
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Version Text positioned at the bottom right
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0, bottom: 16.0),
              child: const Text(
                'Version 1.0',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Color(0xFF888888), // Soft gray for version text
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
