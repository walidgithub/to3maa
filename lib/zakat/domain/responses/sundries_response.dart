import 'package:equatable/equatable.dart';

class SundriesResponse extends Equatable {
  final int id;
  final String? sundryName;
  final String? sundryPrice;

  const SundriesResponse({
    required this.id,
    this.sundryName,
    this.sundryPrice
  });

  @override
  List<Object?> get props => [
    id,
    sundryName,
    sundryPrice,
  ];
}