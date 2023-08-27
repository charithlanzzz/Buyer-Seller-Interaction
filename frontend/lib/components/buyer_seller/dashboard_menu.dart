import 'package:flutter/material.dart';
import 'package:research_project/components/buyer_seller/buyer_input.dart';
import 'package:research_project/screens/buyer_seller/buyer_input_screen.dart';
import 'package:research_project/screens/buyer_seller/farmer_input_screen.dart';

class DashboardMenu extends StatelessWidget {
  const DashboardMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          children: [
            const SizedBox(height: 15),
            ClipRRect(
              borderRadius: BorderRadius.circular(
                  10.0), // Set the border radius value here
              child: Container(
                width: 250,
                height: 180,
                child: Image.asset(
                  'assets/images/market.jpg',
                  fit: BoxFit.cover,
                  color: Colors.white.withOpacity(0.8),
                  colorBlendMode: BlendMode.modulate,
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Who Are You ?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => FarmerInputScreen(),
                      ),
                    );
                  },
                  child: Card(
                    color: Color.fromARGB(255, 223, 182, 49),
                    child: Container(
                      width: 120,
                      height: 120,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.person, size: 50),
                          SizedBox(height: 10),
                          Text(
                            'Banana Farmer',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => BuyerInputScreen(),
                      ),
                    );
                  },
                  child: Card(
                    color: Color.fromARGB(255, 223, 182, 49),
                    child: Container(
                      width: 120,
                      height: 120,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.person, size: 50),
                          SizedBox(height: 10),
                          Text(
                            'Banana Wholesale Buyer',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SquareCardButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;

  const SquareCardButton({
    Key? key,
    required this.title,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: Card(
        child: InkWell(
          onTap: onPressed,
          child: Center(
            child: Text(
              title,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
