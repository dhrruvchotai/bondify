
// DB.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

import '../pages/String_Utils.dart';

class DB {
  Database? userDB;
  List<Map<String, dynamic>> usersList = [];
  List<Map<String,dynamic>> searchUsersList = [];


  DB() {
    initDatabase();
    fetchUsersFromUsersTable();
  }

  Future<void> initDatabase() async {
    try {
      final dbPath = await getDatabasesPath();
      userDB = await openDatabase(
        path.join(dbPath, 'userDB.db'),
        version: 4,
        onCreate: (db, version) async {
          print('Creating tables...');

          await db.execute(
              '''
              CREATE TABLE users (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                $FULLNAME TEXT NOT NULL,
                $PHONE TEXT UNIQUE NOT NULL,
                $EMAIL TEXT UNIQUE NOT NULL,
                $DOB TEXT NOT NULL,
                $GENDER TEXT CHECK($GENDER IN ('Male', 'Female', 'Other')) NOT NULL,
                $RELIGION TEXT NOT NULL,
                $CITY TEXT NOT NULL,
                $HOBBIES TEXT,
                $ISUSERFAV INTEGER DEFAULT 0
              );
            '''
          );

          await db.execute(
              '''
              CREATE TABLE auth (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                $USERNAME TEXT UNIQUE NOT NULL,
                $AUTH_EMAIL TEXT UNIQUE NOT NULL,
                $PASSWORD TEXT NOT NULL
              );
            '''
          );

          print("Tables created successfully!");
        },
      );
    } catch(e) {
      print('Database initialization error: $e');
      printWarning('Database initialization error: $e');
    }
  }

  Future<void> addUserInUsersTable(Map<String, dynamic> user) async {
    try {
      if (userDB == null) {
        await initDatabase();
      }
      printWarning('Attempting to insert user: $user');

      await userDB?.insert('users', user);
      await fetchUsersFromUsersTable();
    } catch(e) {
      printResultText('Error in adding user to database: $e');
    }
  }

  Future<void> addUserInAuthTable(Map<String, dynamic> authData) async {
    try {
      if (userDB == null) {
        await initDatabase();
      }
      printWarning('Attempting to insert auth data: $authData');

      await userDB?.insert('auth', authData);
    } catch(e) {
      printResultText('Error in adding auth data to database: $e');
    }
  }

  Future<void> fetchUsersFromUsersTable() async {
    try {
      if (userDB == null) {
        await initDatabase();
      }
      usersList = await userDB?.query('users') ?? [];
      printWarning('Users: $usersList');
    } catch(e) {
      printResultText('Error in fetching users: $e');
    }
  }

  Future<void> deleteUserFromUsersTable(int id) async {
    try {
      if (userDB == null) {
        await initDatabase();
      }
      await userDB?.delete(
        'users',
        where: 'id = ?',
        whereArgs: [id],
      );
      await fetchUsersFromUsersTable();
    } catch(e) {
      printResultText('Error in deleting user: $e');
    }
  }

  Future<void> updateUserInUsersTable(int id, Map<String, dynamic> user) async {
    try {
      if (userDB == null) {
        await initDatabase();
      }
      await userDB?.update(
        'users',
        user,
        where: 'id = ?',
        whereArgs: [id],
      );
      await fetchUsersFromUsersTable();
    } catch(e) {
      printResultText('Error occurred in updating user detail: $e');
    }
  }

  Future<void> makeUserFav(int id,int isFavNum) async{
    try{
      await userDB?.update(
          'users',
          {ISUSERFAV : isFavNum},
          where: "id = ?",
          whereArgs: [id]
      );
      await fetchUsersFromUsersTable();
    }
    catch(e){
      printWarning('Error in making user favorite : $e');
    }
  }
}