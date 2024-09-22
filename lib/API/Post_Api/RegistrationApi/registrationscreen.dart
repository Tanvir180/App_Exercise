import 'package:flutter/material.dart';
import 'package:state_management/API/Post_Api/RegistrationApi/api_services_reg.dart';
import 'package:state_management/API/Post_Api/RegistrationApi/regmodel.dart';
import 'package:state_management/API/Post_Api/RegistrationApi/userscreen.dart';

class Registrationscreen extends StatefulWidget {
  const Registrationscreen({super.key});

  @override
  State<Registrationscreen> createState() => _RegistrationscreenState();
}

class _RegistrationscreenState extends State<Registrationscreen> {
  //controller
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  RegistrationModel regModel = RegistrationModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Job Post ${regModel.id}"),
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
                  decoration: const InputDecoration(hintText: "password"),
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
                      ApiServicesReg()
                          .registrationApi(
                              email.text.toString(), password.text.toString())
                          .then((value) {
                        setState(() {
                          regModel = value!;

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Userscreen(
                                        id: regModel.id.toString(),
                                        token: regModel.token.toString(),
                                      ) // Passing token Value
                                  ));
                        });
                      });
                    },
                    child: const Text("Registration")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
