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

List<CartItems> cartItems = [];
