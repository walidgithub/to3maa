import 'package:dartz/dartz.dart';
import 'package:To3maa/core/error/failure.dart';
import 'package:To3maa/zakat/domain/repository/base_repository.dart';
import 'package:To3maa/zakat/domain/use_cases/base_usecase/base_usecase.dart';

class UpdateProductQuantityUseCase extends BaseUsecase {
  final BaseRepository baseRepository;

  UpdateProductQuantityUseCase(this.baseRepository);

  @override
  Future<Either<Failure, int>> call(parameters) async {
    return await baseRepository.updateProductQuantityData(parameters);
  }
}