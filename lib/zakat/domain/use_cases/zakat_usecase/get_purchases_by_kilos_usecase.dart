import 'package:dartz/dartz.dart';
import 'package:To3maa/core/error/failure.dart';
import 'package:To3maa/zakat/domain/repository/base_repository.dart';
import 'package:To3maa/zakat/domain/use_cases/base_usecase/base_usecase.dart';

import '../../responses/purchases_by_kilos_response.dart';

class GetPurchasesByKilosUseCase
    extends BaseUsecase<List<PurchasesByKilosResponse>, NoParameters> {
  final BaseRepository baseRepository;

  GetPurchasesByKilosUseCase(this.baseRepository);

  @override
  Future<Either<Failure, List<PurchasesByKilosResponse>>> call(
      NoParameters parameters) async {
    return await baseRepository.getAllPurchasesByKilos();
  }
}
