import 'package:dogfinder/upload_screen.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:ui';
import 'dart:async';
import 'dart:io';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? controller;
  List<CameraDescription>? cameras;
  bool isCameraInitialized = false;
  XFile? capturedImage;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    controller = CameraController(cameras![0], ResolutionPreset.high);
    await controller!.initialize();
    setState(() {
      isCameraInitialized = true;
    });

    // Schedule a photo to be taken after 7 seconds
    Timer(Duration(seconds: 7), () {
      if (isCameraInitialized) {
        takePicture();
      }
    });
  }

  Future<void> takePicture() async {
    if (!controller!.value.isInitialized) {
      return null;
    }
    if (controller!.value.isTakingPicture) {
      return null;
    }

    try {
      XFile image = await controller!.takePicture();
      setState(() {
        capturedImage = image;
      });

      // Navigate to the UploadScreen with the captured image path
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UploadScreen(imagePath: capturedImage!.path),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isCameraInitialized
          ? Stack(
              children: [
                CameraPreview(controller!),
                ClipPath(
                  clipper: CircleClipper(),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Reduced blur effect
                    child: Container(
                      color: Colors.black.withOpacity(0),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.red,
                        width: 3.0,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 120, // Adjust this value as needed
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        "Fill the circle with your dog's face!",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10, // Adjust this value as needed
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 65, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(width: 16),
                          Text(
                            "Detecting...",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          SizedBox(width: 16),
                          Icon(Icons.notifications, color: Colors.red),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}

class CircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double radius = 150; // Radius of the circle
    path.addOval(Rect.fromCircle(center: Offset(centerX, centerY), radius: radius));
    path.addRect(Rect.fromLTRB(0, 0, size.width, size.height));
    path.fillType = PathFillType.evenOdd; // This will create a cutout effect
    return path;
  }

  @override
  bool shouldReclip(CircleClipper oldClipper) => false;
}
