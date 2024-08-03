import 'package:flutter_laravel/core/local_db/db_helper.dart';
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
import 'package:flutter_laravel/zakat/domain/responses/products_respose.dart';
import 'package:flutter_laravel/zakat/domain/responses/zakat_products_respose.dart';
import 'package:flutter_laravel/zakat/domain/responses/zakat_respose.dart';

abstract class BaseDataSource {
  Future<int> insertZakatData(InsertZakatRequest insertZakatRequest);
  Future<int> insertZakatProductsData(
      InsertZakatProductsRequest insertZakatProductsRequest);
  Future<int> insertProductData(InsertProductRequest insertProductRequest);

  Future<int> updateZakatData(UpdateZakatRequest updateZakatRequest);
  Future<int> updateZakatProductsData(
      UpdateZakatProductsRequest updateZakatProductsRequest);
  Future<int> updateProductData(UpdateProductRequest updateProductRequest);

  Future<int> deleteZakatData(DeleteZakatRequest deletetZakatRequest);
  Future<int> deleteZakatProductsData(
      DeleteZakatProductsRequest deletetZakatProductsRequest);
  Future<int> deleteProductData(DeleteProductRequest deletetProductRequest);

  Future<List<ProductsResponse>> getAllProducts();
  Future<List<ZakatResponse>> getAllZakat();
  Future<List<ZakatProductsResponse>> getZakatProductsByZatatId(
      GetZakatProductsByZatatIdRequest getZakatProductsByZatatIdRequest);
  Future<List<ZakatProductsResponse>> getAllZakatProductsByKilos();
}

class ZakatDataSource extends BaseDataSource {
  final DbHelper _dbHelper;

  ZakatDataSource(this._dbHelper) {
    _dbHelper.database;
  }

  @override
  Future<int> deleteProductData(
      DeleteProductRequest deletetProductRequest) async {
    final res = await _dbHelper.deleteProductData(deletetProductRequest);
    try {
      return res;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<int> deleteZakatData(DeleteZakatRequest deletetZakatRequest) async {
    final res = await _dbHelper.deleteZakatData(deletetZakatRequest);
    try {
      return res;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<int> deleteZakatProductsData(
      DeleteZakatProductsRequest deletetZakatProductsRequest) async {
    final res =
        await _dbHelper.deleteZakatProductsData(deletetZakatProductsRequest);
    try {
      return res;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<List<ProductsResponse>> getAllProducts() async {
    final res = await _dbHelper.getAllProducts();
    try {
      return res;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<List<ZakatResponse>> getAllZakat() async {
    final res = await _dbHelper.getAllZakat();
    try {
      return res;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<List<ZakatProductsResponse>> getAllZakatProductsByKilos() async {
    final res = await _dbHelper.getAllZakatProductsByKilos();
    try {
      return res;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<List<ZakatProductsResponse>> getZakatProductsByZatatId(
      GetZakatProductsByZatatIdRequest getZakatProductsByZatatIdRequest) async {
    final res = await _dbHelper
        .getZakatProductsByZatatId(getZakatProductsByZatatIdRequest);
    try {
      return res;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<int> insertProductData(
      InsertProductRequest insertProductRequest) async {
    final res = await _dbHelper.insertProductData(insertProductRequest);
    try {
      return res;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<int> insertZakatData(InsertZakatRequest insertZakatRequest) async {
    final res = await _dbHelper.insertZakatData(insertZakatRequest);
    try {
      return res;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<int> insertZakatProductsData(
      InsertZakatProductsRequest insertZakatProductsRequest) async {
    final res =
        await _dbHelper.insertZakatProductsData(insertZakatProductsRequest);
    try {
      return res;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<int> updateProductData(
      UpdateProductRequest updateProductRequest) async {
    final res = await _dbHelper.updateProductData(updateProductRequest);
    try {
      return res;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<int> updateZakatData(UpdateZakatRequest updateZakatRequest) async {
    final res = await _dbHelper.updateZakatData(updateZakatRequest);
    try {
      return res;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<int> updateZakatProductsData(
      UpdateZakatProductsRequest updateZakatProductsRequest) async {
    final res =
        await _dbHelper.updateZakatProductsData(updateZakatProductsRequest);
    try {
      return res;
    } catch (e) {
      throw e.toString();
    }
  }
}
