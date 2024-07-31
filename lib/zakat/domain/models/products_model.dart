import 'package:flutter_laravel/zakat/domain/responses/products_respose.dart';

class ProductsModel extends ProductsResponse {
  const ProductsModel({
    required super.id,
    required super.productName,
    required super.productPrice,
    required super.productDesc,
    required super.productImage,
  });

  factory ProductsModel.fromMap(Map<String, dynamic> map) {
    return ProductsModel(
      id: map['id'],
      productName: map['productName'],
      productPrice: map['productPrice'],
      productDesc: map['productDesc'],
      productImage: map['productImage'],
    );
  }
}
