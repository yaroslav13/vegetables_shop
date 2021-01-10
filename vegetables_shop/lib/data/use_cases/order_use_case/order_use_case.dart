import 'package:vegetable_shop/data/models/cart.dart';
import 'package:vegetable_shop/data/models/order.dart';
import 'package:vegetable_shop/data/models/totalPrice.dart';
import 'package:vegetable_shop/data/repository/order_repository/data_order_repository.dart';
import 'package:vegetable_shop/data/repository/order_repository/order_repository.dart';

class OrderUseCase {
  final OrderRepository _repository = DataOrderRepository();

  Future<List<Cart>> getCart() => _repository.getCart();

  Future<void> postCart(Cart cart) => _repository.postCart(cart);

  Future<Order> getCurrentOrder() => _repository.getCurrentOrder();

  Future<int> createOrder() => _repository.createOrder();

  Future<TotalPrice> getTotalCartPrice() => _repository.getTotalCartPrice();

  Future<int> deleteCart(int productId) => _repository.deleteCart(productId);

  Future<void> updateOrder({String orderDate, double totalPrice}) =>
      _repository.updateOrder(orderDate: orderDate, totalPrice: totalPrice);

}
