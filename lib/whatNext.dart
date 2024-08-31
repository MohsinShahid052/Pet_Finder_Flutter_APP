import 'package:dogfinder/whatNext.dart'; // Make sure this path is correct and the Dog widget is defined in 1.dart
import 'package:dogfinder/yourInformation.dart';
import 'package:flutter/material.dart';

class WhatNext extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(197, 238, 215, 173),
      body: Stack(
        children: [
          // Background Image with smaller size, moved up
          Align(
            alignment: Alignment(0, -0.9), // Adjust alignment to move the image up
            child: Image.asset(
              'assets/images/dog3.png', // Replace with your background image path
              width: 450, // Adjust the width as needed to make the image smaller
              height: 450, // Adjust the height as needed to make the image smaller
              fit: BoxFit.contain,
            ),
          ),
          // White overlay with rounded corners
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 330,
              height: 330, // Adjust the height as needed
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(100),
                  topRight: Radius.circular(100),
                ),
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 10),
                  Text(
                    'What’s Next?',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 40),
                  Text(
                    "Create your own profile! Don’t worry all personal information with be encrypted",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  SizedBox(height: 70),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => YourInformationScreen()), // Ensure this points to your Dog widget
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(197, 238, 215, 173), // Button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(70),
                      ),
                      minimumSize: Size(335, 65), // Button size
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Next',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        Icon(
                          Icons.pets,
                          size: 24,
                          color: Colors.black, // Icon color
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
