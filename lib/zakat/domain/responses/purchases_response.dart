import 'package:equatable/equatable.dart';

class PurchasesResponse extends Equatable {
  final int id;
  final String? productName;
  final String? productPrice;
  final String? productDesc;
  final String? productImage;
  int? productQuantity;

  PurchasesResponse({
    required this.id,
    this.productName,
    this.productPrice,
    this.productDesc,
    this.productImage,
    this.productQuantity,
  });

  @override
  List<Object?> get props => [
        id,
        productName,
        productPrice,
        productDesc,
        productImage,
        productQuantity
      ];
}
