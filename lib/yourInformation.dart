import 'package:dogfinder/DogProfile.dart';
import 'package:dogfinder/profile.dart';
import 'package:dogfinder/upload_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class YourInformationScreen extends StatefulWidget {
  @override
  _YourInformationScreenState createState() => _YourInformationScreenState();
}

class _YourInformationScreenState extends State<YourInformationScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _dobController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _gender = '';

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  Future<void> _pickDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (selectedDate != null) {
      setState(() {
        _dobController.text = "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
      });
    }
  }

  Future<void> _saveData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (_imageFile != null) {
    await prefs.setString('profile_image', _imageFile!.path);
  }
  await prefs.setString('name', _nameController.text);
  await prefs.setString('phone', _phoneController.text); // Phone number is saved here
  await prefs.setString('email', _emailController.text);
  await prefs.setString('dob', _dobController.text);
  await prefs.setString('description', _descriptionController.text);
  await prefs.setString('gender', _gender);
}


  bool _isFormValid() {
    return _nameController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _dobController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        _gender.isNotEmpty &&
        _imageFile != null;
  }

  void _showError(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Please fill all fields and upload a profile picture.'),
      ),
    );
  }

  void _onGenderSelected(String gender) {
    setState(() {
      _gender = gender;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Your Information', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold) ),
            Image.asset(
              'assets/images/logo.png',
              width: 130,
              height: 130,
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: _imageFile == null
                        ? Icon(
                            Icons.cloud_upload,
                            size: 50,
                            color: Colors.grey.shade700,
                          )
                        : Image.file(
                            File(_imageFile!.path),
                            fit: BoxFit.cover,
                          ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Upload Profile Picture',
                    style: TextStyle(fontSize: 18, color: Colors.grey.shade700),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Your Name',
                      hintText: "Name",
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      hintText: "Number",
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: "email",
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('GENDER', style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                _onGenderSelected('Male');
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(10, 40),
                                backgroundColor: _gender == 'Male' ? Colors.blue : Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              child: Text('Male', style: TextStyle(color: _gender == 'Male' ? Colors.white : Colors.black, fontSize: 10)),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                _onGenderSelected('Female');
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(10, 40),
                                backgroundColor: _gender == 'Female' ? Colors.blue : Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              child: Text('Female', style: TextStyle(color: _gender == 'Female' ? Colors.white : Colors.black, fontSize: 7)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _dobController,
                    decoration: InputDecoration(
                      labelText: 'DATE OF BIRTH',
                      hintText: 'DD/MM/YYYY',
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onTap: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      await _pickDate(context);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description About Your Pet',
                hintText: 'Your Message Here...',
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_isFormValid()) {
                      _saveData().then((_) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfilePage()));
                      });
                    } else {
                      _showError(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: Size(200, 65),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text('Next', style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
                // SizedBox(width: 10,),
                // ElevatedButton(
                //   onPressed: () {
                //     if (_isFormValid()) {
                //       _saveData().then((_) {
                //         Navigator.push(context, MaterialPageRoute(builder: (context) => UploadScreen()));
                //       });
                //     } else {
                //       _showError(context);
                //     }
                //   },
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Colors.blue,
                //     minimumSize: Size(200, 65),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(20),
                //     ),
                //   ),
                //   child: Text('your', style: TextStyle(fontSize: 18, color: Colors.white)),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
