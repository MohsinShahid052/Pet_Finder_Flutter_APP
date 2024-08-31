import 'package:dogfinder/DogProfile.dart';
import 'package:dogfinder/findPet.dart';
import 'package:dogfinder/upload_screen.dart';
import 'package:dogfinder/whatNext.dart';
import 'package:dogfinder/cat.dart';
import 'package:dogfinder/furyfriend.dart';
import 'package:dogfinder/howwework.dart';
import 'package:dogfinder/onboarding.dart';
import 'package:dogfinder/ourservice.dart';
import 'package:dogfinder/petinformation.dart';
import 'package:dogfinder/profile.dart';
import 'package:dogfinder/signIn.dart';
import 'package:dogfinder/splashscreen.dart';
import 'package:dogfinder/yourInformation.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(BoopidApp());
}

class BoopidApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: OnboardingScreen(),
      ),
    );
  }
}
