import 'package:sqflite/sqflite.dart';

class HomeScreenController {
  late Database database;

  Future<void> initDb() async {
    database = await openDatabase("mydb.db", version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Employees (id INTEGER PRIMARY KEY, name TEXT, designation TEXT)');
    });
  }

  void addEmployee() {}
  void deleteEmployee() {}
  void getEmployees() {}
  void updateEmployee() {}
}
