import 'package:equatable/equatable.dart';

class InsertProductRequest extends Equatable {
  final int? id;
  final String? productName;
  final String? productPrice;
  final String? productDesc;
  final String? productImage;
  final int? productQuantity;

  const InsertProductRequest({
    this.id,
    this.productName,
    this.productPrice,
    this.productDesc,
    this.productImage,
    this.productQuantity,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["productName"] = productName;
    data["productPrice"] = productPrice;
    data["productDesc"] = productDesc;
    data["productImage"] = productImage;
    data["productQuantity"] = productQuantity;
    return data;
  }

  @override
  List<Object?> get props =>
      [id, productName, productPrice, productDesc, productImage];
}
