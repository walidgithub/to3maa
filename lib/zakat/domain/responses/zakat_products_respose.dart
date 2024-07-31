import 'package:equatable/equatable.dart';

class ZakatProductsResponse extends Equatable {
  final int id;
  final String productName;
  final String productPrice;
  final String productDesc;
  final int productQuantity;
  final int zakatId;

  const ZakatProductsResponse({
    required this.id,
    required this.productName,
    required this.productPrice,
    required this.productDesc,
    required this.productQuantity,
    required this.zakatId,
  });

  @override
  List<Object?> get props =>
      [id, productName, productPrice, productDesc, productQuantity, zakatId];
}
