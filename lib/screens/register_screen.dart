import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:upi_india/upi_app.dart';
import 'package:upi_india/upi_india.dart';

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

  UpiIndia _upiIndia = UpiIndia();


  Future<UpiResponse> initiateTransaction() async {
    UpiApp app = UpiApp.paytm;
    return _upiIndia.startTransaction(
      app: app,
      receiverUpiId: "johnthomasajs@okaxis",
      receiverName: 'John Thomas A',
      transactionRefId: 'UPITXREF0001',
      transactionNote: 'Aravind Eye Care Patient Registration Fee.',
      amount: 10.0,
    );
  }



  String _selectedGender = 'Male'; // Initial value for gender
  double registrationFee = 10; // Set your registration fee

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    var res = await initiateTransaction();
    print("Response Status: ");
    print(res.status);
    if(res.status !="failure") {
      print("Working");
      final response = await http.post(
        Uri.parse('https://nethrakshana.onrender.com/register'),
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
      print(response.statusCode);
      if (response.statusCode == 201) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final data = json.decode(response.body);

        await prefs.setString('UIN', data.UIN);
        print("Going to move");
        Navigator.pushReplacementNamed(context, "/home");
      } else {
        // Handle registration failure
        print(response.body);
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
                Text("Age"),
                Slider(
                  value: int.tryParse(_ageController.text)?.toDouble() ?? 0,

                  onChanged: (value) {
                    setState(() {
                      _ageController.text = value.toInt().toString();
                    });
                  },
                  min: 0,
                  max: 100,
                  divisions: 100,
                  label: _ageController.text,
                ),
                SizedBox(height: 10),
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
                  child: Text('Register (Pay Rs.${registrationFee.toString()})'),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
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