import 'package:flutter_laravel/zakat/domain/responses/zakat_respose.dart';

class CartItems {
  int? membersCount;
  int? zakatValue;
  String? total;
  String? remain;
  CartItems(
      {required this.membersCount,
      required this.zakatValue,
      required this.total,
      required this.remain});
}

List<ZakatResponse> cartItems = [];
