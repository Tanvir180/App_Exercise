import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:state_management/Movie_App/models/movie_detail_model.dart';
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
        CREATE TABLE BookMarkTable(
        id INTEGER PRIMARY KEY,
        title TEXT,
        runtime INTEGER,
        posterPath TEXT,
        imdbId TEXT
        )
        ''');
    });
    return _database!;
  }

  Future<int> insertData(int? id, String? title,String? imdbId, String? posterPath,int? runtime) async {

    Map<String,dynamic> map={
      'id' : id,
      'title' : title,
      'imdbId' : imdbId,
      'posterPath' : posterPath,
      'runtime' : runtime,

    };


    Database? db = await database;
   return db!.insert('BookMarkTable', map);
  }


  Future<List<Map<String, dynamic>>> getData() async {
    Database? db = await database;
    return await db!.query('BookMarkTable');
  }


  // Check if a movie is already bookmarked





  // Future<String> readData() async{
  //   Database? db = await database;
  //   final list = await db!.query('BookMarkTable');
  //   print(list);
  //   return list.map.toString();
  // }

 Future<int> deleteData( int id) async{


      Database? db = await database;

      return await db!.delete('BookMarkTable',
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
