import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class ApiService {
  final String baseUrl = 'http://35.215.117.194:8000';

  Future<void> uploadImage(File image, String dogName, int dogAge) async {
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/upload/'));
    request.files.add(await http.MultipartFile.fromPath('file', image.path));
    request.fields['dog_name'] = dogName;
    request.fields['dog_age'] = dogAge.toString();

    var response = await request.send();
    if (response.statusCode == 200) { 
      print('Image uploaded successfully');
    } else {
      print('Failed to upload image');
    }
  }

  Future<void> updateDog(String dogId, List<double> vector) async {
    var response = await http.post(
      Uri.parse('$baseUrl/update/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'dog_id': dogId, 'vector': vector}),
    );
    if (response.statusCode == 200) {
      print('Dog updated successfully');
    } else {
      print('Failed to update dog');
    }
  }

  Future<void> deleteDog(String dogId) async {
    var response = await http.post(
      Uri.parse('$baseUrl/delete/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'dog_id': dogId}),
    );
    if (response.statusCode == 200) {
      print('Dog deleted successfully');
    } else {
      print('Failed to delete dog');
    }
  }

  Future<void> findClosestMatch(File image) async {
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/find_closest/'));
    request.files.add(await http.MultipartFile.fromPath('file', image.path));

    var response = await request.send();
    if (response.statusCode == 200) {
      var responseData = await http.Response.fromStream(response);
      print('Closest match: ${responseData.body}');
    } else {
      print('Failed to find closest match');
    }
  }
}
