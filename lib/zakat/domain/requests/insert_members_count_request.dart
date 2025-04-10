import 'package:equatable/equatable.dart';

class InsertMembersCount extends Equatable {
  final int? id;
  final int? zakatId;
  final int? membersCount;
  final String? productName;

  const InsertMembersCount({
    this.id,
    this.zakatId,
    this.membersCount,
    this.productName,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["zakatId"] = zakatId;
    data["membersCount"] = membersCount;
    data["productName"] = productName;
    return data;
  }

  @override
  List<Object?> get props =>
      [id, zakatId, membersCount, productName];
}