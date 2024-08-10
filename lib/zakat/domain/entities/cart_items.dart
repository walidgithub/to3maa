import 'package:To3maa/zakat/domain/responses/zakat_products_respose.dart';
import 'package:To3maa/zakat/domain/responses/zakat_respose.dart';

class Cart {
  int? id;
  int? membersCount;
  String? zakatValue;
  String? remainValue;
  bool? selected;
  Cart({this.id, this.membersCount, this.zakatValue, this.remainValue, this.selected});
}
List<ZakatResponse> cartItems = [];
List<ZakatProductsResponse> cartProductsItems = [];
