import 'package:equatable/equatable.dart';

class UpdateProductQuantityRequest extends Equatable {
  final int? id;
  final int? productQuantity;

  const UpdateProductQuantityRequest({
    this.id,
    this.productQuantity,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["productQuantity"] = productQuantity;
    return data;
  }

  @override
  List<Object?> get props => [id, productQuantity];
}