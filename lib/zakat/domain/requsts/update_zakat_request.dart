import 'package:equatable/equatable.dart';

class UpdateZakatRequest extends Equatable {
  final int id;
  final String membersCount;
  final int zakatValue;
  final int remainValue;

  const UpdateZakatRequest({
    required this.id,
    required this.membersCount,
    required this.zakatValue,
    required this.remainValue,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["membersCount"] = membersCount;
    data["zakatValue"] = zakatValue;
    data["remainValue"] = remainValue;
    return data;
  }

  @override
  List<Object?> get props => [id, membersCount, zakatValue, remainValue];
}
