import 'package:flutter/material.dart';
import 'package:state_management/API/Post_Api/Login_Api/Api_Services_PostL.dart';
import 'package:state_management/API/Post_Api/Login_Api/LoginModel.dart';
import 'package:state_management/API/Post_Api/Login_Api/homescreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  LoginModel loginModel = LoginModel();
  bool isReady = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: loginModel.token == null || loginModel.token == ""
            ? const Text("Login Screen")
            : Text("Login Screen ${loginModel.token}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: email,
              decoration: const InputDecoration(hintText: "Enter Email"),
            ),
            TextField(
              controller: password,
              decoration: const InputDecoration(hintText: "Enter Password"),
            ),
            const SizedBox(height: 50),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isReady = true;
                    });

                    ApiServices()
                        .loginWithModel(
                            email.text.toString(), password.text.toString())
                        .then((value) {
                      setState(() {
                        loginModel = value!;
                        isReady = false;
                        print(loginModel.token);

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen(
                                    token: loginModel.token
                                        .toString()) // Passing token Value
                                ));
                      });
                    }).onError((error, stackTrace) {
                      setState(() {
                        isReady = false;
                      });

                      print(error);
                    });
                  },
                  child: isReady == true
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : const Text("Login")),
            ),
          ],
        ),
      ),
    );
  }
}
