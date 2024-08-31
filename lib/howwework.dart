import 'package:dogfinder/CameraScreen.dart';
import 'package:dogfinder/Upload_screen.dart';
import 'package:dogfinder/whatNext.dart'; // Make sure this path is correct and the Dog widget is defined in 1.dart
import 'package:flutter/material.dart';

class HowWeWork extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(197, 223, 185, 170),
      body: Stack(
        children: [
          // Background Image with smaller size, moved up
          Align(
            alignment: Alignment(0, -0.3), // Adjust alignment to move the image up
            child: Image.asset(
              'assets/images/dog2.png', // Replace with your background image path
              width: 400, // Adjust the width as needed to make the image smaller
              height: 400, // Adjust the height as needed to make the image smaller
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
                    'How We Work',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Did you know your pet's nose is as unique as a fingerprint? Scan/Boop your pet's nose and let our AI system identify them uniquely. Tap 'Begin Process' to start!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                         context,
                         MaterialPageRoute(builder: (context) => CameraScreen()), // Ensure this points to your Dog widget
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(197, 223, 185, 170), // Button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(70),
                      ),
                      minimumSize: Size(335, 65), // Button size
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Begin Process',
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
