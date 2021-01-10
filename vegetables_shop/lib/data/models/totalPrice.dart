class TotalPrice {
  double totalPrice;

  TotalPrice(this.totalPrice);

  factory TotalPrice.fromSql(dynamic sql) => TotalPrice(sql['total_price']);

  Map<String, dynamic> toMap() {
    return {
      'total_price': totalPrice,
    };
  }
}
