import 'package:equatable/equatable.dart';

class UpdateProductRequest extends Equatable {
  final int? id;
  final String? productName;
  final String? productPrice;
  final String? productDesc;
  final String? productImage;

  const UpdateProductRequest({
    this.id,
    this.productName,
    this.productPrice,
    this.productDesc,
    this.productImage,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["productName"] = productName;
    data["productPrice"] = productPrice;
    data["productDesc"] = productDesc;
    data["productImage"] = productImage;
    return data;
  }

  @override
  List<Object?> get props => [id, productName, productPrice, productDesc];
}