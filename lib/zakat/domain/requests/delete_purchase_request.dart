import 'package:equatable/equatable.dart';

class DeletePurchaseRequest extends Equatable {
  final int id;

  const DeletePurchaseRequest({
    required this.id,
  });


  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }

  @override
  List<Object?> get props => [id];
}