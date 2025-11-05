import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../../model/cart_model.dart';

class DBHelper {
  static DBHelper? _uniqueInstance;
  DBHelper._();
  static DBHelper getInstance() => _uniqueInstance ??= DBHelper._();

  static const String TABLE_CART_ITEMS = "cart_items";

  static const String COLUMN_ID = "id";
  static const String COLUMN_PRODUCT_ID = "product_id";
  static const String COLUMN_PRODUCT_TITLE = "product_title";
  static const String COLUMN_PRODUCT_PRICE = "product_price";
  static const String COLUMN_QUANTITY = "quantity";
  static const String COLUMN_COLOR = "color";
  static const String COLUMN_SIZE = "size";
  static const String COLUMN_CREATED_AT = "created_at";
  static const String COLUMN_UPDATED_AT = "updated_at";

  Database? _db;

  Future<Database> getDB() async {
    return _db ??= await openDB();
  }

  Future<Database> openDB() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appDir.path, "cartDB.db");
    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE $TABLE_CART_ITEMS (
          $COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT,
          $COLUMN_PRODUCT_ID INTEGER NOT NULL,
          $COLUMN_PRODUCT_TITLE TEXT NOT NULL,
          $COLUMN_PRODUCT_PRICE REAL NOT NULL,
          $COLUMN_QUANTITY INTEGER NOT NULL,
          $COLUMN_COLOR TEXT,
          $COLUMN_SIZE TEXT,
          $COLUMN_CREATED_AT TEXT DEFAULT (datetime('now')),
          $COLUMN_UPDATED_AT TEXT DEFAULT (datetime('now'))
        )
        ''');
      },
    );
  }

  Future<int> insertCartItem(CartModel item) async {
    final db = await getDB();
    return await db.insert(
      TABLE_CART_ITEMS,
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> updateCartItemQuantity(int productId, int quantity) async {
    final db = await getDB();
    return await db.update(
      TABLE_CART_ITEMS,
      {
        COLUMN_QUANTITY: quantity,
        COLUMN_UPDATED_AT: DateTime.now().toIso8601String()
      },
      where: '$COLUMN_PRODUCT_ID = ?',
      whereArgs: [productId],
    );
  }

  Future<int> deleteCartItemByProductId(int productId) async {
    final db = await getDB();
    return await db.delete(
      TABLE_CART_ITEMS,
      where: '$COLUMN_PRODUCT_ID = ?',
      whereArgs: [productId],
    );
  }

  Future<List<CartModel>> getAllCartItems() async {
    final db = await getDB();
    final maps = await db.query(
      TABLE_CART_ITEMS,
      orderBy: '$COLUMN_CREATED_AT DESC',
    );
    return maps.map((m) => CartModel.fromMap(m)).toList();
  }

  Future<CartModel?> getCartItemByProductId(int productId) async {
    final db = await getDB();
    final maps = await db.query(
      TABLE_CART_ITEMS,
      where: '$COLUMN_PRODUCT_ID = ?',
      whereArgs: [productId],
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return CartModel.fromMap(maps.first);
  }

  Future<int> clearCart() async {
    final db = await getDB();
    return await db.delete(TABLE_CART_ITEMS);
  }
}
