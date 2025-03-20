import 'package:equatable/equatable.dart';

class InsertZakatProductsRequest extends Equatable {
  final int? id;
  final String? productName;
  final String? productPrice;
  final String? productDesc;
  final String? productImage;
  final String? hegriDate;
  final double? sa3Weight;
  final int? productQuantity;
  final int? zakatId;

  const InsertZakatProductsRequest({
    this.id,
    this.productName,
    this.productPrice,
    this.productDesc,
    this.productImage,
    this.sa3Weight,
    this.productQuantity,
    this.zakatId,
    this.hegriDate,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["productName"] = productName;
    data["productPrice"] = productPrice;
    data["productDesc"] = productDesc;
    data["productImage"] = productImage;
    data["sa3Weight"] = sa3Weight;
    data["productQuantity"] = productQuantity;
    data["zakatId"] = zakatId;
    data["hegriDate"] = hegriDate;
    return data;
  }

  @override
  List<Object?> get props =>
      [id, productName, productPrice, productDesc, productImage, sa3Weight, productQuantity, zakatId, hegriDate];
}
