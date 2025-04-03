import 'package:equatable/equatable.dart';

class DeleteSundryRequest extends Equatable {
  final int id;

  const DeleteSundryRequest({
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