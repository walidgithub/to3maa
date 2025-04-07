import 'package:dartz/dartz.dart';
import 'package:To3maa/core/error/failure.dart';
import 'package:To3maa/zakat/domain/repository/base_repository.dart';
import 'package:To3maa/zakat/domain/use_cases/base_usecase/base_usecase.dart';

class GetTotalOfSundriesUseCase extends BaseUsecase<double, NoParameters> {
  final BaseRepository baseRepository;

  GetTotalOfSundriesUseCase(this.baseRepository);

  @override
  Future<Either<Failure, double>> call(NoParameters parameters) async {
    return await baseRepository.getTotalOfSundries();
  }
}
