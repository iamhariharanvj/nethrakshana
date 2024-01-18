import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class AppointmentsScreen extends StatefulWidget {
  @override
  _AppointmentsScreenState createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  List<dynamic> appointments = []; // List to store appointments

  @override
  void initState() {
    super.initState();
    // Fetch user appointments when the screen is initialized
    _fetchAppointments();
  }

  Future<void> _fetchAppointments() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userUIN = prefs.getString('UIN') ?? '';

    final String serverUrl = 'http://10.0.2.2:5000/user-appointments/'+userUIN; // Replace with the actual user UIN

    try {
      final response = await http.get(Uri.parse(serverUrl));

      if (response.statusCode == 200) {
        setState(() {
          appointments = json.decode(response.body);
        });
      } else {
        print('Failed to fetch appointments: ${response.statusCode}');
        // Handle failure, e.g., show an error message to the user
      }
    } catch (e) {
      print('Error while fetching appointments: $e');
      // Handle the error, e.g., show an error message to the user
    }
  }

  void _showDetailsDialog(String hospital, String date, String location) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Appointment Details'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Hospital: $hospital'),
              Text('Date: $date'),
              Text('Location: $location'),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () => _openGoogleMaps(location),
              child: Text('Open Google Maps'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _openGoogleMaps(String location) async {
    final String mapsUrl = 'https://www.google.com/maps/search/?api=1&query=$location';

    if (await canLaunch(mapsUrl)) {
      await launch(mapsUrl);
    } else {
      print('Could not launch Google Maps');
      // Handle the case where Google Maps could not be launched
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointments'),
      ),
      body: appointments.isEmpty
          ? Center(child: Text('No appointments'))
          : ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          final appointment = appointments[index];
          final hospital = appointment['location'];
          final date = appointment['date'];
          final location = appointment['location'];

          return ListTile(
            title: Text('Hospital: $hospital'),
            subtitle: Text('Date: $date'),
            onTap: () {
              _showDetailsDialog(hospital, date, location);
            },
          );
        },
      ),
    );
  }
}
