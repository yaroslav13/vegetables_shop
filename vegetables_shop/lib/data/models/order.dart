import 'package:vegetable_shop/utilits/dart_utilits.dart';

class Order {
  int orderId;
  int customerId;
  String orderDate;
  bool payByCard;
  double totalPrice;
  bool isProcessing;

  Order(this.orderId, this.customerId, this.orderDate, this.payByCard,
      this.totalPrice, this.isProcessing);

  Order.firstCreate(this.customerId);

  factory Order.fromSql(dynamic sql) => Order(
        sql['order_id'],
        sql['customer_id'],
        sql['order_date'],
        enumDecodeNullable(_logicalMap, sql['pay_by_card']),
        sql['total_price'],
        enumDecodeNullable(_logicalMap, sql['is_processing']),
      );

  Map<String, dynamic> toMap() {
    int isProcessing;
    int byCard;

    switch(this.isProcessing){
      case true:
        isProcessing = 1;
        break;
      case false:
        isProcessing = 0;
        break;
      default:
        isProcessing = 1;
        break;
    }

    switch(payByCard){
      case true:
        byCard = 1;
        break;
      case false:
        byCard = 0;
        break;
      default:
        byCard = 1;
        break;
    }

    var map = {
      'customer_id': customerId,
      'order_date': orderDate ,
      'pay_by_card': byCard,
      'total_price': totalPrice,
      'is_processing': isProcessing,
    };

    if (orderId != null) {
      map['order_id'] = orderId;
    }

    return map;
  }
}

const Map<bool, int> _logicalMap = {true: 1, false: 0};
