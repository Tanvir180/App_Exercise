import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:state_management/SqfLite/model_class.dart';

class DbHandler {
  Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }

    // find path and create file
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'mydatabase.db');

    // Open .db to create table
    _database = await openDatabase(path, version: 1, onCreate: (db, version) {
      db.execute('''
        CREATE TABLE DatabaseTable(
        id INTEGER PRIMARY KEY,
        name TEXT,
        age INTEGER
        )
        ''');
    });
    return _database!;
  }

  Future<int> insertData(ModelClass modelclass) async {

    // int id, String name, int age   under function parameter

    // Map<String,Object?> map={
    //   'id' : id,
    //   'name' : name,
    //   'age' : age,
    //
    // };
    Database? db = await database;
   return db!.insert('DatabaseTable', modelclass.tomap());
  }
  
 Future<List<ModelClass>> readData() async{
    Database? db = await database;
    final list = await db!.query('DatabaseTable');
    return list.map((map)=>ModelClass.fromMap(map)).toList();
  }

 Future<int> deleteData( int id) async{


      Database? db = await database;

      return await db!.delete('DatabaseTable',
          where: 'id = ?',
          whereArgs: [id]
      );


    }



  Future<int> updateData(ModelClass modelclass) async{

    //Map<String, Object> data
    Database? db = await database;

   return await db!.update('DatabaseTable',
     modelclass.tomap(),
     //data,
      where: 'id = ?',
      whereArgs: [modelclass.id]
    );
  }
  
}
