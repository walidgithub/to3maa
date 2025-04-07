import 'package:equatable/equatable.dart';

class PurchasesByKilosResponse extends Equatable {
  final int id;
  final String productName;
  final String productPrice;
  final int? sumPurchasesQuantity;

  const PurchasesByKilosResponse({
    required this.id,
    required this.productName,
    required this.productPrice,
    this.sumPurchasesQuantity,
  });

  @override
  List<Object?> get props => [
    id,
        productName,
        productPrice,
    sumPurchasesQuantity
      ];
}
