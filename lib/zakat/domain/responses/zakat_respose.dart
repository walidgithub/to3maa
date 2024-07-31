import 'package:equatable/equatable.dart';

class ZakatResponse extends Equatable {
  final int id;
  final String membersCount;
  final int zakatValue;
  final int remainValue;

  const ZakatResponse({
    required this.id,
    required this.membersCount,
    required this.zakatValue,
    required this.remainValue,
  });

  @override
  List<Object?> get props => [id, membersCount, zakatValue, remainValue];
}
