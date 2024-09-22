import 'package:flutter/material.dart';

class SeeJob extends StatefulWidget {
  final String id, name, job;

  const SeeJob(
      {super.key, required this.id, required this.name, required this.job});

  @override
  State<SeeJob> createState() => _SeeJobState();
}

class _SeeJobState extends State<SeeJob> {
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
                  margin: EdgeInsets.all(40),
                  padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                  height: 30,
                  width: 90,
                  color: Colors.white,
                  child: Text("ID : ${widget.id}")),
              Text("Name: ${widget.name}"),
              Text("Job: ${widget.job}"),
            ],
          ),
        ),
      ),
    );
  }
}
