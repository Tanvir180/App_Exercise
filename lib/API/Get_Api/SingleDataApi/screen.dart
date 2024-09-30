import 'package:flutter/material.dart';
import 'package:state_management/API/Get_Api/SingleDataApi/api_service.dart';
import 'package:state_management/API/Get_Api/SingleDataApi/model.dart';

class ScreenSingle extends StatefulWidget {
  const ScreenSingle({super.key});

  @override
  State<ScreenSingle> createState() => _ScreenSingleState();
}

class _ScreenSingleState extends State<ScreenSingle> {
  bool isReady = false;

  Model singlePostWithModel = Model();

  _getSinglePost() {
    isReady = true;
    ApiServices().getSinglePostWithModel().then((value) {
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
          title: const Text("API Intregation Single"),
        ),
        body: isReady == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    singlePostWithModel.userId.toString(),
                    style: const TextStyle(fontSize: 20, color: Colors.blue),
                  ),
                  Text(
                    singlePostWithModel.title.toString(),
                    style:
                        const TextStyle(fontSize: 18, color: Colors.redAccent),
                  ),
                  Text(
                    singlePostWithModel.body.toString(),
                    style: const TextStyle(fontSize: 15),
                  )
                ],
              )
    );
  }
}
