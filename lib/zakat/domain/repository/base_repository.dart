import 'package:To3maa/zakat/domain/requests/reset_product_quantity_request.dart';
import 'package:dartz/dartz.dart';
import 'package:To3maa/core/error/failure.dart';
import 'package:To3maa/zakat/domain/requests/delete_product_request.dart';
import 'package:To3maa/zakat/domain/requests/delete_zakat_products_request.dart';
import 'package:To3maa/zakat/domain/requests/delete_zakat_request.dart';
import 'package:To3maa/zakat/domain/requests/get_zakat_products_by_zakat_id_request.dart';
import 'package:To3maa/zakat/domain/requests/insert_product_request.dart';
import 'package:To3maa/zakat/domain/requests/insert_zakat_products_request.dart';
import 'package:To3maa/zakat/domain/requests/insert_zakat_request.dart';
import 'package:To3maa/zakat/domain/requests/update_product_quantity_request.dart';
import 'package:To3maa/zakat/domain/requests/update_product_request.dart';
import 'package:To3maa/zakat/domain/responses/products_respose.dart';
import 'package:To3maa/zakat/domain/responses/zakat_products_by_kilos_response.dart';
import 'package:To3maa/zakat/domain/responses/zakat_products_respose.dart';
import 'package:To3maa/zakat/domain/responses/zakat_respose.dart';

abstract class BaseRepository {
  Future<Either<Failure, int>> insertZakatData(
      InsertZakatRequest insertZakatRequest);
  Future<Either<Failure, int>> insertZakatProductsData(
      InsertZakatProductsRequest insertZakatProductsRequest);
  Future<Either<Failure, int>> insertProductData(
      InsertProductRequest insertProductRequest);

  Future<Either<Failure, int>> updateProductData(
      UpdateProductRequest updateProductRequest);
  Future<Either<Failure, int>> updateProductQuantityData(
      UpdateProductQuantityRequest updateProductQuantityRequest);
  Future<Either<Failure, int>> resetProductQuantityData(
      ResetProductQuantityRequest resetProductQuantityRequest);

  Future<Either<Failure, int>> deletetZakatData(
      DeleteZakatRequest deletetZakatRequest);
  Future<Either<Failure, int>> deletetAllZakatData();
  Future<Either<Failure, int>> deletetZakatProductsData(
      DeleteZakatProductsRequest deletetZakatProductsRequest);
  Future<Either<Failure, int>> deletetAllZakatProductsData();
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
