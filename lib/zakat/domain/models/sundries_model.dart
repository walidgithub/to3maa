import '../responses/sundries_response.dart';

class SundriesModel extends SundriesResponse{
  const SundriesModel({
    required super.id,
    required super.sundryName,
    required super.sundryPrice,
  });

  factory SundriesModel.fromMap(Map<String, dynamic> map) {
    return SundriesModel(
      id: map['id'],
      sundryName: map['sundryName'],
      sundryPrice: map['sundryPrice']
    );
  }
}