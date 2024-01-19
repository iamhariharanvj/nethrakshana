import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpiPaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UPI Payment'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Choose UPI Payment Option:'),
            // Add your UPI payment options here
          ],
        ),
      ),
    );
  }
}

