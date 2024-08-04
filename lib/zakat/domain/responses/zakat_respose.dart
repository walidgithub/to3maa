import 'package:equatable/equatable.dart';

class ZakatResponse extends Equatable {
  final int id;
  final int membersCount;
  final String zakatValue;
  final String remainValue;

  const ZakatResponse({
    required this.id,
    required this.membersCount,
    required this.zakatValue,
    required this.remainValue,
  });

  @override
  List<Object?> get props => [id, membersCount, zakatValue, remainValue];
}
