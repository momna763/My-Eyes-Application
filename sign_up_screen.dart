import 'package:flutter/material.dart';
import 'package:my_eyes/auth_service.dart';
import 'home_page.dart'; // Import the HomePage
import 'package:flutter_tts/flutter_tts.dart'; // Import TTS package

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = AuthService();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final FlutterTts flutterTts = FlutterTts(); // TTS instance

  @override
  void initState() {
    super.initState();
    // Speak the screen title
    _speak("Welcome to the Sign-Up page. Please enter your details.");
  }

  Future _speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F1F1), // Light grey background
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo and App Name
                    Column(
                      children: [
                        const Icon(
                          Icons.remove_red_eye, // Placeholder for eye icon
                          size: 100.0,
                          color: Color(0xFF1E88E5), // Blue color for the logo
                        ),
                        const Text(
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
                    const SizedBox(height: 40.0),
                    // Name Input Field
                    TextField(
                      controller: nameController, // Controller for name input
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Enter Name',
                        prefixIcon:
                            const Icon(Icons.person, color: Color(0xFF1E88E5)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onTap: () => _speak("Please enter your name."),
                    ),
                    const SizedBox(height: 20.0),
                    // Email Input Field
                    TextField(
                      controller: emailController, // Controller for email input
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Enter E-mail',
                        prefixIcon:
                            const Icon(Icons.email, color: Color(0xFF1E88E5)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onTap: () => _speak("Please enter your email address."),
                    ),
                    const SizedBox(height: 20.0),
                    // Password Input Field
                    TextField(
                      controller:
                          passwordController, // Controller for password input
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Enter Password',
                        prefixIcon:
                            const Icon(Icons.lock, color: Color(0xFF1E88E5)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onTap: () => _speak("Please enter your password."),
                    ),
                    const SizedBox(height: 20.0),
                    // Re-enter Password Input Field
                    TextField(
                      controller:
                          rePasswordController, // Controller for re-enter password input
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Re-enter Password',
                        prefixIcon:
                            const Icon(Icons.lock, color: Color(0xFF1E88E5)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onTap: () => _speak("Please re-enter your password."),
                    ),
                    const SizedBox(height: 30.0),
                    // Sign Up Button
                    ElevatedButton(
                      onPressed: _signup,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(
                            0xFF1E88E5), // Blue color for the button
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        minimumSize: const Size(
                            double.infinity, 50), // Full-width button
                      ),
                      child: const Text(
                        'SIGN UP',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white, // White text for the button
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                        height: 30.0), // Add space between button and bottom
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 16.0, // Position the text 16 pixels from the right
            bottom: 16.0, // Position the text 16 pixels from the bottom
            child: const Text(
              'Version 1.0',
              style: TextStyle(
                fontSize: 14.0,
                color: Color(0xFF888888),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _signup() async {
    final user = await _auth.createUserWithEmailAndPassword(
        emailController.text, passwordController.text);
    if (user != null) {
      logger.d("User Created Successfully");
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(
                  userName: nameController.text,
                )),
      );
    }
  }
}
