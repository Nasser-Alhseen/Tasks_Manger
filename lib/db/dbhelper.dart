import 'package:flutter/cupertino.dart';
import 'package:flutter_app3/models/task.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:sqflite/sqflite.dart';

class DBhelper {
  static const int version = 2;
  static const String dbName = 'TasksDB.db';
  static const String tableName = "notesDb";
  static Database? db;
  static Future<void> initDB() async {
    if (db != null)
      ;
    else {
      try {
        String path = await getDatabasesPath() + dbName;
        db = await openDatabase(path, version: 1,
            onCreate: (Database db, int veriosn) async {
          await db.execute(
              'CREATE TABLE $tableName (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, note TEXT, isCompleted INTEGER,date TEXT,startTime TEXT,endTime TEXT,reminder INTEGER,repeat TEXT,color INTEGER)');
        });
      } catch (e) {
        // ignore: avoid_print
        print(e.toString());
      }
    }
  }

  static Future<int> insert(Task? myTask) async {
    print('insert function called');
    return await db!.insert(tableName,myTask!.toJson());
  }

  static Future<int> delete(Task myTask) async {
    print('delete function called');

    return await db!.delete(tableName, where: 'id=?', whereArgs: [myTask.id]);
  }

  static Future<int> update(int id) async {
    print('update function called');

    return await db!.rawUpdate('''
    UPDATE notesDb
    SET isCompleted= ?
    WHERE id = ?
    
    ''', [1, id]);
  }

  static  getData() async {
    return await db!.query(tableName);
  }
}
