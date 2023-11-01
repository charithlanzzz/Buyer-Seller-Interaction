import 'package:flutter/material.dart';

import 'buyer_output_details.dart';

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
                                      color: Colors
                                          .grey, // Customize the text color
                                    ),
                                  ),
                                  Text(
                                    stakeholder['location_name'].toString(),
                                    style: TextStyle(
                                      fontSize: 14, // Customize the font size
                                      color: Color.fromARGB(255, 73, 104,
                                          225), // Customize the text color
                                    ),
                                  ),
                                ],
                              ),
                              trailing: ElevatedButton.icon(
                                onPressed: () {
                                  // Navigate to the details page and pass the stakeholder's data
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          BuyerOutputDetails(stakeholder),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors
                                      .green, // Change the background color to your preferred color
                                ),
                                icon: Icon(
                                  Icons
                                      .visibility, // Replace with the icon you want
                                  color: Colors
                                      .white, // Change the icon color to your preferred color
                                ),
                                label: Text(
                                  'View',
                                  style: TextStyle(
                                      color: Colors
                                          .white), // Change the text color to your preferred color
                                ),
                              )),
                        ))
                    .toList(),
              ),
            SizedBox(height: 24),
            if (responseData['recommendation_plan'] != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Recommendation Plan:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: responseData['recommendation_plan'].length,
                    itemBuilder: (context, index) {
                      final recommendation =
                          responseData['recommendation_plan'][index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.green, // Icon color
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                recommendation,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 11, 30, 107),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
