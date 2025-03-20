import 'package:To3maa/zakat/domain/requests/reset_product_quantity_request.dart';
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
import 'package:To3maa/zakat/domain/responses/products_respose.dart';
import 'package:To3maa/zakat/domain/responses/zakat_products_by_kilos_response.dart';
import 'package:To3maa/zakat/domain/responses/zakat_products_respose.dart';
import 'package:To3maa/zakat/domain/responses/zakat_respose.dart';

class ZakatRepository extends BaseRepository {
  final BaseDataSource _baseDataSource;

  ZakatRepository(
    this._baseDataSource,
  );

  @override
  Future<Either<Failure, int>> deletetProductData(
      DeleteProductRequest deletetProductRequest) async {
    try {
      final result =
          await _baseDataSource.deleteProductData(deletetProductRequest);
      return Right(result);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, int>> deletetZakatData(
      DeleteZakatRequest deletetZakatRequest) async {
    try {
      final result = await _baseDataSource.deleteZakatData(deletetZakatRequest);
      return Right(result);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, int>> deletetAllZakatData() async {
    try {
      final result = await _baseDataSource.deleteAllZakatData();
      return Right(result);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, int>> deletetZakatProductsData(
      DeleteZakatProductsRequest deletetZakatProductsRequest) async {
    try {
      final result = await _baseDataSource
          .deleteZakatProductsData(deletetZakatProductsRequest);
      return Right(result);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, int>> deletetAllZakatProductsData() async {
    try {
      final result = await _baseDataSource.deleteAllZakatProductsData();
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
}
