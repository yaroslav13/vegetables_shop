class Cart {
  int orderId;
  int productId;
  double desiredWeight;
  double cartPrice;

  Cart(
    this.orderId,
    this.productId,
    this.desiredWeight,
    this.cartPrice
  );

  factory Cart.fromSql(dynamic sql) => Cart(
    sql['order_id'],
    sql['product_id'],
    sql['desired_weight'],
    sql['cart_price']
  );

  Map<String, dynamic> toMap() {
    return {
      'order_id': orderId,
      'product_id': productId,
      'desired_weight': desiredWeight,
      'cart_price': cartPrice,
    };
  }
}
