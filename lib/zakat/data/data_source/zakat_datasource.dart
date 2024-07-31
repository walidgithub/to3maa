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

abstract class ZakatDataSource {
  Future<int> insertZakatData(InsertZakatRequest insertZakatRequest);
  Future<int> insertZakatProductsData(
      InsertZakatProductsRequest insertZakatProductsRequest);
  Future<int> insertProductData(InsertProductRequest insertProductRequest);

  Future<int> updateZakatData(UpdateZakatRequest updateZakatRequest);
  Future<int> updateZakatProductsData(
      UpdateZakatProductsRequest updateZakatProductsRequest);
  Future<int> updateProductData(UpdateProductRequest updateProductRequest);

  Future<int> deletetZakatData(DeleteZakatRequest deletetZakatRequest);
  Future<int> deletetZakatProductsData(
      DeleteZakatProductsRequest deletetZakatProductsRequest);
  Future<int> deletetProductData(DeleteProductRequest deletetProductRequest);

  Future<List<ProductsResponse>> getAllProducts();
  Future<List<ZakatResponse>> getAllZakat();
  Future<List<ZakatProductsResponse>> getZakatProductsByZakatId(
      GetZakatProductsByZatatIdRequest getZakatProductsByZatatIdRequest);
  Future<List<ZakatProductsResponse>> getAllZakatProductsByKilos();
}
