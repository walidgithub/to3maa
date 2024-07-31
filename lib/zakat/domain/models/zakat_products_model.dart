import 'package:flutter_laravel/zakat/domain/responses/zakat_products_respose.dart';

class ZakatProductsModel extends ZakatProductsResponse {
  const ZakatProductsModel({
    required super.id,
    required super.productName,
    required super.productPrice,
    required super.productDesc,
    required super.productImage,
    required super.productQuantity,
    required super.zakatId,
  });

  factory ZakatProductsModel.fromMap(Map<String, dynamic> map) {
    return ZakatProductsModel(
      id: map['id'],
      productName: map['productName'],
      productPrice: map['productPrice'],
      productDesc: map['productDesc'],
      productImage: map['productImage'],
      productQuantity: map['productQuantity'],
      zakatId: map['zakatId'],
    );
  }
}
