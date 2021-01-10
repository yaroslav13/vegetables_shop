import 'package:vegetable_shop/data/models/cart.dart';
import 'package:vegetable_shop/data/models/order.dart';
import 'package:vegetable_shop/data/use_cases/order_use_case/order_use_case.dart';
import 'package:vegetable_shop/presentation/bloc/base_bloc.dart';

class ProductOrderBloc extends BaseBloc {
  final OrderUseCase _orderUseCase = OrderUseCase();

  Future<Order> _getCurrentOrder() {
    return _orderUseCase.getCurrentOrder();
  }

  Future<int> _createNewOrder() async {
    final hasProcessing = await _getCurrentOrder();
    if (hasProcessing != null) {
      return hasProcessing.orderId;
    } else {
      return await _orderUseCase.createOrder();
    }
  }

  Future<void> addProductToCart(
      {int productId, double desiredWeight, double cartPrice}) async {
    final orderId = await _createNewOrder();

    var cart = Cart(orderId, productId, desiredWeight, cartPrice);

    await _orderUseCase.postCart(cart);
  }
}
