import 'package:dogfinder/furyfriend.dart';
import 'package:dogfinder/howwework.dart';
import 'package:dogfinder/petinformation.dart';
import 'package:dogfinder/upload_screen.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  String? _profileImage;
  String? _name;
  String? _email;
  List<Map<String, String>> _pets = [];

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadPetData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _profileImage = prefs.getString('profile_image');
      _name = prefs.getString('name');
      _email = prefs.getString('email');
    });
  }

  Future<void> _loadPetData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _pets = [];
      int petCount = prefs.getInt('pet_count') ?? 0;
      for (int i = 1; i <= petCount; i++) {
        _pets.add({
          'name': prefs.getString('pet_name_$i') ?? '',
          'breed': prefs.getString('pet_breed_$i') ?? '',
          'weight': prefs.getString('pet_weight_$i') ?? '',
          'dob': prefs.getString('pet_dob_$i') ?? '',
          'color': prefs.getString('pet_color_$i') ?? '',
          'gender': prefs.getString('pet_gender_$i') ?? '',
          'description': prefs.getString('pet_description_$i') ?? '',
          'image': prefs.getString('pet_image_path_$i') ?? '',
        });
      }
    });
  }

  // void _showAllPetsPage() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => AllPetsPage(pets: _pets)),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.menu, color: Colors.black),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.pets),
              title: Text('Pet Information'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PetInformationScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.model_training),
              title: Text('AI Model'),
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => UploadScreen()),
                // );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey[300],
              backgroundImage: _profileImage != null
                  ? FileImage(File(_profileImage!))
                  : null,
              child: _profileImage == null
                  ? Icon(Icons.person, size: 40, color: Colors.white)
                  : null,
            ),
            SizedBox(height: 8),
            Text(
              _name ?? "Your Name",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              _email ?? "Your Email",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Your Pets",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                // TextButton(
                //   onPressed: _showAllPetsPage,
                //   child: Text("See All", style: TextStyle(color: Colors.grey)),
                // ),
              ],
            ),
            SizedBox(height: 10),
             Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        decoration: BoxDecoration(
                          color: Colors.teal[100],
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundColor: Colors.teal[100],
                              backgroundImage:
                                  AssetImage('assets/images/dog1.png'), // Replace with your image asset path
                            ),
                            // Icon(Icons.more_vert, color: Colors.black),
                          ],
                        ),
                      ),
                      SizedBox(height: 18),
                      DottedBorder(
                        color: Colors.grey,
                        strokeWidth: 2,
                        dashPattern: [6, 3],
                        borderType: BorderType.RRect,
                        radius: Radius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          margin: const EdgeInsets.only(right: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Rocky",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "American Pit Bull Terrier",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]
             ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Pet Care Nearby",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text("See All", style: TextStyle(color: Colors.grey)),
                ),
              ],
            ),
            DottedBorder(
              color: Colors.grey[300]!,
              borderType: BorderType.RRect,
              radius: Radius.circular(12),
              dashPattern: [8, 4],
              strokeWidth: 2,
              child: Container(
                padding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundImage: AssetImage(
                              'assets/images/dog1.png'), // Dummy image
                        ),
                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Animal Pet Care",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "0.23 km | ★ 4.2",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Chip(label: Text("Bathing")),
                        Chip(label: Text("Nail")),
                        Chip(label: Text("Teeth")),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(20.0),
      topRight: Radius.circular(20.0),
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        spreadRadius: 0,
        blurRadius: 10,
      ),
    ],
  ),
  child: BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    iconSize: 30,
    onTap: (index) {
      if (index == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => furryfriend()),
        );
      } else {
        // Handle other taps if needed
      }
    },
    items: [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        backgroundColor: Colors.white,
        label: '',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.message),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: Container(
          padding: const EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: Colors.orange,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.add, color: Colors.white),
        ),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.map),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: '',
      ),
    ],
  ),
),

    );
  }
}

