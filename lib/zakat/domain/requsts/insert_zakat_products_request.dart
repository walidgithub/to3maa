import 'package:equatable/equatable.dart';

class InsertZakatProductsRequest extends Equatable {
  final int? id;
  final String? productName;
  final String? productPrice;
  final String? productDesc;
  final String? productImage;
  final int? productQuantity;
  final int? zakatId;

  const InsertZakatProductsRequest({
    this.id,
    this.productName,
    this.productPrice,
    this.productDesc,
    this.productImage,
    this.productQuantity,
    this.zakatId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["productName"] = productName;
    data["productPrice"] = productPrice;
    data["productDesc"] = productDesc;
    data["productImage"] = productImage;
    data["productQuantity"] = productQuantity;
    data["zakatId"] = zakatId;
    return data;
  }

  @override
  List<Object?> get props =>
      [id, productName, productPrice, productDesc, productQuantity, zakatId];
}
