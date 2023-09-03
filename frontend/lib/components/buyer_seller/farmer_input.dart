import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:research_project/components/buyer_seller/farmer_output.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class FarmerInput extends StatefulWidget {
  @override
  _FarmerInputState createState() => _FarmerInputState();
}

class _FarmerInputState extends State<FarmerInput> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _selectedProductType = 'Banana';
  String? _minQuantity;
  String? _maxQuantity;
  String? _minPrice;
  String? _maxPrice;
  String? _location;
  String? _radius;

  List<String> _productTypes = [
    'Banana',
    'Banana Leaves',
    'Banana Blossom',
    'Banana Stem',
    'Banana Peel',
  ];

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              padding: EdgeInsets.all(16),
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    strokeWidth: 10.0,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Requirements are Optimizing',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
      await Future.delayed(Duration(seconds: 2)); // Delay for 2 seconds

      final url = Uri.parse('https://buyer-seller-interaction-b305e21cabf9.herokuapp.com/process_input');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "user_type": "seller",
          "product_type": _selectedProductType,
          "min_quantity": _minQuantity,
          "max_quantity": _maxQuantity,
          "min_price": _minPrice,
          "max_price": _maxPrice,
          "radius": _radius,
          "location_name": _location,
        }),
      );

      Navigator.pop(
          context); // Close the loading dialog // Close the loading dialog

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['matching_stakeholders'] == null ||
            responseData['matching_stakeholders'].isEmpty) {
          Fluttertoast.showToast(
            msg: "No results found",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FarmerOutput(responseData)),
          );
        }
      } else if (response.statusCode == 404 || response.statusCode == 400) {
        Fluttertoast.showToast(
          msg: "No matching stakeholders found based on the given requirements",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
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
                  'Banana Farmer',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Enter your requirements to discover the best wholesale buyers',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Product Type',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the min quantity';
                              }
                              return null;
                            },
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
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the max quantity';
                              }
                              return null;
                            },
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
                      'Price Range (Per kg)',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the min price';
                              }
                              return null;
                            },
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
                        SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the max price';
                              }
                              return null;
                            },
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
                    SizedBox(height: 8),
                    Text(
                      'Location (District)',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the district';
                        }
                        return null;
                      },
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
                      'Radius (km)',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the radius';
                        }
                        return null;
                      },
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
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 204, 160, 0),
                        ),
                        child: Text('Submit'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
