import 'package:equatable/equatable.dart';

class ResetProductQuantityRequest extends Equatable {
  final int? productQuantity;

  const ResetProductQuantityRequest({
    this.productQuantity,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["productQuantity"] = productQuantity;
    return data;
  }

  @override
  List<Object?> get props => [productQuantity];
}