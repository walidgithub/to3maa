import 'package:equatable/equatable.dart';

class ProductsResponse extends Equatable {
  final int id;
  final String? productName;
  final String? productPrice;
  final String? productDesc;
  final String? productImage;
  final String? hijriDate;
  final double? sa3Weight;
  int? productQuantity;

  ProductsResponse({
    required this.id,
    this.productName,
    this.productPrice,
    this.hijriDate,
    this.productDesc,
    this.productImage,
    this.sa3Weight,
    this.productQuantity,
  });

  @override
  List<Object?> get props => [
        id,
        productName,
        productPrice,
    hijriDate,
        productDesc,
        productImage,
        sa3Weight,
        productQuantity
      ];
}
