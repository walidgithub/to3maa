import 'package:equatable/equatable.dart';

class ZakatProductsByKilosResponse extends Equatable {
  final int id;
  final String productName;
  final String productPrice;
  final String productDesc;
  final String productImage;
  final String hegriDate;
  final double sa3Weight;
  final int? sumProductQuantity;

  const ZakatProductsByKilosResponse({
    required this.id,
    required this.productName,
    required this.productPrice,
    required this.productDesc,
    required this.productImage,
    required this.sa3Weight,
    required this.hegriDate,
    this.sumProductQuantity,
  });

  @override
  List<Object?> get props => [
    id,
        productName,
        productPrice,
        productDesc,
        productImage,
        sa3Weight,
    hegriDate,
        sumProductQuantity
      ];
}
