import 'package:flutter/material.dart';

class FarmerOutput extends StatelessWidget {
  final Map<String, dynamic> responseData;

  FarmerOutput(this.responseData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Farmer Output'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Matching Stakeholders:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            if (responseData['matching_stakeholders'] != null &&
                responseData['matching_stakeholders'].isNotEmpty)
              Column(
    children: responseData['matching_stakeholders']
        .map<Widget>((stakeholder) => ListTile(
              title: Text(
                stakeholder['name'].toString(),
                style: TextStyle(
                  fontSize: 16, // Customize the font size
                  fontWeight: FontWeight.bold, // Apply bold font weight
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stakeholder['contact_number'].toString(),
                    style: TextStyle(
                      fontSize: 14, // Customize the font size
                      color: Colors.grey, // Customize the text color
                    ),
                  ),
                  Text(
                    stakeholder['location_name'].toString(),
                    style: TextStyle(
                      fontSize: 14, // Customize the font size
                      color: Colors.blue, // Customize the text color
                    ),
                  ),
                ],
              ),
            ))
        .toList(),
  ),
            if (responseData['matching_stakeholders'] == null ||
                responseData['matching_stakeholders'].isEmpty)
              Text(
                'No record found',
                style: TextStyle(fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}
