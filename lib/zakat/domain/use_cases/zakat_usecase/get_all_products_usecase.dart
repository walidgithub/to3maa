import 'package:dartz/dartz.dart';
import 'package:flutter_laravel/core/error/failure.dart';
import 'package:flutter_laravel/zakat/domain/repository/base_repository.dart';
import 'package:flutter_laravel/zakat/domain/responses/products_respose.dart';
import 'package:flutter_laravel/zakat/domain/use_cases/base_usecase/base_usecase.dart';

class GetAllProductsUseCase extends BaseUsecase<List<ProductsResponse>, NoParameters> {
  final BaseRepository baseRepository;

  GetAllProductsUseCase(this.baseRepository);

  @override
  Future<Either<Failure, List<ProductsResponse>>> call(NoParameters parameters) async {
    return await baseRepository.getAllProducts();
  }
}