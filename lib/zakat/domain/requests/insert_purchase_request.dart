import 'package:equatable/equatable.dart';

class InsertPurchaseRequest extends Equatable {
  final int? id;
  final String? productName;
  final String? productPrice;
  final String? productImage;
  final int? productQuantity;

  const InsertPurchaseRequest({
    this.id,
    this.productName,
    this.productPrice,
    this.productImage,
    this.productQuantity,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["productName"] = productName;
    data["productPrice"] = productPrice;
    data["productImage"] = productImage;
    data["productQuantity"] = productQuantity;
    return data;
  }

  @override
  List<Object?> get props =>
      [id, productName, productPrice, productImage, productQuantity];
}