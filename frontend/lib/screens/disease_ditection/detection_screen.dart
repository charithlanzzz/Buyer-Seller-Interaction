import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../components/disease_detection/disease_detection_menu.dart';

class DetectionScreen extends StatefulWidget {
  const DetectionScreen({Key? key}) : super(key: key);

  @override
  State<DetectionScreen> createState() => _DetectionScreenState();
}

class _DetectionScreenState extends State<DetectionScreen> {
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
              radius: 30,
              backgroundImage: AssetImage('assets/disease_search.png'),
            ),
            const SizedBox(
              width: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Disease Identification'),
                Text(
                  'BANANA XPERT',
                  style: TextStyle(fontSize: 12),
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
                child: DetectionMenu(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
