import 'package:dartz/dartz.dart';
import 'package:flutter_laravel/core/error/failure.dart';
import 'package:flutter_laravel/zakat/data/repository/zakat_repository.dart';
import 'package:flutter_laravel/zakat/domain/repository/base_repository.dart';
import 'package:flutter_laravel/zakat/domain/responses/products_respose.dart';
import 'package:flutter_laravel/zakat/domain/responses/zakat_respose.dart';
import 'package:flutter_laravel/zakat/domain/use_cases/base_usecase/base_usecase.dart';

class GetAllZakatUseCase extends BaseUsecase<List<ZakatResponse>, NoParameters> {
  final BaseRepository baseRepository;

  GetAllZakatUseCase(this.baseRepository);

  @override
  Future<Either<Failure, List<ZakatResponse>>> call(NoParameters parameters) async {
    return await baseRepository.getAllZakat();
  }
}