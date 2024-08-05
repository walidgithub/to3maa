import 'package:dartz/dartz.dart';
import 'package:flutter_laravel/core/error/failure.dart';
import 'package:flutter_laravel/zakat/domain/repository/base_repository.dart';
import 'package:flutter_laravel/zakat/domain/use_cases/base_usecase/base_usecase.dart';

class DeleteAllZakatProductsUseCase extends BaseUsecase<int, NoParameters> {
  final BaseRepository baseRepository;

  DeleteAllZakatProductsUseCase(this.baseRepository);

  @override
  Future<Either<Failure, int>> call(NoParameters parameters) async {
    return await baseRepository.deletetAllZakatProductsData();
  }
}