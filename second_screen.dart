import 'package:flutter/material.dart';
import 'login_Screen.dart'; // Import the login screen file
import 'sign_up_screen.dart'; // Import the sign-up screen file

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(
          0xFFF1F1F1), // Light grey background to match splash screen theme
      body: Stack(
        children: [
          // Main content
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 40.0), // Horizontal padding for alignment
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment
                    .stretch, // Stretch elements to full width
                children: [
                  // Logo and App Name
                  Column(
                    children: const [
                      Icon(
                        Icons.remove_red_eye, // Placeholder for eye icon
                        size: 100.0,
                        color: Color(
                            0xFF1E88E5), // Blue color for the logo (matching splash screen theme)
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
                  const SizedBox(height: 60.0),
                  // Sign In and Sign Up Buttons
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Color(0xFF1E88E5), // Blue color for the button
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            20.0), // Rounded corners for the button
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      minimumSize:
                          const Size(double.infinity, 50), // Full-width button
                    ),
                    child: const Text(
                      'SIGN IN',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white, // White text for the button
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Color(0xFF1E88E5), // Blue color for the button
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            20.0), // Rounded corners for the button
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      minimumSize:
                          const Size(double.infinity, 50), // Full-width button
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
                ],
              ),
            ),
          ),
          // Version Text positioned at the bottom right
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
}
