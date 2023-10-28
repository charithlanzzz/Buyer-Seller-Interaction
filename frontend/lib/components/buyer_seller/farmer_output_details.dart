import 'package:flutter/material.dart';

class FarmerOutputDetails extends StatelessWidget {
  final Map<String, dynamic> stakeholder;

  FarmerOutputDetails(this.stakeholder);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Farmer Details'),
        backgroundColor: Color.fromARGB(255, 223, 182, 49),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'You can find the details of the buyer and the product',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(226, 0, 1, 79),
                      ),
                    ),
                    SizedBox(height: 16),
                    ListTile(
                      title: Text(
                        "Buyer's Name:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        '${stakeholder['name']}',
                        style: TextStyle(fontSize: 16,
                        color: Color.fromARGB(255, 73, 104, 225),),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Contact Number:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        '${stakeholder['contact_number']}',
                        style: TextStyle(fontSize: 16,
                        color: Color.fromARGB(255, 73, 104, 225)),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Location:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        '${stakeholder['location_name']}',
                        style: TextStyle(fontSize: 16,
                        color: Color.fromARGB(255, 73, 104, 225)),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Quantity(Kg):',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        '${stakeholder['quantity']}',
                        style: TextStyle(fontSize: 16,
                        color: Color.fromARGB(255, 73, 104, 225)),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Price(Per Kg):',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        '${stakeholder['price']}',
                        style: TextStyle(fontSize: 16,
                        color: Color.fromARGB(255, 73, 104, 225)),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Product Type:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        '${stakeholder['product_type']}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 73, 104, 225)
                        ),
                      ),
                    ),
                    Visibility(
                      visible: stakeholder['product_type'] == 'Banana',
                      child: ListTile(
                        title: Text(
                          'Banana Type:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          '${stakeholder['banana_type']}',
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 73, 104, 225)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
