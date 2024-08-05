import 'package:dartz/dartz.dart';
import 'package:to3maa/core/error/failure.dart';
import 'package:to3maa/zakat/domain/repository/base_repository.dart';
import 'package:to3maa/zakat/domain/use_cases/base_usecase/base_usecase.dart';

class DeleteAllZakatUseCase extends BaseUsecase<int, NoParameters> {
  final BaseRepository baseRepository;

  DeleteAllZakatUseCase(this.baseRepository);

  @override
  Future<Either<Failure, int>> call(NoParameters parameters) async {
    return await baseRepository.deletetAllZakatData();
  }
}
