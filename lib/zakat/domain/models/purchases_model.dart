import 'package:To3maa/zakat/domain/responses/purchases_response.dart';

class PurchasesModel extends PurchasesResponse{
  PurchasesModel({
    required super.id,
    required super.productName,
    required super.productPrice,
    required super.productDesc,
    required super.productImage,
    required super.productQuantity,
  });

  factory PurchasesModel.fromMap(Map<String, dynamic> map) {
    return PurchasesModel(
      id: map['id'],
      productName: map['productName'],
      productPrice: map['productPrice'],
      productDesc: map['productDesc'],
      productImage: map['productImage'],
      productQuantity: map['productQuantity'],
    );
  }
}