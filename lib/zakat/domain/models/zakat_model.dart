import 'package:To3maa/zakat/domain/responses/zakat_respose.dart';

class ZakatModel extends ZakatResponse {
  const ZakatModel({
    required super.id,
    required super.membersCount,
    required super.zakatValue,
    required super.remainValue,
    required super.hegriDate,
  });

  factory ZakatModel.fromMap(Map<String, dynamic> map) {
    return ZakatModel(
      id: map['id'],
      membersCount: map['membersCount'],
      zakatValue: map['zakatValue'],
      remainValue: map['remainValue'],
      hegriDate: map['hegriDate'],
    );
  }
}
