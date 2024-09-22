import 'package:flutter/material.dart';
import 'package:state_management/API/Header_Passing/api_services_header.dart';
import 'package:state_management/API/Header_Passing/responsemodel.dart';

class Userinscreen extends StatefulWidget {
  final String accessToken;
  const Userinscreen({super.key, required this.accessToken});

  @override
  State<Userinscreen> createState() => _UserinscreenState();
}

class _UserinscreenState extends State<Userinscreen> {
  bool isReady = false;

  ResponseModel singlePostWithModel = ResponseModel();

  _getSinglePost() {
    isReady = true;
    ResponseApiServices().getResponseData(widget.accessToken).then((value) {
      setState(() {
        singlePostWithModel = value!;
        isReady = false;
      });
    });
  }

  @override
  void initState() {
    _getSinglePost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("User Info"),
        ),
        body: isReady == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    // CircleAvatar(
                    //   radius: 50.0,
                    //   backgroundImage: NetworkImage("https://i.imgur.com/LDOO4Qs.jpg"),
                    // ),
                    //
                    // ClipOval(
                    //   child: Image.network(
                    //     "$singlePostWithModel.avatar",
                    //     width: 100.0,
                    //     height: 100.0,
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),




                    Text(
                      singlePostWithModel.id.toString(),
                      style: const TextStyle(fontSize: 20, color: Colors.blue),
                    ),
                    Text(
                      singlePostWithModel.name.toString(),
                      style:
                          const TextStyle(fontSize: 18, color: Colors.redAccent),
                    ),
                    Text(
                      singlePostWithModel.email.toString(),
                      style: const TextStyle(fontSize: 15),
                    ),
                    Text(
                      singlePostWithModel.role.toString(),
                      style: const TextStyle(fontSize: 15),
                    ),
                    Text(
                      singlePostWithModel.password.toString(),
                      style: const TextStyle(fontSize: 15),
                    )
                  ],
                ),
            ));
  }
}
