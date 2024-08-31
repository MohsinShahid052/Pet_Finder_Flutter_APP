// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:io';

// class DogProfilePage extends StatefulWidget {
//   @override
//   _DogProfilePageState createState() => _DogProfilePageState();
// }

// class _DogProfilePageState extends State<DogProfilePage> {
//   String petName = '';
//   String petBreed = '';
//   String petWeight = '';
//   String petDob = '';
//   String petColor = '';
//   String petGender = '';
//   String petDescription = '';
//   String petImagePath = '';
//   bool isMaleSelected = false;

//   @override
//   void initState() {
//     super.initState();
//     _loadData();
//   }

//   Future<void> _loadData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       petName = prefs.getString('pet_name') ?? '';
//       petBreed = prefs.getString('pet_breed') ?? '';
//       petWeight = prefs.getString('pet_weight') ?? '';
//       petDob = prefs.getString('pet_dob') ?? '';
//       petColor = prefs.getString('pet_color') ?? '';
//       petGender = prefs.getString('pet_gender') ?? '';
//       petDescription = prefs.getString('pet_description') ?? '';
//       petImagePath = prefs.getString('pet_image_path') ?? '';
//       isMaleSelected = petGender == 'Male';
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Top half with yellow background and dog image
//             Container(
//               color: Colors.yellow[700],
//               height: MediaQuery.of(context).size.height * 0.25,
//               width: double.infinity,
//               child: Align(
//                 alignment: Alignment.bottomRight,
//                 child: petImagePath.isNotEmpty
//                     ? Image.file(
//                         File(petImagePath),
//                         fit: BoxFit.cover,
//                         errorBuilder: (context, error, stackTrace) {
//                           return Image.asset(
//                             'assets/images/dog3.png', // Replace with your default dog image path
//                             fit: BoxFit.contain,
//                           );
//                         },
//                       )
//                     : Image.asset(
//                         'assets/images/dog3.png', // Replace with your default dog image path
//                         fit: BoxFit.contain,
//                       ),
//               ),
//             ),
//             // Bottom half with white background and details
//             Expanded(
//               child: Container(
//                 color: Colors.white,
//                 padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Name and Icon Card at the top of the bottom half
//                       buildDogInfoCard(),
//                       SizedBox(height: 20),
//                       // About Section
//                       Container(
//                         padding: EdgeInsets.all(20),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(15),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black12,
//                               offset: Offset(0, 5),
//                               blurRadius: 10,
//                             ),
//                           ],
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               children: [
//                                 Icon(Icons.pets, color: Colors.black),
//                                 SizedBox(width: 10),
//                                 Text(
//                                   'About $petName',
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 10),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 InfoCard(
//                                   label: 'Weight',
//                                   value: '$petWeight kg',
//                                 ),
//                                 InfoCard(
//                                   label: 'Gender',
//                                   value: petGender,
//                                 ),
//                                 InfoCard(
//                                   label: 'Color',
//                                   value: petColor,
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 20),
//                             Text(
//                               petDescription,
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 color: Colors.grey[800],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(height: 20),
//                       // Behavior Section
//                       Container(
//                         padding: EdgeInsets.all(20),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(15),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black12,
//                               offset: Offset(0, 5),
//                               blurRadius: 10,
//                             ),
//                           ],
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               children: [
//                                 Icon(Icons.face, color: Colors.black),
//                                 SizedBox(width: 10),
//                                 Text(
//                                   '$petName behavior',
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 10),
//                             Wrap(
//                               spacing: 10,
//                               runSpacing: 10,
//                               children: [
//                                 BehaviorChip(label: 'Leash trained'),
//                                 BehaviorChip(label: 'Friendly with cats'),
//                                 BehaviorChip(label: 'Active'),
//                                 BehaviorChip(label: 'Tries to eat things'),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildDogInfoCard() {
//     return Container(
//       padding: EdgeInsets.all(15),
//       decoration: BoxDecoration(
//         color: Color.fromARGB(255, 243, 232, 202),
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12,
//             offset: Offset(0, 5),
//             blurRadius: 10,
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   petName,
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//                 Text(
//                   '$petBreed · $petDob',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.grey[700],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: Colors.yellow[700],
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Icon(
//               isMaleSelected ? Icons.male : Icons.female,
//               color: Colors.white,
//               size: 20,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class InfoCard extends StatelessWidget {
//   final String label;
//   final String value;

//   const InfoCard({required this.label, required this.value});

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Container(
//         padding: EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           color: Color(0xFFFBEED6),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Column(
//           children: [
//             Text(
//               label,
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.grey[700],
//               ),
//             ),
//             Text(
//               value,
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.yellow[700],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class BehaviorChip extends StatelessWidget {
//   final String label;

//   const BehaviorChip({required this.label});

//   @override
//   Widget build(BuildContext context) {
//     return Chip(
//       label: Text(
//         label,
//         style: TextStyle(
//           color: Colors.grey[700],
//         ),
//       ),
//       shape: StadiumBorder(
//         side: BorderSide(
//           color: Color.fromARGB(255, 240, 221, 46),
//           width: 1,
//         ),
//       ),
//       backgroundColor: Color.fromARGB(255, 254, 253, 235),
//     );
//   }
// }

import 'package:dogfinder/whatNext.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class DogProfilePage extends StatefulWidget {
  @override
  _DogProfilePageState createState() => _DogProfilePageState();
}

class _DogProfilePageState extends State<DogProfilePage> {
  String petName = '';
  String petBreed = '';
  String petWeight = '';
  String petDob = '';
  String petColor = '';
  String petGender = '';
  String petDescription = '';
  String petImagePath = '';
  bool isMaleSelected = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      petName = prefs.getString('pet_name') ?? '';
      petBreed = prefs.getString('pet_breed') ?? '';
      petWeight = prefs.getString('pet_weight') ?? '';
      petDob = prefs.getString('pet_dob') ?? '';
      petColor = prefs.getString('pet_color') ?? '';
      petGender = prefs.getString('pet_gender') ?? '';
      petDescription = prefs.getString('pet_description') ?? '';
      petImagePath = prefs.getString('pet_image_path') ?? '';
      isMaleSelected = petGender == 'Male';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top half with yellow background and dog image
            Container(
              color: Colors.yellow[700],
              height: MediaQuery.of(context).size.height * 0.25,
              width: double.infinity,
              child: Align(
                alignment: Alignment.bottomRight,
                child: petImagePath.isNotEmpty
                    ? Image.file(
                        File(petImagePath),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/dog3.png', // Replace with your default dog image path
                            fit: BoxFit.contain,
                          );
                        },
                      )
                    : Image.asset(
                        'assets/images/dog3.png', // Replace with your default dog image path
                        fit: BoxFit.contain,
                      ),
              ),
            ),
            // Bottom half with white background and details
            Expanded(
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name and Icon Card at the top of the bottom half
                      buildDogInfoCard(),
                      SizedBox(height: 20),
                      // About Section
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, 5),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.pets, color: Colors.black),
                                SizedBox(width: 10),
                                Text(
                                  'About $petName',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InfoCard(
                                  label: 'Weight',
                                  value: '$petWeight kg',
                                ),
                                InfoCard(
                                  label: 'Gender',
                                  value: petGender,
                                ),
                                InfoCard(
                                  label: 'Color',
                                  value: petColor,
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Text(
                              petDescription,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[800],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      // Behavior Section
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, 5),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.face, color: Colors.black),
                                SizedBox(width: 10),
                                Text(
                                  '$petName behavior',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: [
                                BehaviorChip(label: 'Leash trained'),
                                BehaviorChip(label: 'Friendly with cats'),
                                BehaviorChip(label: 'Active'),
                                BehaviorChip(label: 'Tries to eat things'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      // Next Button
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 240, 180, 62),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                          ),
                          onPressed: () {
                             Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WhatNext()), // Ensure this points to your Dog widget
                      );
                          },
                          child: Text(
                            'Next',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDogInfoCard() {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 243, 232, 202),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 5),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  petName,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '$petBreed · $petDob',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.yellow[700],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              isMaleSelected ? Icons.male : Icons.female,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String label;
  final String value;

  const InfoCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color(0xFFFBEED6),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.yellow[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BehaviorChip extends StatelessWidget {
  final String label;

  const BehaviorChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        label,
        style: TextStyle(
          color: Colors.grey[700],
        ),
      ),
      shape: StadiumBorder(
        side: BorderSide(
          color: Color.fromARGB(255, 240, 221, 46),
          width: 1,
        ),
      ),
      backgroundColor: Color.fromARGB(255, 254, 253, 235),
    );
  }
}
