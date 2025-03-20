import 'package:To3maa/zakat/domain/responses/zakat_products_by_kilos_response.dart';

class ZakatProductsByKilosModel extends ZakatProductsByKilosResponse {
  const ZakatProductsByKilosModel({
    required super.productName,
    required super.productPrice,
    required super.productDesc,
    required super.sa3Weight,
    required super.productImage,
    required super.hegriDate,
    super.sumProductQuantity,
  });

  factory ZakatProductsByKilosModel.fromMap(Map<String, dynamic> map) {
    return ZakatProductsByKilosModel(
      productName: map['productName'],
      productPrice: map['productPrice'],
      productDesc: map['productDesc'],
      sa3Weight: map['sa3Weight'],
      productImage: map['productImage'],
      hegriDate: map['hegriDate'],
      sumProductQuantity: map['sumProductQuantity'],
    );
  }
}
