import 'package:vegetable_shop/data/models/cart.dart';
import 'package:vegetable_shop/data/models/order.dart';
import 'package:vegetable_shop/data/models/totalPrice.dart';

abstract class OrderRepository {
  Future<List<Cart>> getCart();
  Future<Order> getCurrentOrder();
  Future<int> createOrder();
  Future<void> postCart(Cart cartModel);
  Future<TotalPrice> getTotalCartPrice();
  Future<int> deleteCart(int productId);
  Future<void> updateOrder({String orderDate, double totalPrice});
}