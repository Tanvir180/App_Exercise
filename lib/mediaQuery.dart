import 'package:flutter/material.dart';

class Mediaquery extends StatelessWidget {
  const Mediaquery({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: Text("MediaQuery Example")),
      body: Center(
        child: Container(
          width: screenWidth * 0.6, // 80% of the screen width
          height: 100,
          color: Colors.blue,
          child: Center(child: Text('$screenWidth')),
        ),
      ),
    );
  }
}
