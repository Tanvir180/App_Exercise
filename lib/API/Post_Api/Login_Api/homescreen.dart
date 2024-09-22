import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final String? token;
  const HomeScreen({Key? key, this.token}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Home Screen"),
      ),
      body: Center(
        child: Text(
          "Token : ${widget.token}",

        ),
      ),
    );
  }
}
