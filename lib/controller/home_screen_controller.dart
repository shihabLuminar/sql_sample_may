import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class HomeScreenController {
  static List myDataList = [];
  static late Database database;

  static Future<void> initDb() async {
    var path = 'mydb.db'; // db path for platform other than web
    if (kIsWeb) {
      // Change default factory on the web
      databaseFactory = databaseFactoryFfiWeb;
      path = 'my_web_web.db';
    }

    database = await openDatabase("mydb.db", version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Employees (id INTEGER PRIMARY KEY, name TEXT, designation TEXT)');
    });
  }

  static Future<void> addEmployee(
      {required String name, required String designation}) async {
    await database.rawInsert(
        'INSERT INTO Employees(name, designation) VALUES(?, ?)',
        [name, designation]);
  }

  static Future<void> deleteEmployee(var id) async {
    await database.rawDelete('DELETE FROM Employees WHERE id = ?', ['$id']);
    await getEmployees();
  }

  static Future<void> getEmployees() async {
    List<Map> list = await database.rawQuery('SELECT * FROM Employees');
    print(list);
    myDataList = list;
  }

  void updateEmployee() {}
}
