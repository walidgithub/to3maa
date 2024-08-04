

import 'package:flutter_laravel/zakat/domain/responses/zakat_products_by_kilos_response.dart';

class ZakatProductsByKilosModel extends ZakatProductsByKilosResponse {
  const ZakatProductsByKilosModel({
    required super.productName,
    required super.productPrice,
    required super.productDesc,
    required super.productImage,
    super.sumProductQuantity,
  });

  factory ZakatProductsByKilosModel.fromMap(Map<String, dynamic> map) {
    return ZakatProductsByKilosModel(
      productName: map['productName'],
      productPrice: map['productPrice'],
      productDesc: map['productDesc'],
      productImage: map['productImage'],
      sumProductQuantity: map['sumProductQuantity'],
    );
  }
}
