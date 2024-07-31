class CartItems {
  int? membersCount;
  int? zakatValue;
  double? total;
  double? remain;
  CartItems(
      {required this.membersCount,
      required this.zakatValue,
      required this.total,
      required this.remain});
}

List<CartItems> cartItems = [
  CartItems(
      membersCount: 2,
      remain: 0.0,
      total: 100.0,
      zakatValue: 100),
  CartItems(
      membersCount: 3,
      remain: 0.0,
      total: 200.0,
      zakatValue: 200),
  CartItems(
      membersCount: 4,
      remain: 0.0,
      total: 300.0,
      zakatValue: 300),
  CartItems(
      membersCount: 5,
      remain: 0.0,
      total: 400.0,
      zakatValue: 400),
];
