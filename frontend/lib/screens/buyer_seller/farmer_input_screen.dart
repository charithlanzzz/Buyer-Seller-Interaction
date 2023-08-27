import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:research_project/components/buyer_seller/dashboard_menu.dart';
import 'package:research_project/components/buyer_seller/farmer_input.dart';

import '../../components/disease_detection/disease_detection_menu.dart';

class FarmerInputScreen extends StatefulWidget {
  const FarmerInputScreen({Key? key}) : super(key: key);

  @override
  State<FarmerInputScreen> createState() => _FarmerInputScreenState();
}

class _FarmerInputScreenState extends State<FarmerInputScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        toolbarHeight: 150,
        backgroundColor: Color.fromARGB(255, 223, 182, 49),
        title: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Color.fromARGB(255, 223, 182, 49),
              radius: 25,
              backgroundImage: AssetImage('assets/images/market_icon.png'),
            ),
            const SizedBox(
              width: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Buyer-Seller Interaction',
                  style: TextStyle(
                    fontFamily: 'Cabin',
                    fontSize: 18,
                  ),
                ),
                Text(
                  'B MASTER',
                  style: TextStyle(
                    fontFamily: 'Cabin',
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        elevation: 0,
      ),
      backgroundColor: const Color.fromARGB(255, 223, 182, 49),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 100,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  )),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                child: FarmerInput(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
