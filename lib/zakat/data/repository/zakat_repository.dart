import 'package:To3maa/zakat/domain/requests/delete_members_count_request.dart';
import 'package:To3maa/zakat/domain/requests/delete_purchase_request.dart';
import 'package:To3maa/zakat/domain/requests/delete_sundry_request.dart';
import 'package:To3maa/zakat/domain/requests/insert_members_count_request.dart';
import 'package:To3maa/zakat/domain/requests/insert_purchase_request.dart';
import 'package:To3maa/zakat/domain/requests/insert_sundry_request.dart';
import 'package:To3maa/zakat/domain/requests/reset_product_quantity_request.dart';
import 'package:To3maa/zakat/domain/responses/purchases_response.dart';
import 'package:To3maa/zakat/domain/responses/sundries_response.dart';
import 'package:dartz/dartz.dart';
import 'package:To3maa/core/error/error_handler.dart';
import 'package:To3maa/core/error/failure.dart';
import 'package:To3maa/zakat/data/data_source/zakat_datasource.dart';
import 'package:To3maa/zakat/domain/repository/base_repository.dart';
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

import '../../domain/responses/purchases_by_kilos_response.dart';

class ZakatRepository extends BaseRepository {
  final BaseDataSource _baseDataSource;

  ZakatRepository(
    this._baseDataSource,
  );

  @override
  Future<Either<Failure, int>> deleteProductData(
      DeleteProductRequest deleteProductRequest) async {
    try {
      final result =
          await _baseDataSource.deleteProductData(deleteProductRequest);
      return Right(result);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, int>> deleteZakatData(
      DeleteZakatRequest deleteZakatRequest) async {
    try {
      final result = await _baseDataSource.deleteZakatData(deleteZakatRequest);
      return Right(result);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, int>> deleteAllZakatData() async {
    try {
      final result = await _baseDataSource.deleteAllZakatData();
      return Right(result);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, int>> deleteZakatProductsData(
      DeleteZakatProductsRequest deleteZakatProductsRequest) async {
    try {
      final result = await _baseDataSource
          .deleteZakatProductsData(deleteZakatProductsRequest);
      return Right(result);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, List<ZakatProductsResponse>>>
      getZakatProductsByZakatId(
          GetZakatProductsByZatatIdRequest
              getZakatProductsByZatatIdRequest) async {
    try {
      final result = await _baseDataSource
          .getZakatProductsByZatatId(getZakatProductsByZatatIdRequest);

      return Right(result);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, List<ProductsResponse>>> getAllProducts() async {
    try {
      final result = await _baseDataSource.getAllProducts();
      return Right(result);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, List<ZakatResponse>>> getAllZakat() async {
    try {
      final result = await _baseDataSource.getAllZakat();
      return Right(result);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, List<ZakatProductsByKilosResponse>>>
      getAllZakatProductsByKilos() async {
    try {
      final result = await _baseDataSource.getAllZakatProductsByKilos();
      return Right(result);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, List<PurchasesByKilosResponse>>>
  getAllPurchasesByKilos() async {
    try {
      final result = await _baseDataSource.getAllPurchasesByKilos();
      return Right(result);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, int>> insertProductData(
      InsertProductRequest insertProductRequest) async {
    try {
      final result =
          await _baseDataSource.insertProductData(insertProductRequest);
      return Right(result);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, int>> insertZakatData(
      InsertZakatRequest insertZakatRequest) async {
    try {
      final result = await _baseDataSource.insertZakatData(insertZakatRequest);
      return Right(result);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, int>> insertZakatProductsData(
      InsertZakatProductsRequest insertZakatProductsRequest) async {
    try {
      final result = await _baseDataSource
          .insertZakatProductsData(insertZakatProductsRequest);
      return Right(result);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, int>> updateProductData(
      UpdateProductRequest updateProductRequest) async {
    try {
      final result =
          await _baseDataSource.updateProductData(updateProductRequest);
      return Right(result);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, int>> updateProductQuantityData(
      UpdateProductQuantityRequest updateProductQuantityRequest) async {
    try {
      final result = await _baseDataSource
          .updateProductQuantityData(updateProductQuantityRequest);
      return Right(result);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, int>> resetProductQuantityData(
      ResetProductQuantityRequest resetProductQuantityRequest) async {
    try {
      final result = await _baseDataSource
          .resetProductQuantityData(resetProductQuantityRequest);
      return Right(result);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, int>> deletePurchaseData(DeletePurchaseRequest deletePurchaseRequest) async {
    try {
      final result =
      await _baseDataSource.deletePurchaseData(deletePurchaseRequest);
      return Right(result);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, int>> deleteSundryData(DeleteSundryRequest deleteSundryRequest) async {
    try {
      final result =
      await _baseDataSource.deleteSundryData(deleteSundryRequest);
      return Right(result);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, List<PurchasesResponse>>> getAllPurchases() async {
    try {
      final result = await _baseDataSource.getAllPurchases();
      return Right(result);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, List<SundriesResponse>>> getAllSundries() async {
    try {
      final result = await _baseDataSource.getAllSundries();
      return Right(result);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, int>> insertPurchaseData(InsertPurchaseRequest insertPurchaseRequest) async {
    try {
      final result = await _baseDataSource.insertPurchaseData(insertPurchaseRequest);
      return Right(result);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, int>> insertSundryData(InsertSundryRequest insertSundryRequest) async {
    try {
      final result = await _baseDataSource.insertSundryData(insertSundryRequest);
      return Right(result);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, double>> getTotalOfPurchases() async {
    try {
      final result = await _baseDataSource.getTotalOfPurchases();
      return Right(result);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, double>> getTotalOfSundries() async {
    try {
      final result = await _baseDataSource.getTotalOfSundries();
      return Right(result);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, int>> deleteMembersCount(DeleteMembersCountRequest deleteMembersCountRequest) async {
    try {
      final result = await _baseDataSource.deleteMembersCount(deleteMembersCountRequest);
      return Right(result);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, int>> getMembersCountByProduct(String productName) async {
    try {
      final result = await _baseDataSource.getMembersCountByProduct(productName);
      return Right(result);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, int>> insertMembersCount(InsertMembersCount insertMembersCount) async {
    try {
      final result = await _baseDataSource.insertMembersCount(insertMembersCount);
      return Right(result);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, List<ZakatProductsResponse>>> getZakatProducts() async {
    try {
      final result = await _baseDataSource.getZakatProducts();
      return Right(result);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }
}
