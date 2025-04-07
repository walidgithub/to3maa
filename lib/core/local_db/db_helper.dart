import 'package:To3maa/zakat/domain/models/products_model.dart';
import 'package:To3maa/zakat/domain/models/purchases_by_kilos_model.dart';
import 'package:To3maa/zakat/domain/models/purchases_model.dart';
import 'package:To3maa/zakat/domain/models/sundries_model.dart';
import 'package:To3maa/zakat/domain/models/zakat_model.dart';
import 'package:To3maa/zakat/domain/models/zakat_products_by_kilos_model.dart';
import 'package:To3maa/zakat/domain/models/zakat_products_model.dart';
import 'package:To3maa/zakat/domain/requests/delete_product_request.dart';
import 'package:To3maa/zakat/domain/requests/delete_purchase_request.dart';
import 'package:To3maa/zakat/domain/requests/delete_zakat_products_request.dart';
import 'package:To3maa/zakat/domain/requests/delete_zakat_request.dart';
import 'package:To3maa/zakat/domain/requests/get_zakat_products_by_zakat_id_request.dart';
import 'package:To3maa/zakat/domain/requests/insert_product_request.dart';
import 'package:To3maa/zakat/domain/requests/insert_sundry_request.dart';
import 'package:To3maa/zakat/domain/requests/insert_zakat_products_request.dart';
import 'package:To3maa/zakat/domain/requests/insert_zakat_request.dart';
import 'package:To3maa/zakat/domain/requests/reset_product_quantity_request.dart';
import 'package:To3maa/zakat/domain/requests/update_product_quantity_request.dart';
import 'package:To3maa/zakat/domain/requests/update_product_request.dart';
import 'package:To3maa/zakat/domain/responses/purchases_by_kilos_response.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../zakat/domain/requests/delete_sundry_request.dart';
import '../../zakat/domain/requests/insert_purchase_request.dart';

class DbHelper {
  Database? _db;

  String dbdName = 'to3mah.db';

