import 'package:To3maa/core/local_db/db_helper.dart';
import 'package:To3maa/zakat/domain/requests/delete_product_request.dart';
import 'package:To3maa/zakat/domain/requests/delete_purchase_request.dart';
import 'package:To3maa/zakat/domain/requests/delete_sundry_request.dart';
import 'package:To3maa/zakat/domain/requests/delete_zakat_products_request.dart';
import 'package:To3maa/zakat/domain/requests/delete_zakat_request.dart';
import 'package:To3maa/zakat/domain/requests/get_zakat_products_by_zakat_id_request.dart';
import 'package:To3maa/zakat/domain/requests/insert_product_request.dart';
import 'package:To3maa/zakat/domain/requests/insert_purchase_request.dart';
import 'package:To3maa/zakat/domain/requests/insert_sundry_request.dart';
import 'package:To3maa/zakat/domain/requests/insert_zakat_products_request.dart';
import 'package:To3maa/zakat/domain/requests/insert_zakat_request.dart';
import 'package:To3maa/zakat/domain/requests/reset_product_quantity_request.dart';
import 'package:To3maa/zakat/domain/requests/update_product_quantity_request.dart';
import 'package:To3maa/zakat/domain/requests/update_product_request.dart';
import 'package:To3maa/zakat/domain/responses/products_response.dart';
import 'package:To3maa/zakat/domain/responses/purchases_response.dart';
import 'package:To3maa/zakat/domain/responses/sundries_response.dart';
import 'package:To3maa/zakat/domain/responses/zakat_products_by_kilos_response.dart';
import 'package:To3maa/zakat/domain/responses/zakat_products_response.dart';
import 'package:To3maa/zakat/domain/responses/zakat_response.dart';

abstract class BaseDataSource {
  Future<int> insertZakatData(InsertZakatRequest insertZakatRequest);
  Future<int> insertZakatProductsData(
      InsertZakatProductsRequest insertZakatProductsRequest);
  Future<int> insertProductData(InsertProductRequest insertProductRequest);
  Future<int> insertSundryData(InsertSundryRequest insertSundryRequest);
  Future<int> insertPurchaseData(InsertPurchaseRequest insertPurchaseRequest);

  Future<int> updateProductData(UpdateProductRequest updateProductRequest);
  Future<int> updateProductQuantityData(
      UpdateProductQuantityRequest updateProductQuantityRequest);
  Future<int> resetProductQuantityData(
      ResetProductQuantityRequest resetProductQuantityRequest);

  Future<int> deleteZakatData(DeleteZakatRequest deleteZakatRequest);
  Future<int> deleteAllZakatData();
  Future<int> deleteZakatProductsData(
      DeleteZakatProductsRequest deleteZakatProductsRequest);
  Future<int> deleteProductData(DeleteProductRequest deleteProductRequest);
  Future<int> deleteSundryData(DeleteSundryRequest deleteSundryRequest);
  Future<int> deletePurchaseData(DeletePurchaseRequest deletePurchaseRequest);

  Future<List<SundriesResponse>> getAllSundries();
  Future<List<PurchasesResponse>> getAllPurchases();
  Future<List<ProductsResponse>> getAllProducts();
  Future<List<ZakatResponse>> getAllZakat();
  Future<List<ZakatProductsResponse>> getZakatProductsByZatatId(
      GetZakatProductsByZatatIdRequest getZakatProductsByZatatIdRequest);
  Future<List<ZakatProductsByKilosResponse>> getAllZakatProductsByKilos();
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
  Future<int> deleteAllZakatData() async {
    final res = await _dbHelper.deleteAllZakatData().then((res) async {
      await _dbHelper.deleteAllZakatProductsData();
    });
    try {
      return res;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<int> deleteAllZakatProductsData() async {
    final res = await _dbHelper.deleteAllZakatProductsData();
    try {
      return res;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<int> deleteZakatData(DeleteZakatRequest deleteZakatRequest) async {
    final res = await _dbHelper.deleteZakatData(deleteZakatRequest);
    try {
      return res;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<int> deleteZakatProductsData(
      DeleteZakatProductsRequest deleteZakatProductsRequest) async {
    final res =
        await _dbHelper.deleteZakatProductsData(deleteZakatProductsRequest);
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
  Future<List<ZakatProductsByKilosResponse>>
      getAllZakatProductsByKilos() async {
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
  Future<int> updateProductQuantityData(
      UpdateProductQuantityRequest updateProductQuantityRequest) async {
    final res =
        await _dbHelper.updateProductQuantityData(updateProductQuantityRequest);
    try {
      return res;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<int> resetProductQuantityData(
      ResetProductQuantityRequest resetProductQuantityRequest) async {
    final res =
        await _dbHelper.resetProductQuantityData(resetProductQuantityRequest);
    try {
      return res;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<int> deletePurchaseData(DeletePurchaseRequest deletePurchaseRequest) async {
    final res =
        await _dbHelper.deletePurchaseData(deletePurchaseRequest);
    try {
      return res;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<int> deleteSundryData(DeleteSundryRequest deleteSundryRequest) async  {
    final res =
        await _dbHelper.deleteSundryData(deleteSundryRequest);
    try {
      return res;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<List<PurchasesResponse>> getAllPurchases() async  {
    final res = await _dbHelper
        .getAllPurchases();
    try {
      return res;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<List<SundriesResponse>> getAllSundries() async  {
    final res = await _dbHelper
        .getAllSundries();
    try {
      return res;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<int> insertPurchaseData(InsertPurchaseRequest insertPurchaseRequest) async  {
    final res = await _dbHelper.insertPurchaseData(insertPurchaseRequest);
    try {
      return res;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<int> insertSundryData(InsertSundryRequest insertSundryRequest) async  {
    final res = await _dbHelper.insertSundryData(insertSundryRequest);
    try {
      return res;
    } catch (e) {
      throw e.toString();
    }
  }
}
