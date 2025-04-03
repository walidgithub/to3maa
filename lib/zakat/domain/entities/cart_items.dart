import 'package:To3maa/zakat/domain/responses/zakat_products_response.dart';
import 'package:To3maa/zakat/domain/responses/zakat_response.dart';

class Cart {
  int? id;
  int? membersCount;
  String? zakatValue;
  String? remainValue;
  String? hijriDate;
  bool? selected;
  Cart({this.id, this.membersCount, this.zakatValue, this.remainValue, this.selected, this.hijriDate});
}
List<ZakatResponse> cartItems = [];
List<ZakatProductsResponse> cartProductsItems = [];
