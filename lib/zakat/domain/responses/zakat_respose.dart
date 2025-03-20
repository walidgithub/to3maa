import 'package:equatable/equatable.dart';

class ZakatResponse extends Equatable {
  final int id;
  final int membersCount;
  final String zakatValue;
  final String remainValue;
  final String hegriDate;

  const ZakatResponse({
    required this.id,
    required this.membersCount,
    required this.zakatValue,
    required this.remainValue,
    required this.hegriDate,
  });

  @override
  List<Object?> get props => [id, membersCount, zakatValue, remainValue, hegriDate];
}
