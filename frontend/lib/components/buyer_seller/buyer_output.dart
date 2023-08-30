import 'package:flutter/material.dart';

class BuyerOutput extends StatelessWidget {
  final Map<String, dynamic> responseData;

  BuyerOutput(this.responseData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buyer Output'),
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
            if (responseData['matching_stakeholders'] != null)
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
            SizedBox(height: 16),
            Text(
              'Recommendation Plan:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            if (responseData['recommendation_plan'] != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: responseData['recommendation_plan']
                    .map<Widget>((recommendation) => Text('- $recommendation'))
                    .toList(),
              ),
          ],
        ),
      ),
    );
  }
}
