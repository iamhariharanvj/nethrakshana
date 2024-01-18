import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _patientNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String _selectedGender = 'Male'; // Initial value for gender

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final response = await http.post(
      Uri.parse('http://10.0.2.2:5000/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'password': _passwordController.text,
        'mobile': _mobileController.text,
        'patientName': _patientNameController.text,
        'age': int.tryParse(_ageController.text) ?? 0,
        'gender': _genderController.text,
        'address': _addressController.text,
        'city': _cityController.text,
      }),
    );



    if (response.statusCode == 201) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final data = json.decode(response.body);
      prefs.setString('UIN', data.uin);
      await Navigator.pushReplacementNamed(
        context,
        "/home",
      );
      print('User registered successfully');
    } else {
      // Handle registration failure
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Registration Failed'),
            content: Text('Failed to register user'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Password'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _mobileController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(labelText: 'Mobile'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a mobile number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _patientNameController,
                  decoration: InputDecoration(labelText: 'Patient Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter patient name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                // Age Slider
                Text("Age"),
                Slider(
                  value: int.tryParse(_ageController.text)?.toDouble() ?? 0,
                  onChanged: (value) {
                    setState(() {
                      _ageController.text = value.toString();
                    });
                  },
                  min: 0,
                  max: 100,
                  divisions: 100,
                  label: _ageController.text,
                ),
                SizedBox(height: 10),
                // Gender Radio Buttons
                Row(
                  children: [
                    Radio(
                      value: 'Male',
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value.toString();
                        });
                      },
                    ),
                    Text('Male'),
                    Radio(
                      value: 'Female',
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value.toString();
                        });
                      },
                    ),
                    Text('Female'),
                  ],
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(labelText: 'Address'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _cityController,
                  decoration: InputDecoration(labelText: 'City'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a city';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _register,
                  child: Text('Register'),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    // Navigate to login screen
                    Navigator.pushReplacementNamed(context, "/login");
                  },
                  child: Text('Already registered? Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}