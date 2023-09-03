import 'package:flutter/material.dart';

class BuyerOutput extends StatelessWidget {
  final Map<String, dynamic> responseData;

  BuyerOutput(this.responseData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 223, 182, 49),
        title: Text('Best Farmers'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'The Best Farmers According Your Requirements:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            if (responseData['matching_stakeholders'] != null)
              Column(
                children: responseData['matching_stakeholders']
                    .map<Widget>((stakeholder) => ListTile(
                          title: Text(
                            stakeholder['name'].toString(),
                            style: TextStyle(
                              fontSize: 16, // Customize the font size
                              fontWeight:
                                  FontWeight.bold, // Apply bold font weight
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                stakeholder['contact_number'].toString(),
                                style: TextStyle(
                                  fontSize: 14, // Customize the font size
                                  color:
                                      Colors.grey, // Customize the text color
                                ),
                              ),
                              Text(
                                stakeholder['location_name'].toString(),
                                style: TextStyle(
                                  fontSize: 14, // Customize the font size
                                  color:
                                      Colors.blue, // Customize the text color
                                ),
                              ),
                            ],
                          ),
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