  static int? insertedNewProduct;
  static int? insertedNewZakat;

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
    // return await openDatabase(path, version: 1, onCreate: createDB);
    return await openDatabase(path,
        version: 5, onCreate: createDB, onUpgrade: onUpgrade);
  }

  Future createDB(Database db, int version) async {
    await db.execute(
        'create table zakat(id integer primary key autoincrement, membersCount integer, zakatValue varchar(10), remainValue varchar(10), hegriDate varchar(50))');

    await db.execute(
        'create table zakatProducts(id integer primary key autoincrement, productName varchar(255), productPrice varchar(10), productDesc varchar(255), productImage varchar(255), productQuantity integer, sa3Weight double, zakatId integer, hegriDate varchar(50))');

    await db.execute(
        'create table productsData(id integer primary key autoincrement, productName varchar(255), productPrice varchar(10), productDesc varchar(255), productImage varchar(255), productQuantity integer, sa3Weight double)');

    await db.execute("create table IF NOT EXISTS sundries(id integer primary key autoincrement, sundryName varchar(255), sundryPrice varchar(10))");

    await db.execute("create table IF NOT EXISTS purchases(id integer primary key autoincrement, productName varchar(255), productQuantity integer, productPrice varchar(10), productImage varchar(255))");
  }

  Future onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      await db.execute("create table IF NOT EXISTS sundries(id integer primary key autoincrement, sundryName varchar(255), sundryPrice varchar(10))");

      await db.execute("create table IF NOT EXISTS purchases(id integer primary key autoincrement, productName varchar(255), productQuantity integer, productPrice varchar(10), productImage varchar(255))");
    }
  }

  // add -------------------------------------------
  Future<int> insertZakatData(InsertZakatRequest insertZakatRequest) async {
    final db = _db!.database;
    insertedNewZakat = await db.insert('zakat', insertZakatRequest.toJson());
    return insertedNewZakat!;
  }

  Future<int> insertZakatProductsData(
      InsertZakatProductsRequest insertZakatProductsRequest) async {
    final db = _db!.database;
    return db.insert('zakatProducts', insertZakatProductsRequest.toJson());
  }

  Future<int> insertProductData(
      InsertProductRequest insertProductRequest) async {
    final db = _db!.database;
    insertedNewProduct =
        await db.insert('productsData', insertProductRequest.toJson());
    return insertedNewProduct!;
  }

  Future<int> insertSundryData(
      InsertSundryRequest insertSundryRequest) async {
    final db = _db!.database;
    return await db.insert('sundries', insertSundryRequest.toJson());
  }

  Future<int> insertPurchaseData(
      InsertPurchaseRequest insertPurchaseRequest) async {
    final db = _db!.database;
    return await db.insert('purchases', insertPurchaseRequest.toJson());
  }

  // update ------------------------------------------
  Future<int> updateProductData(
      UpdateProductRequest updateProductRequest) async {
    if (_db == null) {
      await initDB(dbdName);
    }

    final db = _db!.database;
    return db.update('productsData', updateProductRequest.toJson(),
        where: 'id = ?', whereArgs: [updateProductRequest.id]);
  }

  Future<int> updateProductQuantityData(
      UpdateProductQuantityRequest updateProductQuantityRequest) async {
    if (_db == null) {
      await initDB(dbdName);
    }

    final db = _db!.database;
    return db.update('productsData', updateProductQuantityRequest.toJson(),
        where: 'id = ?', whereArgs: [updateProductQuantityRequest.id]);
  }

  Future<int> resetProductQuantityData(
      ResetProductQuantityRequest resetProductQuantityRequest) async {
    if (_db == null) {
      await initDB(dbdName);
    }

    final db = _db!.database;
    return db.update('productsData', resetProductQuantityRequest.toJson());
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

  Future<int> deleteSundryData(DeleteSundryRequest deleteSundryRequest) async {
    if (_db == null) {
      await initDB(dbdName);
    }

    final db = _db!.database;

    return db
        .delete('sundries', where: 'id = ?', whereArgs: [deleteSundryRequest.id]);
  }

  Future<int> deletePurchaseData(DeletePurchaseRequest deletePurchaseRequest) async {
    if (_db == null) {
      await initDB(dbdName);
    }

    final db = _db!.database;

    return db
        .delete('purchases', where: 'id = ?', whereArgs: [deletePurchaseRequest.id]);
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

  // delete all zakat data
  Future<int> deleteAllZakatData() async {
    if (_db == null) {
      await initDB(dbdName);
    }

    final db = _db!.database;

    return db.delete('zakat');
  }

  Future<int> deleteAllSundriesData() async {
    if (_db == null) {
      await initDB(dbdName);
    }

    final db = _db!.database;

    return db.delete('sundries');
  }

  Future<int> deleteAllPurchasesData() async {
    if (_db == null) {
      await initDB(dbdName);
    }

    final db = _db!.database;

    return db.delete('purchases');
  }

  Future<int> deleteAllZakatProductsData() async {
    if (_db == null) {
      await initDB(dbdName);
    }

    final db = _db!.database;

    return db.delete('zakatProducts');
  }

  // delete product data
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
  Future<List<SundriesModel>> getAllSundries() async {
    if (_db == null) {
      await initDB(dbdName);
    }

    final db = _db!.database;

    final result =
    await db.rawQuery('SELECT * FROM sundries Order by id ASC');

    return result.map((map) => SundriesModel.fromMap(map)).toList();
  }

  Future<double> getTotalOfSundries() async {
    if (_db == null) {
      await initDB(dbdName);
    }

    final db = _db!.database;

    final result =
    await db.rawQuery('SELECT SUM(sundryPrice) FROM sundries');

    if (result.isNotEmpty && result[0]['SUM(sundryPrice)'] != null) {
      return result[0]['SUM(sundryPrice)'] as double;
    }

    return 0.0;
  }

  Future<List<PurchasesModel>> getAllPurchases() async {
    if (_db == null) {
      await initDB(dbdName);
    }

    final db = _db!.database;

    final result =
    await db.rawQuery('SELECT * FROM purchases Order by id ASC');
    return result.map((map) => PurchasesModel.fromMap(map)).toList();
  }

  Future<double> getTotalOfPurchases() async {
    if (_db == null) {
      await initDB(dbdName);
    }

    final db = _db!.database;

    final result =
    await db.rawQuery('SELECT SUM(productPrice) FROM purchases');

    if (result.isNotEmpty && result[0]['SUM(productPrice)'] != null) {
      return result[0]['SUM(productPrice)'] as double;
    }

    return 0.0;
  }

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

    final result = await db.rawQuery('SELECT * FROM zakat Order by id Desc');
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
  Future<List<ZakatProductsByKilosModel>> getAllZakatProductsByKilos() async {
    if (_db == null) {
      await initDB(dbdName);
    }

    final db = _db!.database;

    final result = await db.rawQuery(
        'SELECT id, productName, productPrice, productDesc, productImage, sa3Weight, hegriDate, SUM(productQuantity) as sumProductQuantity FROM zakatProducts GROUP BY productName');
    return result.map((map) => ZakatProductsByKilosModel.fromMap(map)).toList();
  }

  Future<List<PurchasesByKilosResponse>> getAllPurchasesByKilos() async {
    if (_db == null) {
      await initDB(dbdName);
    }

    final db = _db!.database;

    final result = await db.rawQuery(
        'SELECT id, productName, productPrice, SUM(productQuantity) as sumPurchasesQuantity FROM purchases GROUP BY productName');
    return result.map((map) => PurchasesByKilosModel.fromMap(map)).toList();
  }
}
