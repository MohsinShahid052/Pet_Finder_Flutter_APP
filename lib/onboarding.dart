import 'package:dogfinder/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late VideoPlayerController _controller;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/images/video.mp4') // Update the path to your video
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });

    _timer = Timer(Duration(seconds: 13), () {
      // Navigate to another page after 10 seconds
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SplashScreen()), // Replace NextScreen with your target screen
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Upper background shape
          Positioned(
            top: -55,
            left: -19,
            child: Container(
              width: 500,
              height: 150,
              decoration: BoxDecoration(
                color: Color(0xFF7B87C0),
              ),
            ),
          ),
          // Video in the center
          Center(
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : CircularProgressIndicator(),
          ),
          // Lower background shape
          Positioned(
            top: 650,
            // left: 10,
              child: Container(
                width: 478.64,
                height: 460.45,
                decoration: BoxDecoration(
                  color: Color(0xFF7B87C0),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

