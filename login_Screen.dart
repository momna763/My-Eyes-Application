import 'package:flutter/material.dart';
import 'package:my_eyes/auth_service.dart';
import 'forgot_password_screen.dart'; // Import the new forgot password screen file
import 'home_page.dart'; // Import the HomePage
import 'package:flutter_tts/flutter_tts.dart'; // Import TTS package

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = AuthService();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FlutterTts flutterTts = FlutterTts(); // TTS instance

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Speak the screen title
    _speak("Welcome to My Eyes. Please enter your email and password.");
  }

  Future _speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(
          0xFFF1F1F1), // Light grey background to match the consistent theme
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo and App Name
                  Column(
                    children: const [
                      Icon(
                        Icons.remove_red_eye, // Placeholder for eye icon
                        size: 100.0,
                        color: Color(
                            0xFF1E88E5), // Blue color for the logo (consistent theme)
                      ),
                      SizedBox(height: 16.0),
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
                  const SizedBox(height: 40.0),
                  // Email Input Field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: TextField(
                      controller: emailController, // Controller for email input
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Enter E-mail',
                        prefixIcon: Icon(Icons.email, color: Color(0xFF1E88E5)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onTap: () => _speak("Please enter your email address."),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  // Password Input Field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: TextField(
                      controller:
                          passwordController, // Controller for password input
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Enter Password',
                        prefixIcon: Icon(Icons.lock, color: Color(0xFF1E88E5)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onTap: () => _speak("Please enter your password."),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  // Login Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFF1E88E5), // Consistent blue color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              30.0), // Rounded corners for the button
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        minimumSize: const Size(
                            double.infinity, 50), // Full-width button
                      ),
                      child: const Text(
                        'LOGIN',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white, // White text for the button
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  // Forget Password
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPasswordScreen()),
                      );
                    },
                    child: const Text(
                      'Forget Password?',
                      style: TextStyle(
                        color:
                            Color(0xFF1E88E5), // Blue color for the text link
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  // Register with G-mail
                  GestureDetector(
                    onTap: () {
                      // Add Google Sign-Up functionality
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Register with G-mail',
                          style: TextStyle(
                            color: Color(0xFF888888),
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Icon(
                          Icons.email, // Placeholder for Gmail icon
                          color: Color.fromARGB(255, 255, 18, 1),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Version Text at the bottom right
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: const Text(
              'Version 1.0',
              style: TextStyle(
                fontSize: 14.0,
                color: Color(0xFF888888), // Soft gray for version text
              ),
            ),
          ),
        ],
      ),
    );
  }

  _login() async {
    final user = await _auth.loginUserWithEmailAndPassword(
        emailController.text, passwordController.text);

    if (user != null) {
      logger.d("User Logged In Successfully");
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(
                  userName: "User Name",
                )),
      );
    }
  }
}
