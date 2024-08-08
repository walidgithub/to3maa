import 'package:To3maa/zakat/domain/responses/products_respose.dart';

class ProductsModel extends ProductsResponse {
  ProductsModel({
    required super.id,
    required super.productName,
    required super.productPrice,
    required super.productDesc,
    required super.productImage,
    required super.productQuantity,
    required super.sa3Weight,
  });

  factory ProductsModel.fromMap(Map<String, dynamic> map) {
    return ProductsModel(
      id: map['id'],
      productName: map['productName'],
      productPrice: map['productPrice'],
      productDesc: map['productDesc'],
      productImage: map['productImage'],
      productQuantity: map['productQuantity'],
      sa3Weight: map['sa3Weight'],
    );
  }
}
