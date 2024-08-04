import 'package:equatable/equatable.dart';

class ZakatProductsByKilosResponse extends Equatable {
  final String productName;
  final String productPrice;
  final String productDesc;
  final String productImage;
  final int? sumProductQuantity;

  const ZakatProductsByKilosResponse({
    required this.productName,
    required this.productPrice,
    required this.productDesc,
    required this.productImage,
    this.sumProductQuantity,
  });

  @override
  List<Object?> get props =>
      [productName, productPrice, productDesc, productImage, sumProductQuantity];
}