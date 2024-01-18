import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late Map<String, dynamic> userDetails = {}; // Initialize with an empty map

  @override
  void initState() {
    super.initState();
    // Fetch user details when the screen is initialized
    _getUserDetails();
  }

  Future<void> _getUserDetails() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String uin = prefs.getString('UIN') ?? '';

      final response = await http.get(Uri.parse('http://10.0.2.2:5000/user-details/$uin'));

      if (response.statusCode == 200) {
        print(response.body);
        // If the server returns a 200 OK response, parse the user details
        setState(() {
          userDetails = json.decode(response.body);
        });
      } else {
        // If the server did not return a 200 OK response, throw an exception.
        print(uin);
        throw Exception('Failed to load user details');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: userDetails.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildUserDetailItem('Name', userDetails['patientName']),
            _buildUserDetailItem('UIN', userDetails['UIN']),
            _buildUserDetailItem('Age', userDetails['age'].toString()),
            _buildUserDetailItem('Gender', userDetails['gender']),
            _buildUserDetailItem('Mobile', userDetails['mobile']),
            _buildUserDetailItem('Address', '${userDetails['address']}, ${userDetails['city']}'),
            // Add more fields as needed
          ],
        ),
      ),
    );
  }

  Widget _buildUserDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(value),
        ],
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserProfileScreen(),
    );
  }
}
