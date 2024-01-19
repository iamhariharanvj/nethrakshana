import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BookAppointmentScreen extends StatefulWidget {
  @override
  _BookAppointmentScreenState createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  DateTime selectedDate = DateTime.now();
  String selectedLocation = 'Madurai'; // Default location

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Appointment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Date:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text('Select Date'),
            ),
            SizedBox(height: 8),
            Text(
              'Selected Date: ${_formattedDate(selectedDate)}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Select Location:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text(selectedLocation),
              onTap: () => _selectLocation(context),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _bookAppointment(),
              child: Text('Book Appointment'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  String _formattedDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  Future<void> _selectLocation(BuildContext context) async {
    // Fetch the list of locations from the server
    final String serverUrl = 'https://nethrakshana.onrender.com/locations';

    try {
      final response = await http.get(Uri.parse(serverUrl));

      if (response.statusCode == 200) {
        List<dynamic> locations = json.decode(response.body);

        // Show a bottom sheet with the list of locations
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: 200,
              child: ListView.builder(
                itemCount: locations.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(locations[index]['name']),
                    onTap: () {
                      setState(() {
                        selectedLocation = locations[index]['name'];
                      });
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            );
          },
        );
      } else {
        print('Failed to fetch locations: ${response.statusCode}');
        // Handle failure, e.g., show an error message to the user
      }
    } catch (e) {
      print('Error while fetching locations: $e');
      // Handle the error, e.g., show an error message to the user
    }
  }

  Future<void> _bookAppointment() async {
    final String serverUrl = 'https://nethrakshana.onrender.com/book-appointment';

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userUIN = prefs.getString('UIN') ?? '';

    Map<String, dynamic> appointmentDetails = {
      'UIN': userUIN,
      'date': _formattedDate(selectedDate),
      'location': selectedLocation,
    };

    try {
      final response = await http.post(
        Uri.parse(serverUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(appointmentDetails),
      );

      if (response.statusCode == 201) {
        print('Appointment booked successfully');
        Navigator.pushReplacementNamed(context, "/home");
        // Handle success, e.g., show a success message to the user
      } else {
        print('Failed to book appointment: ${response.statusCode}');
        // Handle failure, e.g., show an error message to the user
      }
    } catch (e) {
      print('Error while booking appointment: $e');
      // Handle the error, e.g., show an error message to the user
    }
  }
}
