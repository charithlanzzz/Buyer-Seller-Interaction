import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:research_project/components/buyer_seller/buyer_output.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class BuyerInput extends StatefulWidget {
  @override
  _BuyerInputState createState() => _BuyerInputState();
}

class _BuyerInputState extends State<BuyerInput> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _selectedProductType = 'Banana';
  String _selectedBananaType = 'Seeni'; // Selected banana type
  String? _minQuantity;
  String? _maxQuantity;
  String? _minPrice;
  String? _maxPrice;
  String? _location;
  String? _radius;

  List<String> _productTypes = [
    'Banana',
    'Leaves',
    'Banana Blossom',
    'Banana Stem',
    'Banana Peel',
  ];

  // Add banana types
  List<String> _bananaTypes = [
    'Ambum',
    'Kolikuttu',
    'Seeni',
    'Aanamalu',
    'Rath Kesel',
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
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Color.fromARGB(255, 236, 194, 25)),
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

      final url = Uri.parse('http://127.0.0.1:5000/process_input');
      // final url = Uri.parse(
      //     'https://buyer-seller-interaction-b305e21cabf9.herokuapp.com/process_input');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "user_type": "buyer",
          "product_type": _selectedProductType,
          "banana_type": _selectedBananaType,
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
            MaterialPageRoute(builder: (context) => BuyerOutput(responseData)),
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
          child: Form(
            key: _formKey,
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
                  'Select Product Type',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    DropdownButton<String>(
                      value: _selectedProductType,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedProductType = newValue!;
                          // Reset the selected banana type when changing the product type
                          _selectedBananaType = 'Seeni'; // Reset to 'Seeni'
                        });
                      },
                      items: _productTypes.map((productType) {
                        return DropdownMenuItem<String>(
                          value: productType,
                          child: Text(productType),
                        );
                      }).toList(),
                    ),
                    SizedBox(width: 8),
                    // Show the banana type dropdown only when "Banana" is selected
                    if (_selectedProductType == 'Banana')
                      DropdownButton<String>(
                        value: _selectedBananaType,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedBananaType = newValue!;
                          });
                        },
                        items: _bananaTypes.map((bananaType) {
                          return DropdownMenuItem<String>(
                            value: bananaType,
                            child: Text(bananaType),
                          );
                        }).toList(),
                      ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  'Quantity(kg)',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                    SizedBox(width: 8),
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
                SizedBox(height: 16),
                Text(
                  'Location (District)',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                DropdownButtonFormField<String>(
                  value: _location, // Selected value
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your district';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _location = value;
                    });
                  },
                  items: [
                    DropdownMenuItem<String>(
                      value: 'Ampara',
                      child: Text('Ampara'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Anuradhapura',
                      child: Text('Anuradhapura'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Badulla',
                      child: Text('Badulla'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Batticaloa',
                      child: Text('Batticaloa'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Colombo',
                      child: Text('Colombo'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Galle',
                      child: Text('Galle'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Gampaha',
                      child: Text('Gampaha'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Hambantota',
                      child: Text('Hambantota'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Jaffna',
                      child: Text('Jaffna'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Kalutara',
                      child: Text('Kalutara'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Kandy',
                      child: Text('Kandy'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Kegalle',
                      child: Text('Kegalle'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Kilinochchi',
                      child: Text('Kilinochchi'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Kurunegala',
                      child: Text('Kurunegala'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Mannar',
                      child: Text('Mannar'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Matale',
                      child: Text('Matale'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Matara',
                      child: Text('Matara'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Monaragala',
                      child: Text('Monaragala'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Mullaitivu',
                      child: Text('Mullaitivu'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Nuwara Eliya',
                      child: Text('Nuwara Eliya'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Polonnaruwa',
                      child: Text('Polonnaruwa'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Puttalam',
                      child: Text('Puttalam'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Ratnapura',
                      child: Text('Ratnapura'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Trincomalee',
                      child: Text('Trincomalee'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Vavuniya',
                      child: Text('Vavuniya'),
                    ),
                  ],
                  decoration: InputDecoration(
                    hintText: 'Select your district',
                  ),
                  // Adjust the height as needed
                ),
                SizedBox(height: 8),
                Text(
                  'Distance',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the distance';
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
        ),
      ),
    );
  }
}
