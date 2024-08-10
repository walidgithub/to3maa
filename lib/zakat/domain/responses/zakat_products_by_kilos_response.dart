import 'package:equatable/equatable.dart';

class ZakatProductsByKilosResponse extends Equatable {
  final String productName;
  final String productPrice;
  final String productDesc;
  final String productImage;
  final double sa3Weight;
  final int? sumProductQuantity;

  const ZakatProductsByKilosResponse({
    required this.productName,
    required this.productPrice,
    required this.productDesc,
    required this.productImage,
    required this.sa3Weight,
    this.sumProductQuantity,
  });

  @override
  List<Object?> get props => [
        productName,
        productPrice,
        productDesc,
        productImage,
        sa3Weight,
        sumProductQuantity
      ];
}
