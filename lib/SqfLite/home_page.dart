import 'package:flutter/material.dart';
import 'package:state_management/SqfLite/data_screen.dart';
import 'package:state_management/SqfLite/db_handler.dart';
import 'package:state_management/SqfLite/model_class.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 350, 0, 0),
          child: Center(
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: 'Name'
                  ),
                ) ,
                TextFormField(
                  controller: ageController,
                  decoration: const InputDecoration(
                    hintText: 'age'
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      await DbHandler().insertData(ModelClass(name: nameController.text, age: int.parse(ageController.text)));     // string ==> int
                    },
                    child: const Text('Insert')),
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
                ElevatedButton(
                    onPressed: () async {
                      await DbHandler().deleteData(2).then((Value)
                      {
                        print('delete Data');
                      }).onError((error,stackTrace){
                        print('Error found');
                      });
                    },
                    child: const Text('Delete')),
                ElevatedButton(
                    onPressed: () async {
                      await DbHandler()
                          .updateData(
                          // 5, {'id': 2, 'name': 'Xyz', 'age': 55}
                      ModelClass(id: 1, name: 'XXX', age: 10)
                      );
                    },
                    child: const Text('Update')),
              ],
            ),
          ),
        ),

      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> DataScreen(),));
    }

    ),
    );
  }
}
