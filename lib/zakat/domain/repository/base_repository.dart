import 'package:To3maa/zakat/domain/models/sundries_model.dart';
import 'package:To3maa/zakat/domain/requests/delete_purchase_request.dart';
import 'package:To3maa/zakat/domain/requests/delete_sundry_request.dart';
import 'package:To3maa/zakat/domain/requests/insert_purchase_request.dart';
import 'package:To3maa/zakat/domain/requests/insert_sundry_request.dart';
import 'package:To3maa/zakat/domain/requests/reset_product_quantity_request.dart';
import 'package:To3maa/zakat/domain/responses/purchases_response.dart';
import 'package:To3maa/zakat/domain/responses/sundries_response.dart';
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
import 'package:To3maa/zakat/domain/responses/products_response.dart';
import 'package:To3maa/zakat/domain/responses/zakat_products_by_kilos_response.dart';
import 'package:To3maa/zakat/domain/responses/zakat_products_response.dart';
import 'package:To3maa/zakat/domain/responses/zakat_response.dart';

abstract class BaseRepository {
  Future<Either<Failure, int>> insertZakatData(
      InsertZakatRequest insertZakatRequest);
  Future<Either<Failure, int>> insertZakatProductsData(
      InsertZakatProductsRequest insertZakatProductsRequest);
  Future<Either<Failure, int>> insertProductData(
      InsertProductRequest insertProductRequest);
  Future<Either<Failure, int>> insertSundryData(
      InsertSundryRequest insertSundryRequest);
  Future<Either<Failure, int>> insertPurchaseData(
      InsertPurchaseRequest insertPurchaseRequest);

  Future<Either<Failure, int>> updateProductData(
      UpdateProductRequest updateProductRequest);
  Future<Either<Failure, int>> updateProductQuantityData(
      UpdateProductQuantityRequest updateProductQuantityRequest);
  Future<Either<Failure, int>> resetProductQuantityData(
      ResetProductQuantityRequest resetProductQuantityRequest);

  Future<Either<Failure, int>> deleteZakatData(
      DeleteZakatRequest deleteZakatRequest);
  Future<Either<Failure, int>> deleteAllZakatData();
  Future<Either<Failure, int>> deleteZakatProductsData(
      DeleteZakatProductsRequest deleteZakatProductsRequest);
  Future<Either<Failure, int>> deleteProductData(
      DeleteProductRequest deleteProductRequest);
  Future<Either<Failure, int>> deleteSundryData(
      DeleteSundryRequest deleteSundryRequest);
  Future<Either<Failure, int>> deletePurchaseData(
      DeletePurchaseRequest deletePurchaseRequest);

  Future<Either<Failure, List<SundriesResponse>>> getAllSundries();
  Future<Either<Failure, List<PurchasesResponse>>> getAllPurchases();
  Future<Either<Failure, List<ProductsResponse>>> getAllProducts();
  Future<Either<Failure, List<ZakatResponse>>> getAllZakat();
  Future<Either<Failure, List<ZakatProductsResponse>>>
      getZakatProductsByZakatId(
          GetZakatProductsByZatatIdRequest getZakatProductsByZatatIdRequest);
  Future<Either<Failure, List<ZakatProductsByKilosResponse>>>
      getAllZakatProductsByKilos();
}
