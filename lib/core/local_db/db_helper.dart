import 'package:flutter_laravel/zakat/domain/models/products_model.dart';
import 'package:flutter_laravel/zakat/domain/models/zakat_model.dart';
import 'package:flutter_laravel/zakat/domain/models/zakat_products_model.dart';
import 'package:flutter_laravel/zakat/domain/requsts/delete_product_request.dart';
import 'package:flutter_laravel/zakat/domain/requsts/delete_zakat_products_request.dart';
import 'package:flutter_laravel/zakat/domain/requsts/delete_zakat_request.dart';
import 'package:flutter_laravel/zakat/domain/requsts/get_zakat_products_by_zakat_id_request.dart';
import 'package:flutter_laravel/zakat/domain/requsts/insert_product_request.dart';
import 'package:flutter_laravel/zakat/domain/requsts/insert_zakat_products_request.dart';
import 'package:flutter_laravel/zakat/domain/requsts/insert_zakat_request.dart';
import 'package:flutter_laravel/zakat/domain/requsts/update_product_request.dart';
import 'package:flutter_laravel/zakat/domain/requsts/update_zakat_products_request.dart';
import 'package:flutter_laravel/zakat/domain/requsts/update_zakat_request.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  Database? _db;

  String dbdName = 'zakat_test.db';

  static int? insertedNewPostId;

  Future<Database> get database async {
    if (_db != null) {
      return _db!;
    } else {
      _db = await initDB(dbdName);
      return _db!;
    }
  }

  Future<Database> initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: createDB);
    // return await openDatabase(path, version: 1, onCreate: createDB,onUpgrade: onUpgrade);
  }

  Future createDB(Database db, int version) async {
    await db.execute(
        'create table zakat(id integer primary key autoincrement, membersCount integer, zakatValue varchar(10), remainValue varchar(10))');

    await db.execute(
        'create table zakatProducts(id integer primary key autoincrement, productName varchar(255), productPrice varchar(10), productDesc varchar(255), productImage varchar(255), productQuantity integer, zakatId integer)');

    await db.execute(
        'create table productsData(id integer primary key autoincrement, productName varchar(255), productPrice varchar(10), productDesc varchar(255), productImage varchar(255))');
  }

  // Future onUpgrade(Database db, int oldVersion, int newVersion) async {
  //   if (oldVersion < newVersion) {
  //     await db.execute('alter table saved_posts RENAME COLUMN secondCategory TO subCategory');
  //   }
  // }

  // add -------------------------------------------
  Future<int> insertZakatData(InsertZakatRequest insertZakatRequest) async {
    final db = _db!.database;
    return db.insert('zakat', insertZakatRequest.toJson());
  }

  Future<int> insertZakatProductsData(
      InsertZakatProductsRequest insertZakatProductsRequest) async {
    final db = _db!.database;
    return db.insert('zakatProducts', insertZakatProductsRequest.toJson());
  }

  Future<int> insertProductData(
      InsertProductRequest insertProductRequest) async {
    final db = _db!.database;
    return db.insert('productsData', insertProductRequest.toJson());
  }

  // update ------------------------------------------
  Future<int> updateZakatData(UpdateZakatRequest updateZakatRequest) async {
    if (_db == null) {
      await initDB(dbdName);
    }

    final db = _db!.database;
    return db.update('zakat', updateZakatRequest.toJson(),
        where: 'id = ?', whereArgs: [updateZakatRequest.id]);
  }

  Future<int> updateZakatProductsData(
      UpdateZakatProductsRequest updateZakatProductsRequest) async {
    if (_db == null) {
      await initDB(dbdName);
    }

    final db = _db!.database;
    return db.update('zakatProducts', updateZakatProductsRequest.toJson(),
        where: 'id = ?', whereArgs: [updateZakatProductsRequest.id]);
  }

  Future<int> updateProductData(
      UpdateProductRequest updateProductRequest) async {
    if (_db == null) {
      await initDB(dbdName);
    }

    final db = _db!.database;
    return db.update('productsData', updateProductRequest.toJson(),
        where: 'id = ?', whereArgs: [updateProductRequest.id]);
  }

  // delete ---------------------------------------------
  Future<int> deleteZakatData(DeleteZakatRequest deleteZakatRequest) async {
    if (_db == null) {
      await initDB(dbdName);
    }

    final db = _db!.database;

    return db
        .delete('zakat', where: 'id = ?', whereArgs: [deleteZakatRequest.id]);
  }

  Future<int> deleteZakatProductsData(
      DeleteZakatProductsRequest deleteZakatProductsRequest) async {
    if (_db == null) {
      await initDB(dbdName);
    }

    final db = _db!.database;

    return db.delete('zakatProducts',
        where: 'zakatId = ?', whereArgs: [deleteZakatProductsRequest.id]);
  }

  Future<int> deleteProductData(
      DeleteProductRequest deleteProductRequest) async {
    if (_db == null) {
      await initDB(dbdName);
    }

    final db = _db!.database;

    return db.delete('productsData',
        where: 'id = ?', whereArgs: [deleteProductRequest.id]);
  }
  // get data -------------------------------------------
  Future<List<ProductsModel>> getAllProducts() async {
    if (_db == null) {
      await initDB(dbdName);
    }

    final db = _db!.database;

    final result =
        await db.rawQuery('SELECT * FROM productsData Order by id ASC');
    return result.map((map) => ProductsModel.fromMap(map)).toList();
  }

  Future<List<ZakatModel>> getAllZakat() async {
    if (_db == null) {
      await initDB(dbdName);
    }

    final db = _db!.database;

    final result = await db.rawQuery('SELECT * FROM zakat Order by id ASC');
    return result.map((map) => ZakatModel.fromMap(map)).toList();
  }

  Future<List<ZakatProductsModel>> getZakatProductsByZatatId(
      GetZakatProductsByZatatIdRequest getZakatProductsByZatatIdRequest) async {
    if (_db == null) {
      await initDB(dbdName);
    }

    final db = _db!.database;
    var result = [];
    result = await db.rawQuery('SELECT * FROM zakatProducts where zakatId = ?',
        [getZakatProductsByZatatIdRequest.zakatId]);

    return result.map((map) => ZakatProductsModel.fromMap(map)).toList();
  }

  // get totals -------------------------------------------------
  Future<List<ZakatProductsModel>> getAllZakatProductsByKilos() async {
    if (_db == null) {
      await initDB(dbdName);
    }

    final db = _db!.database;

    final result = await db.rawQuery(
        'SELECT SUM(productQuantity) FROM zakatProducts GROUP BY productName');
    return result.map((map) => ZakatProductsModel.fromMap(map)).toList();
  }
}
