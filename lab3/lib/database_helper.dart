import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _dbName = 'contacts.db';
  static final _dbVersion = 1;

  static Future<Database> initDB() async {
    final path = join(await getDatabasesPath(), _dbName);
    return openDatabase(
      path,
      version: _dbVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE contacts (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            phone TEXT
          )
        ''');
      },
    );
  }

  static Future<void> addContact(Database db, String name, String phone) async {
    await db.insert('contacts', {'name': name, 'phone': phone});
  }

  static Future<List<Map<String, dynamic>>> getContacts(Database db) async {
    return await db.query('contacts');
  }

  static Future<void> updateContact(Database db, int id, String name, String phone) async {
    await db.update('contacts', {'name': name, 'phone': phone}, where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> deleteContact(Database db, int id) async {
    await db.delete('contacts', where: 'id = ?', whereArgs: [id]);
  }
}
