import 'package:dogfinder/signIn.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFD2F4F4), // background color
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0), // Adjusted vertical padding
              child: Column(
                children: [
                  // Text above the button
                  Text(
                    'Get ready to secure your pet’s identity with our easy nose scanning process. Tap ‘Get Started’ to create your account and begin!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Mulish',
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      height: 1.255, // 30.12 / 24
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  // Get Started button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignInScreen()), // Replace with your SignInScreen widget
    );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF47456D),
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15), // Adjusted padding
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                        fontFamily: 'Mulish',
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        height: 1.255, // 30.12 / 24
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Image of the dog
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Opacity(
                opacity: 1.0, // Set the opacity of the image
                child: Image.asset(
                  'assets/images/dog1.png', // Local asset image
                  width: 501,
                  height: 350,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
