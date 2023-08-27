import 'package:flutter/material.dart';
import 'package:research_project/screens/buyer_seller/best_buyer.dart';
import 'package:research_project/screens/buyer_seller/best_farmer.dart';

class OptimizingFarmer extends StatefulWidget {
  @override
  _OptimizingFarmerState createState() => _OptimizingFarmerState();
}

class _OptimizingFarmerState extends State<OptimizingFarmer> {
  @override
  void initState() {
    super.initState();
    navigateToFarmerScreen();
  }

  void navigateToFarmerScreen() {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BestFarmerScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: Container(
              color: Colors.white,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
        ],
      ),
    );
  }
}

