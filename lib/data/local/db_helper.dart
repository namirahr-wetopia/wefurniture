import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper{
  static DBHelper? _uniqueInstance;
  DBHelper._();
  
  static DBHelper? getInstance(){
    return _uniqueInstance ??= DBHelper._();
  }
  


  static final String TABLE_CART_ITEMS = "cart_items";

  static final String COLUMN_CART_ITEMS_ID = "id";
  static final String COLUMN_CART_ITEMS_QUANTITY = "quantity";
  static final String COLUMN_CART_ITEMS_CREATED_AT = "created_at";
  static final String COLUMN_CART_ITEMS_UPDATED_AT = "updated_at";



  Database? myDB;

  Future<Database> getDB() async{
    return myDB ??= await openDB();
  }

  Future<Database> openDB() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appDir.path, "noteDB.db");
    return await openDatabase(dbPath, onCreate: (db, version) async {

      await db.execute('''
      CREATE TABLE $TABLE_CART_ITEMS (
        $COLUMN_CART_ITEMS_ID INTEGER PRIMARY KEY AUTOINCREMENT,
        $COLUMN_CART_ITEMS_QUANTITY INTEGER NOT NULL,
        $COLUMN_CART_ITEMS_CREATED_AT TEXT DEFAULT (datetime('now')),
        $COLUMN_CART_ITEMS_UPDATED_AT TEXT DEFAULT (datetime('now')),
      )
      ''');
    },version: 1);
  }

  void addCartItem(){
    
  }

}