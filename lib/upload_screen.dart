import 'dart:io';
import 'package:dogfinder/DogProfile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_service.dart';

class UploadScreen extends StatefulWidget {
  final String imagePath;

  UploadScreen({required this.imagePath});

  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final ApiService _apiService = ApiService();
  File? _selectedImage;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  bool _isScanning = false;

  @override
  void initState() {
    super.initState();
    _selectedImage = File(widget.imagePath); // Set the captured image
    _loadPetInformation(); // Load pet information from SharedPreferences
  }

  Future<void> _loadPetInformation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString('pet_name');
    String? age = prefs.getString('pet_weight');
    if (name != null) {
      _nameController.text = name;
    }
    if (age != null) {
      _ageController.text = age;
    }
  }

  Future<void> _uploadImage() async {
    if (_selectedImage != null &&
        _nameController.text.isNotEmpty &&
        _ageController.text.isNotEmpty) {
      setState(() {
        _isScanning = true;
      });

      try {
        await _apiService.uploadImage(
            _selectedImage!, _nameController.text, int.parse(_ageController.text));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Image uploaded successfully')),
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
        SnackBar(content: Text('Failed to upload image')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
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
                                  ],
                                ),
                              )
                            : null,
                      ),
                    SizedBox(height: 20),
                    Column(
                      children: [
                        SizedBox(height: 10),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          color: Color.fromARGB(255, 240, 180, 62),
                          child: ListTile(
                            title: Text(
                              'Upload Image',
                              style: TextStyle(color: Colors.black),
                            ),
                            onTap: _uploadImage,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 240, 180, 62),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DogProfilePage()));
                  },
                  child: Text(
                    'Next',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
