import 'package:equatable/equatable.dart';

class DeleteMembersCountRequest extends Equatable {
  final int id;

  const DeleteMembersCountRequest({
    required this.id,
  });


  Map<String, dynamic> toJson() {
    return {
      'zakatId': id,
    };
  }

  @override
  List<Object?> get props => [id];
}