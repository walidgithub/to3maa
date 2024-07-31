import 'package:equatable/equatable.dart';

class ProductsResponse extends Equatable {
  final int id;
  final String productName;
  final String productPrice;
  final String productDesc;

  const ProductsResponse({
    required this.id,
    required this.productName,
    required this.productPrice,
    required this.productDesc,
  });

  @override
  List<Object?> get props => [id, productName, productPrice, productDesc];
}
