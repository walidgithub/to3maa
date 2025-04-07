import 'package:To3maa/zakat/domain/responses/purchases_by_kilos_response.dart';

class PurchasesByKilosModel extends PurchasesByKilosResponse {
  const PurchasesByKilosModel({
    required super.id,
    required super.productName,
    required super.productPrice,
    super.sumPurchasesQuantity,
  });

  factory PurchasesByKilosModel.fromMap(Map<String, dynamic> map) {
    return PurchasesByKilosModel(
      id: map['id'] ?? 0,
      productName: map['productName'] ?? '',
      productPrice: map['productPrice'] ?? '',
      sumPurchasesQuantity: map['sumPurchasesQuantity'] ?? 0,
    );
  }
}
