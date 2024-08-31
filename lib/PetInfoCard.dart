import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'dart:io';

class PetInfoCard extends StatelessWidget {
  final Map<String, String> pet;

  const PetInfoCard({required this.pet});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
                  backgroundImage: pet['image'] != null && pet['image']!.isNotEmpty
                      ? FileImage(File(pet['image']!))
                      : null,
                ),
                Icon(Icons.more_vert, color: Colors.black),
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
                    pet['name'] ?? '',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    pet['breed'] ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    pet['gender'] ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    pet['weight'] ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    pet['dob'] ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    pet['color'] ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    pet['description'] ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
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
