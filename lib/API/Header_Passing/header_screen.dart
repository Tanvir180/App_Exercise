import 'package:flutter/material.dart';
import 'package:state_management/API/Header_Passing/api_services_header.dart';
import 'package:state_management/API/Header_Passing/headermodel.dart';
import 'package:state_management/API/Header_Passing/infoscreen.dart';

class JobHomeScreen extends StatefulWidget {
  const JobHomeScreen({super.key});

  @override
  State<JobHomeScreen> createState() => _JobHomeScreenState();
}

class _JobHomeScreenState extends State<JobHomeScreen> {
  //controller
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  HeaderModel headerModel = HeaderModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Job Post ${headerModel.accessToken}"),
        // actions: Icon(Icons.import_contacts).
      ),
      body: Center(
        child: Container(
          // height: 500,
          // width: 700,
          color: Colors.blueGrey,
          padding: EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.white,
                child: TextField(
                  controller: email,
                  decoration: const InputDecoration(hintText: "Email"),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.white,
                child: TextField(
                  controller: password,
                  decoration: const InputDecoration(hintText: "Password"),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red, // text color
                    ),
                    onPressed: () {
                      HeaderApiServices()
                          .headerPassingApi(
                              email.text.toString(), password.text.toString())
                          .then((value) {
                        setState(() {
                          headerModel = value!;

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SeeJob(
                                        accessToken:
                                            headerModel.accessToken.toString(),
                                        refreshToken:
                                            headerModel.refreshToken.toString(),
                                      ) // Passing token Value
                                  ));
                        });
                      });
                    },
                    child: const Text("Login")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
