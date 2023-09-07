import 'package:flutter/material.dart';

import 'farmer_output_details.dart';

class FarmerOutput extends StatelessWidget {
  final Map<String, dynamic> responseData;

  FarmerOutput(this.responseData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 223, 182, 49),
        title: Text('Best Wholesale Buyers'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'The Best Wholesale Buyers According Your Requirements:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            if (responseData['matching_stakeholders'] != null &&
                responseData['matching_stakeholders'].isNotEmpty)
              Column(
                children: responseData['matching_stakeholders']
                    .map<Widget>((stakeholder) => Card(
                      child: ListTile(
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
                                Color.fromARGB(255, 73, 104, 225), // Customize the text color
                              ),
                            ),
                          ],
                        ),
                        trailing: ElevatedButton(
                        onPressed: () {
                          // Navigate to the details page and pass the stakeholder's data
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => FarmerOutputDetails(stakeholder),
                            ),
                          );
                        },
                        child: Text('View'),
                      ),
                      ),
                    ))
                    .toList(),
              ),
            if (responseData['matching_stakeholders'] == null ||
                responseData['matching_stakeholders'].isEmpty)
              Text(
                'No matching stakeholders found based on the given requirements',
                style: TextStyle(fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}
