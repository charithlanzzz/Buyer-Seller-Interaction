import 'package:flutter/material.dart';

class BestBuyer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: [
        Center(
          child: Text(
            'The best wholesale buyers are below according to your requirements',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 16),
        FarmerCard(name: 'John Doe'),
        FarmerCard(name: 'Jane Smith'),
        FarmerCard(name: 'Michael Johnson'),
        FarmerCard(name: 'Emily Davis'),
      ],
    );
  }
}

class FarmerCard extends StatelessWidget {
  final String name;

  const FarmerCard({required this.name});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.person),
        title: Text(name),
        trailing: ElevatedButton(
          onPressed: () {
// Handle view button press
          },
          child: Text('View'),
        ),
      ),
    );
  }
}
