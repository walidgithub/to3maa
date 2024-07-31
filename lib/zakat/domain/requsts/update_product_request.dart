import 'package:equatable/equatable.dart';

class UpdateProductRequest extends Equatable {
  final int id;
  final String productName;
  final String productPrice;
  final String productDesc;

  const UpdateProductRequest({
    required this.id,
    required this.productName,
    required this.productPrice,
    required this.productDesc,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["productName"] = productName;
    data["productPrice"] = productPrice;
    data["productDesc"] = productDesc;
    return data;
  }

  @override
  List<Object?> get props => [id, productName, productPrice, productDesc];
}
