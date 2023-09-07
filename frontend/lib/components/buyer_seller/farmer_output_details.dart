import 'package:flutter/material.dart';

class FarmerOutputDetails extends StatelessWidget {
  final Map<String, dynamic> stakeholder;

  FarmerOutputDetails(this.stakeholder);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stakeholder Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Stakeholder Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Name: ${stakeholder['name']}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Contact Number: ${stakeholder['contact_number']}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Location: ${stakeholder['location_name']}',
              style: TextStyle(fontSize: 16),
            ),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
