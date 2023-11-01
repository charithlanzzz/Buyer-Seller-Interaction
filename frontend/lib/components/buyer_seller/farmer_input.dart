import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart' as location;
import 'package:research_project/components/buyer_seller/farmer_output.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class FarmerInput extends StatefulWidget {
  @override
  _FarmerInputState createState() => _FarmerInputState();
}

class _FarmerInputState extends State<FarmerInput> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final location.Location _location = location.Location();

  String _selectedProductType = 'Banana';
  String _selectedBananaType = 'Seeni'; // Selected banana type
  String? _maxQuantity;
  String? _minPrice;
  String? _locationName;
  String? _radius;
  LatLng? _selectedLocation;

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

      final url = Uri.parse('https://buyer-seller-interaction-b305e21cabf9.herokuapp.com/process_input');
      // final url = Uri.parse('http://127.0.0.1:5000/process_input_new');
      // final url = Uri.parse('http://139.99.26.3:8000/process_input');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "user_type": "seller",
          "product_type":
              _selectedProductType, // Include the selected product type
          "banana_type": _selectedBananaType,
          "max_quantity": _maxQuantity,
          "min_price": _minPrice,
          "radius": _radius,
          "location_name": _locationName,
          // Include the selected location as latitude and longitude
          "latitude": _selectedLocation?.latitude,
          "longitude": _selectedLocation?.longitude,
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
      } else if (response.statusCode == 404 || response.statusCode == 400 || response.statusCode == 500) {
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

    // Access the input values after form submission
    print("Selected Product Type: $_selectedProductType");
    print("Selected Banana Type: $_selectedBananaType");
    print("Max Quantity: $_maxQuantity");
    print("Min Price: $_minPrice");
    print("Location: $_locationName");
    print("Radius: $_radius");
    print("Selected Location: $_selectedLocation");
  }

  Future<void> _getLocation() async {
    try {
      final currentLocation = await _location.getLocation();
      _selectedLocation =
          LatLng(currentLocation.latitude!, currentLocation.longitude!);

      final placemarks = await placemarkFromCoordinates(
        currentLocation.latitude!,
        currentLocation.longitude!,
      );

      if (placemarks.isNotEmpty) {
        final placemark = placemarks[0];
        final fullAddress =
            '${placemark.thoroughfare}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}';

        setState(() {
          _locationName = fullAddress;
        });
      } else {
        setState(() {
          _locationName = "Location Not Found";
        });
      }
    } catch (e) {
      print("Error getting location: $e");
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
                      'Select Product Type',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        DropdownButton<String>(
                          value: _selectedProductType,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedProductType = newValue!;
                              // Reset the selected banana type when changing the product type
                              if (_selectedProductType != 'Banana') {
                                _selectedBananaType =
                                    ''; // Clear the banana type
                              } else if (!_bananaTypes
                                  .contains(_selectedBananaType)) {
                                // Check if the selected banana type is not valid for Banana
                                _selectedBananaType =
                                    _bananaTypes[0]; // Set to the first option
                              }
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
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
                              labelText: _selectedProductType == 'Banana'
                                  ? 'Enter the available maximum quantity(>100kg)'
                                  : _selectedProductType == 'Leaves'
                                      ? 'Enter the available maximum quantity(>100kg)'
                                      : _selectedProductType == 'Banana Blossom'
                                          ? 'Enter the available maximum quantity(>100kg)'
                                          : _selectedProductType ==
                                                  'Banana Stem'
                                              ? 'Enter the available maximum quantity(>200kg)'
                                              : _selectedProductType ==
                                                      'Banana Peel'
                                                  ? 'Enter the available maximum quantity(>100kg)'
                                                  : 'Enter the max quantity you have',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Price (Per kg)',
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
                              labelText: _selectedProductType == 'Banana'
                                  ? 'Enter The minimum price you can sell per kg (<Rs.200)'
                                  : _selectedProductType == 'Leaves'
                                      ? 'Enter The minimum price you can sell per kg (<Rs.900)'
                                      : _selectedProductType == 'Banana Blossom'
                                          ? 'Enter The minimum price you can sell per kg (<Rs.180)'
                                          : _selectedProductType ==
                                                  'Banana Stem'
                                              ? 'Enter The minimum price you can sell per kg (<Rs.1200)'
                                              : _selectedProductType ==
                                                      'Banana Peel'
                                                  ? 'Enter The minimum price you can sell per kg (<Rs.1100)'
                                                  : 'Enter the min price',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    SizedBox(height: 16),
                    Text(
                      'Current Location',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: _getLocation,
                        style: ElevatedButton.styleFrom(
                          primary: Colors
                                      .green,
                        ),
                        icon: Icon(Icons.location_on), // Add the map icon here
                        label: Text('Get Current Location'),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      _locationName ?? '',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Distance (km)',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                        hintText: 'Enter the distance',
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
