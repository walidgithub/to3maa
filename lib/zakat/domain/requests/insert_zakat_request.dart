import 'package:equatable/equatable.dart';

class InsertZakatRequest extends Equatable {
  final int? id;
  final String? membersCount;
  final String? zakatValue;
  final String? remainValue;
  final String? hegriDate;

  const InsertZakatRequest({
    this.id,
    this.membersCount,
    this.zakatValue,
    this.remainValue,
    this.hegriDate,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["membersCount"] = membersCount;
    data["zakatValue"] = zakatValue;
    data["remainValue"] = remainValue;
    data["hegriDate"] = hegriDate;
    return data;
  }

  @override
  List<Object?> get props => [id, membersCount, zakatValue, remainValue, hegriDate];
}
