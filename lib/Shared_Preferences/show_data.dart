import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowData extends StatefulWidget {
  const ShowData({super.key});

  @override
  State<ShowData> createState() => _ShowDataState();
}

class _ShowDataState extends State<ShowData> {

  String email = "";
  String password = "";

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
     email = prefs.getString("email").toString();
     password = prefs.getString("password").toString();
    });
  }

  @override

  @override
  void initState() {
    getData();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Home Screen"),
      ),
      body: Center(

        child: Column(
          children: [
            Text(email),
            Text(password),
          ],
        ),

      ),
    );
  }
}
