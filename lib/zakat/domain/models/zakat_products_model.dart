import 'package:To3maa/zakat/domain/responses/zakat_products_respose.dart';

class ZakatProductsModel extends ZakatProductsResponse {
  const ZakatProductsModel({
    super.id,
    required super.productName,
    required super.productPrice,
    required super.productDesc,
    required super.sa3Weight,
    required super.productImage,
    required super.hegriDate,
    super.productQuantity,
    super.zakatId,
  });

  factory ZakatProductsModel.fromMap(Map<String, dynamic> map) {
    return ZakatProductsModel(
      id: map['id'],
      productName: map['productName'],
      productPrice: map['productPrice'],
      productDesc: map['productDesc'],
      productImage: map['productImage'],
      hegriDate: map['hegriDate'],
      sa3Weight: map['sa3Weight'],
      productQuantity: map['productQuantity'],
      zakatId: map['zakatId'],
    );
  }
}
