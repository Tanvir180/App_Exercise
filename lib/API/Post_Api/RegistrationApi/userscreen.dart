import 'package:flutter/material.dart';

class Userscreen extends StatefulWidget {
  final String token, id;
  const Userscreen({super.key, required this.token, required this.id});

  @override
  State<Userscreen> createState() => _UserscreenState();
}

class _UserscreenState extends State<Userscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("See Job"),
      ),
      body: Container(
        color: Colors.deepOrange,
        height: 400,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            // padding: EdgeInsets.all(40),
            children: [
              Container(
                  // margin: EdgeInsets.all(40),
                  padding: EdgeInsets.fromLTRB(25, 5, 0, 0),
                  height: 30,
                  width: 90,
                  color: Colors.white,
                  child: Text("ID : ${widget.id}")),
              Text("Token: ${widget.token}"),
            ],
          ),
        ),
      ),
    );
  }
}
