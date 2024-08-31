import 'package:dogfinder/findPet.dart';
import 'package:dogfinder/whatNext.dart';
import 'package:flutter/material.dart';

class furryfriend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(197, 238, 215, 173),
      body: Stack(
        children: [
          // Background Image
        Container(
  width: double.infinity, // Full width of the parent container
  height: double.infinity, // Full height of the parent container
  child: Align(
    alignment: Alignment(0, -2.9), // Adjust alignment to move the image up
    child: Image.asset(
      'assets/images/cat2.png', // Replace with your background image path
      width: 1480, // Increase the width to make the image larger
      height: 2402, // Increase the height to make the image larger
      fit: BoxFit.fitHeight, // Use BoxFit.contain to scale the image appropriately
    ),
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
                    'Found a furry friend?',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Found a lost pet? Scan the pet’s nose and see where to safely take them.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  SizedBox(height: 80),
                  ElevatedButton(
                    onPressed: () {
                       Navigator.push(context, MaterialPageRoute(builder: (context) => FindPet()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Color.fromARGB(197, 238, 215, 173), // Button color
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
