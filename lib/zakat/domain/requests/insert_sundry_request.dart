import 'package:equatable/equatable.dart';

class InsertSundryRequest extends Equatable {
  final int? id;
  final String? sundryName;
  final String? sundryPrice;

  const InsertSundryRequest({
    this.id,
    this.sundryName,
    this.sundryPrice
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["sundryName"] = sundryName;
    data["sundryPrice"] = sundryPrice;
    return data;
  }

  @override
  List<Object?> get props =>
      [id, sundryName, sundryPrice];
}