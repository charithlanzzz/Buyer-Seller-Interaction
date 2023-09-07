import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:research_project/components/buyer_seller/best_farmer.dart';


class BestFarmerScreen extends StatefulWidget {
  const BestFarmerScreen({Key? key}) : super(key: key);

  @override
  State<BestFarmerScreen> createState() => _BestFarmerScreenState();
}

class _BestFarmerScreenState extends State<BestFarmerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        toolbarHeight: 150,
        backgroundColor: Color.fromARGB(255, 189, 167, 97),
        title: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Color.fromARGB(255, 189, 167, 97),
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
                  'BANANA XPERT',
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
      backgroundColor: const Color.fromARGB(255, 189, 167, 97),
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
                child: BestFarmer(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
