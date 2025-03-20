import 'package:equatable/equatable.dart';

class ZakatProductsResponse extends Equatable {
  final int? id;
  final String productName;
  final String productPrice;
  final String productDesc;
  final String productImage;
  final String hegriDate;
  final double sa3Weight;
  final int? productQuantity;
  final int? zakatId;

  const ZakatProductsResponse({
    this.id,
    required this.productName,
    required this.productPrice,
    required this.productDesc,
    required this.productImage,
    required this.sa3Weight,
    required this.hegriDate,
    this.productQuantity,
    this.zakatId,
  });

  @override
  List<Object?> get props =>
      [id, productName, productPrice, productDesc, productImage, sa3Weight, productQuantity, zakatId, hegriDate];
}
