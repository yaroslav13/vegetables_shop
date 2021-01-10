class Cheque {
  String productName;
  String orderDate;
  double desiredWeight;
  double cartPrice;
  double totalPrice;
  int customerId;
  int orderId;

  Cheque(this.productName, this.orderDate, this.desiredWeight, this.cartPrice,
      this.totalPrice, this.customerId, this.orderId);

  factory Cheque.fromSql(dynamic sql) => Cheque(
      sql['product_name'],
      sql['order_date'],
      sql['desired_weight'],
      sql['cart_price'],
      sql['total_price'],
      sql['customer_id'],
      sql['order_id']);
}
