import 'package:dogfinder/CameraScreen.dart';
import 'package:dogfinder/howwework.dart';
import 'package:dogfinder/profile.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'DogProfile.dart';   // Ensure you import DogProfilePage here

class PetInformationScreen extends StatefulWidget {
  @override
  _PetInformationScreenState createState() => _PetInformationScreenState();
}

class _PetInformationScreenState extends State<PetInformationScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  bool isMaleSelected = false;
  bool isFemaleSelected = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController breedController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = pickedFile;
    });

    // Save the image path to SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('pet_image_path', _imageFile?.path ?? '');
  }

  void _selectGender(String gender) {
    setState(() {
      if (gender == 'male') {
        isMaleSelected = true;
        isFemaleSelected = false;
      } else {
        isMaleSelected = false;
        isFemaleSelected = true;
      }
    });

    // Save the gender selection to SharedPreferences
    _saveGender(gender);
  }

  Future<void> _saveGender(String gender) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('pet_gender', gender);
  }
Future<void> _saveData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  
  await prefs.setString('pet_name', nameController.text);
  await prefs.setString('pet_breed', breedController.text);
  await prefs.setString('pet_weight', weightController.text);
  await prefs.setString('pet_dob', dobController.text);
  await prefs.setString('pet_color', colorController.text);
  await prefs.setString('pet_description', descriptionController.text);
  await prefs.setString('pet_gender', isMaleSelected ? 'Male' : 'Female');
  await prefs.setString('pet_image_path', _imageFile?.path ?? '');
}

void _validateAndProceed() {
  if (nameController.text.isEmpty ||
      breedController.text.isEmpty ||
      weightController.text.isEmpty ||
      dobController.text.isEmpty ||
      colorController.text.isEmpty ||
      descriptionController.text.isEmpty ||
      (!isMaleSelected && !isFemaleSelected) ||
      _imageFile == null) {
    _showError('Please fill all the fields and upload a Dog Image.');
  } else {
    _saveData().then((_) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HowWeWork()),
      );
    });
  }
}

  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        dobController.text = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.black,
      ),
    );
  }

  // void _validateAndProceed() {
  //   if (nameController.text.isEmpty ||
  //       breedController.text.isEmpty ||
  //       weightController.text.isEmpty ||
  //       dobController.text.isEmpty ||
  //       colorController.text.isEmpty ||
  //       descriptionController.text.isEmpty ||
  //       (!isMaleSelected && !isFemaleSelected) ||
  //       _imageFile == null) {
  //     _showError('Please fill all the fields and upload a Dog Image.');
  //   } else {
  //     _saveData().then((_) {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => DogProfilePage()),
  //       );
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Pet Information', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
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
                    'Upload Dog Image',
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
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'PET NAME',
                      hintText: "Dog's Name...",
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: breedController,
                    decoration: InputDecoration(
                      labelText: 'PET BREED',
                      hintText: "Dog's Breed...",
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
                    controller: weightController,
                    decoration: InputDecoration(
                      labelText: 'PET WEIGHT',
                      hintText: "Dog's Weight (In Kg)",
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
                                _selectGender('male');
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(10, 40), // Adjusted size
                                backgroundColor: isMaleSelected ? Colors.blue : Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4), // Rectangular shape
                                ),
                              ),
                              child: Text('Male', style: TextStyle(color: isMaleSelected ? Colors.white : Colors.black, fontSize: 10)),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                _selectGender('female');
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(10, 40), // Adjusted size
                                backgroundColor: isFemaleSelected ? Colors.blue : Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4), // Rectangular shape
                                ),
                              ),
                              child: Text('Female', style: TextStyle(color: isFemaleSelected ? Colors.white : Colors.black, fontSize: 7)),
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
                    controller: dobController,
                    decoration: InputDecoration(
                      labelText: 'DATE OF BIRTH',
                      hintText: 'DD/MM/YYYY',
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    readOnly: true,
                    onTap: _selectDate,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: colorController,
                    decoration: InputDecoration(
                      labelText: 'COLOR',
                      hintText: "Dog's Color...",
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            TextField(
              controller: descriptionController,
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
                  onPressed: _validateAndProceed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: Size(200, 65),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('Next', style: TextStyle(color: Colors.white)),
                ),
                // SizedBox(width: 10),
                // ElevatedButton(
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => UserProfilePage()),
                //     );
                //   },
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Colors.grey,
                //     minimumSize: Size(200, 65),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(20),
                //     ),
                //   ),
                //   child: Text('User Profile', style: TextStyle(fontSize: 18, color: Colors.white)),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
