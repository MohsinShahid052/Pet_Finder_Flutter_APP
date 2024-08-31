
// import 'dart:io';
// import 'package:dogfinder/PetFinderCamera.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'api_service.dart';
// import 'CameraScreen.dart'; 

// class FindPet extends StatefulWidget {
//   @override
//   _FindPetState createState() => _FindPetState();
// }

// class _FindPetState extends State<FindPet> {
//   final ApiService _apiService = ApiService();
//   final ImagePicker _picker = ImagePicker();
//   File? _selectedImage;
//   bool _isScanning = false;
//   String? _ownerContact;

//   @override
//   void initState() {
//     super.initState();
//     _loadOwnerContact();
//   }

//   Future<void> _loadOwnerContact() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _ownerContact = prefs.getString('phone');
//     });
//   }

//   Future<void> _pickImage(ImageSource source) async {
//     final pickedFile = await _picker.pickImage(source: source);
//     if (pickedFile != null) {
//       setState(() {
//         _selectedImage = File(pickedFile.path);
//         _isScanning = true;
//       });

//       await Future.delayed(Duration(seconds: 10));

//       setState(() {
//         _isScanning = false;
//       });
//     }
//   }

//   Future<void> _captureImage(BuildContext context) async {
//     final capturedImage = await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => PetFinderCamera(),
//       ),
//     );

//     if (capturedImage != null) {
//       setState(() {
//         _selectedImage = File(capturedImage);
//         _isScanning = false;
//       });
//     }
//   }

//   Future<void> _findClosestMatch() async {
//     if (_selectedImage != null) {
//       setState(() {
//         _isScanning = true;
//       });

//       await _apiService.findClosestMatch(_selectedImage!);

//       setState(() {
//         _isScanning = false;
//       });

//       if (_ownerContact != null && _ownerContact!.isNotEmpty) {
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: Text('Owner Contact',),
//               content: Card(
//                 color: Color.fromARGB(255, 240, 180, 62),
//                 child: ListTile(
//                   title: Text(
//                     _ownerContact!,
//                     style: TextStyle(color: Colors.black),
//                   ),
//                   onTap: () => _openChat(_ownerContact!),
//                 ),
//               ),
//             );
//           },
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Owner contact not found')),
//         );
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('No image selected')),
//       );
//     }
//   }

//   Future<void> _openChat(String contact) async {
//     try {
//       String message = 'Hello, I found your pet';
//       String url = 'https://wa.me/$contact?text=${Uri.encodeComponent(message)}';

//       if (await canLaunch(url)) {
//         await launch(url);
//       } else {
//         throw 'Could not launch $url';
//       }
//     } catch (e) {
//       print('Error opening WhatsApp: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error opening WhatsApp: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 if (_selectedImage != null)
//                   Container(
//                     height: 500,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12),
//                       image: DecorationImage(
//                         image: FileImage(_selectedImage!),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     child: _isScanning
//                         ? Center(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 CircularProgressIndicator(),
//                                 SizedBox(height: 20),
//                                 Text('Scanning... Please wait'),
//                               ],
//                             ),
//                           )
//                         : null,
//                   ),
//                 SizedBox(height: 20),
//                 Column(
//                   children: [
//                     Card(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       color: Color.fromARGB(255, 240, 180, 62),
//                       child: ListTile(
//                         title: Text(
//                           'Pick Image',
//                           style: TextStyle(color: Colors.black),
//                         ),
//                         onTap: () => _pickImage(ImageSource.gallery),
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     Card(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       color: Color.fromARGB(255, 240, 180, 62),
//                       child: ListTile(
//                         title: Text(
//                           'Capture Image',
//                           style: TextStyle(color: Colors.black),
//                         ),
//                         onTap: () => _captureImage(context),
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     Card(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       color: Color.fromARGB(255, 240, 180, 62),
//                       child: ListTile(
//                         title: Text(
//                           'Find Pet',
//                           style: TextStyle(color: Colors.black),
//                         ),
//                         onTap: _findClosestMatch,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'dart:io';
import 'package:dogfinder/PetFinderCamera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'api_service.dart';
import 'CameraScreen.dart'; 

class FindPet extends StatefulWidget {
  @override
  _FindPetState createState() => _FindPetState();
}

class _FindPetState extends State<FindPet> {
  final ApiService _apiService = ApiService();
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  bool _isScanning = false;
  String? _ownerContact;

  @override
  void initState() {
    super.initState();
    _loadOwnerContact();
  }

  Future<void> _loadOwnerContact() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _ownerContact = prefs.getString('phone');
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        _isScanning = true;
      });

      await Future.delayed(Duration(seconds: 10));

      setState(() {
        _isScanning = false;
      });
    }
  }

  Future<void> _captureImage(BuildContext context) async {
    final capturedImage = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PetFinderCamera(),
      ),
    );

    if (capturedImage != null) {
      setState(() {
        _selectedImage = File(capturedImage);
        _isScanning = false;
      });
    }
  }

  Future<void> _findClosestMatch() async {
    if (_selectedImage != null) {
      setState(() {
        _isScanning = true;
      });

      try {
        await _apiService.findClosestMatch(_selectedImage!);

        if (_ownerContact != null && _ownerContact!.isNotEmpty) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Owner Contact',),
                content: Card(
                  color: Color.fromARGB(255, 240, 180, 62),
                  child: ListTile(
                    title: Text(
                      _ownerContact!,
                      style: TextStyle(color: Colors.black),
                    ),
                    onTap: () => _openChat(_ownerContact!),
                  ),
                ),
              );
            },
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Owner contact not found')),
          );
        }
      } on SocketException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Server error, please try again later')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Server error, please try again later')),
        );
      } finally {
        setState(() {
          _isScanning = false;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No image selected')),
      );
    }
  }

  Future<void> _openChat(String contact) async {
    try {
      String message = 'Hello, I found your pet';
      String url = 'https://wa.me/$contact?text=${Uri.encodeComponent(message)}';

      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error opening WhatsApp: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error opening WhatsApp: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                if (_selectedImage != null)
                  Container(
                    height: 500,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: FileImage(_selectedImage!),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: _isScanning
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(height: 20),
                                Text('Scanning... Please wait'),
                              ],
                            ),
                          )
                        : null,
                  ),
                SizedBox(height: 20),
                Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      color: Color.fromARGB(255, 240, 180, 62),
                      child: ListTile(
                        title: Text(
                          'Pick Image',
                          style: TextStyle(color: Colors.black),
                        ),
                        onTap: () => _pickImage(ImageSource.gallery),
                      ),
                    ),
                    SizedBox(height: 10),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      color: Color.fromARGB(255, 240, 180, 62),
                      child: ListTile(
                        title: Text(
                          'Capture Image',
                          style: TextStyle(color: Colors.black),
                        ),
                        onTap: () => _captureImage(context),
                      ),
                    ),
                    SizedBox(height: 10),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      color: Color.fromARGB(255, 240, 180, 62),
                      child: ListTile(
                        title: Text(
                          'Find Pet',
                          style: TextStyle(color: Colors.black),
                        ),
                        onTap: _findClosestMatch,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
