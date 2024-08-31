import 'package:dogfinder/petinformation.dart';
import 'package:flutter/material.dart';

class OurServicesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 141, 166, 209), // Set the background color to blue
      body: Stack(
        children: [
          // Center the Cat Image a bit higher
          Align(
            alignment: Alignment(0, -2.4), // Adjust the alignment to move the cat image up
            child: Image.asset(
              'assets/images/cat1.png', // Replace with your background image path
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
                    'Our Services',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'We offer a painless alternative to micro-chipping, so that your fluffy friend doesn’t have to go through any unnecessary procedures. Let’s start with some information about your pet!',
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
                        MaterialPageRoute(builder: (context) => PetInformationScreen()), // Replace with your SignInScreen widget
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 173, 199, 243), // Button color
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
                        SizedBox(width: 10),
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
