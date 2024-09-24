import 'package:flutter/material.dart';
import 'package:state_management/SqfLite/db_handler.dart';
import 'package:state_management/SqfLite/model_class.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({super.key});

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Screen"),
      ),
      body: FutureBuilder(
        future: DbHandler().readData(),
        builder: (context, AsyncSnapshot<List<ModelClass>> snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
          }
          return ListView.builder(

            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ListTile(

                title: Text(snapshot.data![index].name),
                subtitle: Text(snapshot.data![index].age.toString()),

              );
            },
          );
        },


      ),
    );
  }
}
