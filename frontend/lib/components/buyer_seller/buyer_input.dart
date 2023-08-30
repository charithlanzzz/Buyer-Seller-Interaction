import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import the http package
import 'package:research_project/components/buyer_seller/buyer_output.dart';
import 'dart:convert'; // Import the dart:convert library
import 'package:research_project/screens/buyer_seller/optimizing_best_buyer_screen.dart';
import 'package:research_project/screens/buyer_seller/optimizing_best_farmer_screen.dart';


class BuyerInput extends StatefulWidget {
  @override
  _BuyerInputState createState() => _BuyerInputState();
}

class _BuyerInputState extends State<BuyerInput> {
  String _selectedProductType = 'Banana';
  String _minQuantity = '';
  String _maxQuantity = '';
  String _minPrice = '';
  String _maxPrice = '';
  String _location = '';
  String _radius = '';

  List<String> _productTypes = [
    'Banana',
    'Banana Leaves',
    'Banana Blossom',
    'Banana Stem',
    'Banana Peel',
  ];

 void _submitForm() async {
  final url = Uri.parse('http://127.0.0.1:5000/process_input');

  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      "user_type": "buyer",
      "product_type": _selectedProductType,
      "min_quantity": _minQuantity.toString(),  // Convert to string
      "max_quantity": _maxQuantity.toString(),  // Convert to string
      "min_price": _minPrice,
      "max_price": _maxPrice,
      "radius": _radius,
      "location_name": _location,
    }),
  );

  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BuyerOutput(responseData)),
    );
  } else {
    print('Request failed with status: ${response.statusCode}');
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Banana Wholesale Buyer',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Enter your requirements to discover the best Farmers',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'Product Type',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              DropdownButton<String>(
                value: _selectedProductType,
                onChanged: (newValue) {
                  setState(() {
                    _selectedProductType = newValue!;
                  });
                },
                items: _productTypes.map((productType) {
                  return DropdownMenuItem<String>(
                    value: productType,
                    child: Text(productType),
                  );
                }).toList(),
              ),
              SizedBox(height: 8),
              Text(
                'Quantity',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          _minQuantity = value;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Min Quantity',
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          _maxQuantity = value;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Max Quantity',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'Price Range',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          _minPrice = value;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Min Price',
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          _maxPrice = value;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Max Price',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Location (District)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    _location = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Enter your district',
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Radius',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    _radius = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Enter the radius',
                ),
              ),
              SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed:
                      _submitForm, // Call _submitForm when button is pressed
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(
                        255, 204, 160, 0), // Set the background color here
                  ),
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
