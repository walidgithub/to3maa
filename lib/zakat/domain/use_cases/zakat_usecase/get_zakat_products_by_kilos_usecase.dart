import 'package:dartz/dartz.dart';
import 'package:flutter_laravel/core/error/failure.dart';
import 'package:flutter_laravel/zakat/domain/repository/base_repository.dart';
import 'package:flutter_laravel/zakat/domain/responses/zakat_products_respose.dart';
import 'package:flutter_laravel/zakat/domain/use_cases/base_usecase/base_usecase.dart';

class GetZakatProductsByKilosUseCase extends BaseUsecase<List<ZakatProductsResponse>, NoParameters> {
  final BaseRepository baseRepository;

  GetZakatProductsByKilosUseCase(this.baseRepository);

  @override
  Future<Either<Failure, List<ZakatProductsResponse>>> call(NoParameters parameters) async {
    return await baseRepository.getAllZakatProductsByKilos();
  }
}