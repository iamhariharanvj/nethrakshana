import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pdfLib;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:share/share.dart';

class PrescriptionScreen extends StatelessWidget {
  final List<String> prescriptionDetails = [
    'Medication: Use prescribed eye drops (e.g., antibiotic or anti-inflammatory) as directed.',
    'Eye Care: Avoid rubbing your eyes. Wash your hands before applying any eye medication.',
    'Follow-up: Schedule a follow-up appointment in one week for a progress check.',
  ];

  final String diagnosisAdvice =
      'Patient has been diagnosed with conjunctivitis (pink eye). Proper care and medication adherence are crucial for a swift recovery.';

  final String procedures =
      '1. Apply prescribed eye drops according to the provided schedule.\n2. Avoid exposure to dust and allergens.\n3. If symptoms persist or worsen, contact the hospital immediately.';

  PrescriptionScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Prescription Details:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            for (String detail in prescriptionDetails) Text('- $detail'),
            SizedBox(height: 20),
            Text(
              'Diagnosis Advice:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(diagnosisAdvice),
            SizedBox(height: 20),
            Text(
              'Procedures:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(procedures),
            SizedBox(height: 20),

            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _sharePDF(context),
              child: Text('Share PDF'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _generatePDF(BuildContext context) async {
    final pdf = pdfLib.Document();

    pdf.addPage(
      pdfLib.Page(
        build: (context) {
          return pdfLib.Column(
            crossAxisAlignment: pdfLib.CrossAxisAlignment.start,
            children: [
              pdfLib.Text(
                'Prescription Details:',
                style: pdfLib.TextStyle(fontWeight: pdfLib.FontWeight.bold, fontSize: 20),
              ),
              for (String detail in prescriptionDetails) pdfLib.Text('- $detail'),
              pdfLib.SizedBox(height: 20),
              pdfLib.Text(
                'Diagnosis Advice:',
                style: pdfLib.TextStyle(fontWeight: pdfLib.FontWeight.bold, fontSize: 20),
              ),
              pdfLib.Text(diagnosisAdvice),
              pdfLib.SizedBox(height: 20),
              pdfLib.Text(
                'Procedures:',
                style: pdfLib.TextStyle(fontWeight: pdfLib.FontWeight.bold, fontSize: 20),
              ),
              pdfLib.Text(procedures),
            ],
          );
        },
      ),
    );

    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String path = '$dir/prescription.pdf';
    final File file = File(path);
    await file.writeAsBytes(await pdf.save());

    _openPDFPreview(context, path);
  }

  void _openPDFPreview(BuildContext context, String filePath) {
    // Implement code to open the PDF preview screen
    // (You may use a package like 'advance_pdf_viewer' for this)
  }

  Future<void> _sharePDF(BuildContext context) async {
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String path = '$dir/prescription.pdf';
    _generatePDF(context);
    if (await File(path).exists()) {
      Share.shareFiles([path], text: 'Prescription PDF');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please generate the PDF first.'),
        ),
      );
    }
  }
}
