import 'package:flutter/material.dart';
import 'package:state_management/Movie_App/Data/db_handler.dart';

class Bookmark extends StatefulWidget {
  const Bookmark({super.key});

  @override
  State<Bookmark> createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 350, 0, 0),
          child: Center(
            child: Column(
              children: [

                ElevatedButton(
                    onPressed: () async {
                      final data = await DbHandler().readData().then((Value)
                      {
                        print('Read Data');
                      }).onError((error,stackTrace){
                        print('Error found');
                      });
                      print(data[0].id);
                      print(data.toString());
                    },
                    child: const Text('Read')),

              ],
            ),
          ),
        ),

      ),


    );
  }
}
