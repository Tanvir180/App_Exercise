import 'package:flutter/material.dart';
import 'package:state_management/API/Header_Passing/headermodel.dart';
import 'package:state_management/API/Header_Passing/userinScreen.dart';

class SeeJob extends StatefulWidget {
  final String refreshToken, accessToken;

  const SeeJob({required this.refreshToken, required this.accessToken});

  @override
  State<SeeJob> createState() => _SeeJobState();
}

class _SeeJobState extends State<SeeJob> {
  HeaderModel headerModel = HeaderModel();

  @override
  Widget build(BuildContext context) {

    // headerModel.accessToken= widget.accessToken;
    // headerModel.refreshToken= widget.refreshToken;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("See Job"),
      ),
      body: Container(
        color: Colors.grey,
        height: 600,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            // padding: EdgeInsets.all(40),
            children: [
              Container(
                  margin: EdgeInsets.all(40),
                  padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                  color: Colors.white,
                  child: Text("access_token : ${widget.accessToken}")),
              Container(
                  margin: EdgeInsets.all(40),
                  padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                  color: Colors.white,
                  child: Text("refresh_token: ${widget.refreshToken}")),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red, // text color
                    ),
                    onPressed: () {
                      // HeaderApiServices().headerPassingApi(email.text.toString(), password.text.toString()).then((value){
                      //   setState(() {
                      //     headerModel = value!;

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Userinscreen(
                                    accessToken:
                                    widget.accessToken.toString(),
                                  ) // Passing token Value
                              ));
                    },
                    child: const Text("User Info")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
