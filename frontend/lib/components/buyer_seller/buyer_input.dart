import 'package:flutter/material.dart';
import 'package:research_project/screens/buyer_seller/optimizing_best_buyer_screen.dart';
import 'package:research_project/screens/buyer_seller/optimizing_best_farmer_screen.dart';

class BuyerInput extends StatefulWidget {
  @override
  _BuyerInputState createState() => _BuyerInputState();
}

class _BuyerInputState extends State<BuyerInput> {
  String _selectedProductType = 'Banana';
  String _quantity = '';
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

  void _submitForm() {
    // Handle form submission
    // You can access the form values here (_selectedProductType, _quantity, _minPrice, _maxPrice, _location, _radius)
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
                'Quantity (Kg)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    _quantity = value;
                  });
                },decoration: InputDecoration(
                  hintText: 'Enter the quantity you need',
                ),
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OptimizingBuyerScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 204, 160, 0), // Set the background color here
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
