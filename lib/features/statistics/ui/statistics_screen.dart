import 'package:flutter/material.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
      ),
      body: Center(
        child: Text(
          'Statistics Screen',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),


      
    );
  }
}