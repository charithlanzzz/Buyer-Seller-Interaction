import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';

import '../../screens/disease_ditection/results_screen.dart';

class DetectionMenu extends StatefulWidget {
  const DetectionMenu({Key? key}) : super(key: key);

  @override
  State<DetectionMenu> createState() => _DetectionMenuState();
}

class _DetectionMenuState extends State<DetectionMenu> {
  File? image;
  late File uploaded;
  bool _isProcessing = false;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);

      setState(() {
        this.image = imageTemporary;
        this.uploaded = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          image != null
              ? Image.file(
                  image!,
                  width: 180,
                  height: 180,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  'assets/happy_banana.png',
                  height: 200,
                  width: 150,
                  fit: BoxFit.cover,
                ),
          const SizedBox(height: 30),
          (image == null)
              ? const Text(
                  'Use the below options to upload an image',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : Container(),
          const SizedBox(height: 20),
          buildButton(
            title: 'Capture with Camera',
            icon: Icons.camera_alt_outlined,
            onClicked: () => pickImage(ImageSource.camera),
          ),
          const SizedBox(height: 20),
          buildButton(
            title: 'Pick from Gallery',
            icon: Icons.image_outlined,
            onClicked: () => pickImage(ImageSource.gallery),
          ),
        ],
      ),
    );
  }

  Widget buildButton({
    required String title,
    required IconData icon,
    required VoidCallback onClicked,
  }) {
    return ElevatedButton(
      onPressed: onClicked,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(56),
        primary: const Color(0xff809b7b),
        onPrimary: Colors.black54,
        textStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 28),
          const SizedBox(width: 16),
          Text(title),
        ],
      ),
    );
  }
}
