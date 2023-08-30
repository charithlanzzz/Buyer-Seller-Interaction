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
                          title: Text(stakeholder['name']
                              .toString()), // Convert to string
                          subtitle: Text(stakeholder['contact_number']
                              .toString()), // Convert to string
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
