import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:research_project/components/buyer_seller/dashboard_menu.dart';
import 'package:research_project/screens/buyer_seller/dashboard_screen.dart';

import 'disease_ditection/detection_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget buildButton({
    required String title,
    required IconData icon,
    required VoidCallback onClicked,
  }) =>
      ElevatedButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon, size: 25),
            const SizedBox(width: 16),
            Text(title),
          ],
        ),
        onPressed: onClicked,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(45),
          primary: const Color.fromARGB(255, 223, 182, 49),
          onPrimary: Colors.black54,
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        toolbarHeight: 100,
        backgroundColor: Color.fromARGB(255, 223, 182, 49),
        title: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Color.fromARGB(255, 223, 182, 49),
              radius: 25,
              backgroundImage: AssetImage("assets/images/house.png"),
            ),
            const SizedBox(
              width: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Dashboard',
                  style: TextStyle(
                    fontFamily: 'Cabin',
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
      drawer: Drawer(
        elevation: 10.0,
        child: Container(
          //Side Pannel
          color: Color.fromARGB(255, 223, 182, 49),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const SizedBox(height: 20),
              Container(
                child: const DrawerHeader(
                  decoration: BoxDecoration(
                      // image: DecorationImage(
                      //   image: AssetImage("assets/"),
                      //   scale: 0.8,
                      // ),
                      ),
                  child: SizedBox(),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    ListTile(
                      title: Row(children: const [
                        Icon(
                          Icons.home_filled,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 25.0,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                              fontFamily: 'Cabin',
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0,
                              color: Colors.white),
                        )
                      ]),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Row(
                        children: const [
                          Icon(
                            Icons.android,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 25.0,
                          ),
                          Text(
                            'Conversational AI',
                            style: TextStyle(
                                fontFamily: 'Cabin',
                                fontWeight: FontWeight.bold,
                                fontSize: 13.0,
                                color: Colors.white),
                          )
                        ],
                      ),
                      // onTap: () {
                      //   Navigator.of(context).push(
                      //     MaterialPageRoute(
                      //       builder: (context) => ChatScreen(),
                      //     ),
                      //   );
                      // },
                    ),
                    ListTile(
                      title: Row(
                        children: const [
                          Icon(
                            Icons.bug_report,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 25.0,
                          ),
                          Text(
                            'Disease Ditection',
                            style: TextStyle(
                                fontFamily: 'Cabin',
                                fontWeight: FontWeight.bold,
                                fontSize: 13.0,
                                color: Colors.white),
                          )
                        ],
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DetectionScreen(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      title: Row(
                        children: const [
                          Icon(
                            Icons.handshake,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 25.0,
                          ),
                          Text(
                            'Buyer Seller Interaction',
                            style: TextStyle(
                                fontFamily: 'Cabin',
                                fontWeight: FontWeight.bold,
                                fontSize: 13.0,
                                color: Colors.white),
                          )
                        ],
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DashboardScreen(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      title: Row(
                        children: const [
                          Icon(
                            Icons.shopify,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 25.0,
                          ),
                          Text(
                            'Profit Optimization Plan',
                            style: TextStyle(
                                fontFamily: 'Cabin',
                                fontWeight: FontWeight.bold,
                                fontSize: 13.0,
                                color: Colors.white),
                          )
                        ],
                      ),
                      // onTap: () {
                      //   Navigator.of(context).push(
                      //     MaterialPageRoute(
                      //       builder: (context) => AddUserInputsPlan(),
                      //     ),
                      //   );
                      // },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              height: 100,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        width: 230,
                        height: 230,
                        child: Image.asset(
                          'assets/images/logo.png',
                          fit: BoxFit.cover,
                          color: Colors.white.withOpacity(0.8),
                          colorBlendMode: BlendMode.modulate,
                        ),
                      ),
                      const SizedBox(height: 2),
                      // const Text(
                      //   "Mobile app description goes here",
                      //   textAlign: TextAlign.justify,
                      //   style: TextStyle(
                      //     fontWeight: FontWeight.w500,
                      //     fontSize: 18,
                      //   ),
                      // ),
                      // const SizedBox(height: 10),
                      // const Text(
                      //   "You can use the following features to assist your banana farming.",
                      //   textAlign: TextAlign.justify,
                      //   style: TextStyle(
                      //     fontWeight: FontWeight.w500,
                      //     fontSize: 18,
                      //   ),
                      // ),
                      const SizedBox(height: 15),
                      Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Navigator.of(context).push(
                                //   MaterialPageRoute(
                                //     builder: (context) => ChatScreen(),
                                //   ),
                                // );
                              },
                              child: Card(
                                color: Color.fromARGB(255, 223, 182, 49),
                                child: Container(
                                  width: 120,
                                  height: 120,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.android, size: 50),
                                      SizedBox(height: 10),
                                      Text(
                                        'Expert Conversational AI',
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
                                    builder: (context) => DetectionScreen(),
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
                                      Icon(Icons.bug_report, size: 50),
                                      SizedBox(height: 10),
                                      Text(
                                        'Disease Detection',
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DashboardScreen()),
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
                                      Icon(Icons.handshake, size: 50),
                                      SizedBox(height: 10),
                                      Text(
                                        'Buyer Seller Interaction',
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Navigator.of(context).push(
                                //   MaterialPageRoute(
                                //     builder: (context) => AddUserInputsPlan(),
                                //   ),
                                // );
                              },
                              child: Card(
                                color: Color.fromARGB(255, 223, 182, 49), // Add your desired color here
                                child: Container(
                                  width: 120,
                                  height: 120,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.shopify, size: 50),
                                      SizedBox(height: 10),
                                      Text(
                                        'Profit Optimization Plan',
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
