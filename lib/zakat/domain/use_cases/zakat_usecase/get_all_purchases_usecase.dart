import 'package:To3maa/zakat/domain/responses/purchases_response.dart';
import 'package:To3maa/zakat/domain/responses/sundries_response.dart';
import 'package:dartz/dartz.dart';
import 'package:To3maa/core/error/failure.dart';
import 'package:To3maa/zakat/domain/repository/base_repository.dart';
import 'package:To3maa/zakat/domain/use_cases/base_usecase/base_usecase.dart';

class GetAllPurchasesUseCase
    extends BaseUsecase<List<PurchasesResponse>, NoParameters> {
  final BaseRepository baseRepository;

  GetAllPurchasesUseCase(this.baseRepository);

  @override
  Future<Either<Failure, List<PurchasesResponse>>> call(
      NoParameters parameters) async {
    return await baseRepository.getAllPurchases();
  }
}
