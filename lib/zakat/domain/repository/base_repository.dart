import 'package:dartz/dartz.dart';
import 'package:flutter_laravel/core/error/failure.dart';
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
import 'package:flutter_laravel/zakat/domain/responses/zakat_products_by_kilos_response.dart';
import 'package:flutter_laravel/zakat/domain/responses/zakat_products_respose.dart';
import 'package:flutter_laravel/zakat/domain/responses/zakat_respose.dart';

abstract class BaseRepository {
  Future<Either<Failure, int>> insertZakatData(
      InsertZakatRequest insertZakatRequest);
  Future<Either<Failure, int>> insertZakatProductsData(
      InsertZakatProductsRequest insertZakatProductsRequest);
  Future<Either<Failure, int>> insertProductData(
      InsertProductRequest insertProductRequest);

  Future<Either<Failure, int>> updateZakatData(
      UpdateZakatRequest updateZakatRequest);
  Future<Either<Failure, int>> updateZakatProductsData(
      UpdateZakatProductsRequest updateZakatProductsRequest);
  Future<Either<Failure, int>> updateProductData(
      UpdateProductRequest updateProductRequest);

  Future<Either<Failure, int>> deletetZakatData(
      DeleteZakatRequest deletetZakatRequest);
  Future<Either<Failure, int>> deletetZakatProductsData(
      DeleteZakatProductsRequest deletetZakatProductsRequest);
  Future<Either<Failure, int>> deletetProductData(
      DeleteProductRequest deletetProductRequest);

  Future<Either<Failure, List<ProductsResponse>>> getAllProducts();
  Future<Either<Failure, List<ZakatResponse>>> getAllZakat();
  Future<Either<Failure, List<ZakatProductsResponse>>>
      getZakatProductsByZakatId(
          GetZakatProductsByZatatIdRequest getZakatProductsByZatatIdRequest);
  Future<Either<Failure, List<ZakatProductsByKilosResponse>>>
      getAllZakatProductsByKilos();
}
