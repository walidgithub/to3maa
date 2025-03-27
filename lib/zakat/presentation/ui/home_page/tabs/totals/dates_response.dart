import 'package:equatable/equatable.dart';

class DatesResponse extends Equatable {
  int? id;
  String? date;

  DatesResponse({
    this.id,
    this.date,
  });

  @override
  List<Object?> get props => [id, date];
}