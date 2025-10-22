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
  static final String COLUMN_CART_ITEMS_INVENTORY_ID = "inventory_id";
  static final String COLUMN_CART_ITEMS_QUANTITY = "quantity";
  static final String COLUMN_CART_ITEMS_CREATED_AT = "created_at";
  static final String COLUMN_CART_ITEMS_UPDATED_AT = "updated_at";

  static final String TABLE_ORDERS = "orders";

  static final String COLUMN_ORDERS_ID = "id";
  static final String COLUMN_ORDERS_USER_ID = "user_id";
  static final String COLUMN_ORDERS_REMOTE_ID = "remote_id";
  static final String COLUMN_ORDERS_ADDRESS = "address";
  static final String COLUMN_ORDERS_TOTAL_PRICE = "total_price";
  static final String COLUMN_ORDERS_CREATED_AT = "created_at";
  static final String COLUMN_ORDERS_UPDATED_AT = "updated_at";
  static final String COLUMN_ORDERS_STATUS = "status";

    
  static final String TABLE_ORDER_ITEMS = "order_items";

  static final String COLUMN_ORDER_ITEMS_ID = "id";
  static final String COLUMN_ORDER_ITEMS_INVENTORY_ID = "inventory_id";
  static final String COLUMN_ORDER_ITEMS_REMOTE_ID = "remote_id";
  static final String COLUMN_ORDER_ITEMS_ORDER_ID = "order_id";
  static final String COLUMN_ORDER_ITEMS_TITLE = "title";
  static final String COLUMN_ORDER_ITEMS_COLOUR_NAME = "colour_name";
  static final String COLUMN_ORDER_ITEMS_QUANTITY = "quantity";
  static final String COLUMN_ORDER_ITEMS_UNIT_PRICE = "unit_price";
  static final String COLUMN_ORDER_ITEMS_TOTAL_PRICE = "total_price";
  static final String COLUMN_ORDER_ITEMS_CREATED_AT = "created_at";
  static final String COLUMN_ORDER_ITEMS_UPDATED_AT = "updated_at";


  Database? myDB;

  Future<Database> getDB() async{
    return myDB ??= await openDB();
  }

  Future<Database> openDB() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appDir.path, "noteDB.db");
    return await openDatabase(dbPath, onCreate: (db, version) async {
      await db.execute('''
      CREATE TABLE $TABLE_USERS (
        $COLUMN_USERS_ID INTEGER PRIMARY KEY AUTOINCREMENT,
        $COLUMN_USERS_NAME TEXT NOT NULL,
        $COLUMN_USERS_EMAIL TEXT NOT NULL UNIQUE,
        $COLUMN_USERS_PASSWORD TEXT NOT NULL,
        $COLUMN_USERS_CREATED_AT TEXT DEFAULT (datetime('now')),
        $COLUMN_USERS_UPDATED_AT TEXT DEFAULT (datetime('now'))
      )
      ''');

      await db.execute('''
      CREATE TABLE $TABLE_CATEGORIES (
        $COLUMN_CATEGORIES_ID INTEGER PRIMARY KEY AUTOINCREMENT,
        $COLUMN_CATEGORIES_NAME TEXT NOT NULL,
        $COLUMN_CATEGORIES_REMOTE_ID TEXT,
        $COLUMN_CATEGORIES_CREATED_AT TEXT DEFAULT (datetime('now')),
        $COLUMN_CATEGORIES_UPDATED_AT TEXT DEFAULT (datetime('now'))
      )
      ''');

      await db.execute('''
      CREATE TABLE $TABLE_PRODUCTS (
        $COLUMN_PRODUCTS_ID INTEGER PRIMARY KEY AUTOINCREMENT,
        $COLUMN_PRODUCTS_REMOTE_ID TEXT,
        $COLUMN_PRODUCTS_TITLE TEXT NOT NULL,
        $COLUMN_PRODUCTS_SUBTITLE TEXT,
        $COLUMN_PRODUCTS_IMAGE TEXT,
        $COLUMN_PRODUCTS_DESCRIPTION TEXT,
        $COLUMN_PRODUCTS_CATEGORY_ID INTEGER,
        $COLUMN_PRODUCTS_PRICE REAL NOT NULL,
        $COLUMN_PRODUCTS_CREATED_AT TEXT DEFAULT (datetime('now')),
        $COLUMN_PRODUCTS_UPDATED_AT TEXT DEFAULT (datetime('now')),
        FOREIGN KEY ($COLUMN_PRODUCTS_CATEGORY_ID) REFERENCES $TABLE_CATEGORIES($COLUMN_CATEGORIES_ID)
      )
      ''');

      await db.execute('''
      CREATE TABLE $TABLE_COLOURS (
        $COLUMN_COLOURS_ID INTEGER PRIMARY KEY AUTOINCREMENT,
        $COLUMN_COLOURS_NAME TEXT NOT NULL,
        $COLUMN_COLOURS_REMOTE_ID TEXT,
        $COLUMN_COLOURS_CREATED_AT TEXT DEFAULT (datetime('now')),
        $COLUMN_COLOURS_UPDATED_AT TEXT DEFAULT (datetime('now'))
      )
      ''');

      await db.execute('''
      CREATE TABLE $TABLE_INVENTORY (
        $COLUMN_INVENTORY_ID INTEGER PRIMARY KEY AUTOINCREMENT,
        $COLUMN_INVENTORY_PRODUCT_ID INTEGER NOT NULL,
        $COLUMN_INVENTORY_COLOUR_ID INTEGER NOT NULL,
        $COLUMN_INVENTORY_QUANTITY INTEGER NOT NULL,
        $COLUMN_INVENTORY_CREATED_AT TEXT DEFAULT (datetime('now')),
        $COLUMN_INVENTORY_UPDATED_AT TEXT DEFAULT (datetime('now')),
        FOREIGN KEY ($COLUMN_INVENTORY_PRODUCT_ID) REFERENCES $TABLE_PRODUCTS($COLUMN_PRODUCTS_ID),
        FOREIGN KEY ($COLUMN_INVENTORY_COLOUR_ID) REFERENCES $TABLE_COLOURS($COLUMN_COLOURS_ID)
      )
      ''');

      await db.execute('''
      CREATE TABLE $TABLE_CART_ITEMS (
        $COLUMN_CART_ITEMS_ID INTEGER PRIMARY KEY AUTOINCREMENT,
        $COLUMN_CART_ITEMS_INVENTORY_ID INTEGER NOT NULL,
        $COLUMN_CART_ITEMS_QUANTITY INTEGER NOT NULL,
        $COLUMN_CART_ITEMS_CREATED_AT TEXT DEFAULT (datetime('now')),
        $COLUMN_CART_ITEMS_UPDATED_AT TEXT DEFAULT (datetime('now')),
        FOREIGN KEY ($COLUMN_CART_ITEMS_INVENTORY_ID) REFERENCES $TABLE_INVENTORY($COLUMN_INVENTORY_ID)
      )
      ''');

      await db.execute('''
      CREATE TABLE $TABLE_ORDERS (
        $COLUMN_ORDERS_ID INTEGER PRIMARY KEY AUTOINCREMENT,
        $COLUMN_ORDERS_USER_ID INTEGER NOT NULL,
        $COLUMN_ORDERS_REMOTE_ID TEXT,
        $COLUMN_ORDERS_ADDRESS TEXT,
        $COLUMN_ORDERS_TOTAL_PRICE REAL NOT NULL,
        $COLUMN_ORDERS_STATUS TEXT DEFAULT 'pending',
        $COLUMN_ORDERS_CREATED_AT TEXT DEFAULT (datetime('now')),
        $COLUMN_ORDERS_UPDATED_AT TEXT DEFAULT (datetime('now')),
        FOREIGN KEY ($COLUMN_ORDERS_USER_ID) REFERENCES $TABLE_USERS($COLUMN_USERS_ID)
      )
      ''');

      await db.execute('''
      CREATE TABLE $TABLE_ORDER_ITEMS (
        $COLUMN_ORDER_ITEMS_ID INTEGER PRIMARY KEY AUTOINCREMENT,
        $COLUMN_ORDER_ITEMS_ORDER_ID INTEGER NOT NULL,
        $COLUMN_ORDER_ITEMS_INVENTORY_ID INTEGER,
        $COLUMN_ORDER_ITEMS_REMOTE_ID TEXT,
        $COLUMN_ORDER_ITEMS_TITLE TEXT NOT NULL,
        $COLUMN_ORDER_ITEMS_COLOUR_NAME TEXT,
        $COLUMN_ORDER_ITEMS_QUANTITY INTEGER NOT NULL,
        $COLUMN_ORDER_ITEMS_UNIT_PRICE REAL NOT NULL,
        $COLUMN_ORDER_ITEMS_TOTAL_PRICE REAL NOT NULL,
        $COLUMN_ORDER_ITEMS_CREATED_AT TEXT DEFAULT (datetime('now')),
        $COLUMN_ORDER_ITEMS_UPDATED_AT TEXT DEFAULT (datetime('now')),
        FOREIGN KEY ($COLUMN_ORDER_ITEMS_ORDER_ID) REFERENCES $TABLE_ORDERS($COLUMN_ORDERS_ID),
        FOREIGN KEY ($COLUMN_ORDER_ITEMS_INVENTORY_ID) REFERENCES $TABLE_INVENTORY($COLUMN_INVENTORY_ID)
      )
      ''');

    },version: 1);
  }

  void addCartItem(){
    
  }

}