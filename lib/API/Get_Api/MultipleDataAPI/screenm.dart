import 'package:flutter/material.dart';
import 'package:state_management/API/Get_Api/MultipleDataAPI/api_servicem.dart';
import 'package:state_management/API/Get_Api/MultipleDataAPI/modelm.dart';

class ScreenWitModel extends StatefulWidget {
  const ScreenWitModel({super.key});

  @override
  State<ScreenWitModel> createState() => _ScreenWitModelState();
}

class _ScreenWitModelState extends State<ScreenWitModel> {
/////////////////
  bool isReady = false;
  List<PostModel> postModel = [];

  _getPost() {
    isReady = true;
    ApiServices().getPostWithModel().then((value) {
      setState(() {
        postModel = value!;
        isReady = false;
      });
    });
  }

  @override
  void initState() {
    _getPost();
    super.initState();
  }

////////////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Posts With Model"),
        ),
        drawer: const Drawer(),

        /////////////////////

        body: isReady == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: postModel.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.all(10),
                    color: const Color.fromRGBO(255, 240, 120, 0.4),
                    child: ListTile(
                      leading: Text(postModel[index].id.toString()),
                      title: Text(postModel[index].title.toString()),
                      subtitle: Text(postModel[index].body.toString()),
                    ),
                  );
                }));
  }
}
