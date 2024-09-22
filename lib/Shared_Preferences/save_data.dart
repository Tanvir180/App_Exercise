import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:state_management/Shared_Preferences/show_data.dart';

class SaveData extends StatefulWidget {
  const SaveData({super.key});

  @override
  State<SaveData> createState() => _SaveDataState();
}

class _SaveDataState extends State<SaveData> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Login Screen"),
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
            SizedBox(
              height: 10,
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
                  onPressed: () async{
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setString("email", email.text! =="" ? prefs.getString("email")!:email.text! );
                    prefs.setString("password", password.text).then((value) {
                      // print(prefs.getString("email"));
                      // print(prefs.getString("password"));
                    },);
                    
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ShowData()));

                  }, child:Text("Login"),)

            ),
          ]
    )
    )
    );

  }
}
