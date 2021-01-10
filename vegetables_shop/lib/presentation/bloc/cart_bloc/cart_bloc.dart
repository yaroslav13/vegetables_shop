import 'package:rxdart/rxdart.dart';
import 'package:vegetable_shop/data/models/cart.dart';
import 'package:vegetable_shop/data/models/customer.dart';
import 'package:vegetable_shop/data/models/product/product.dart';
import 'package:vegetable_shop/data/models/totalPrice.dart';
import 'package:vegetable_shop/data/repository/cache_manager/cache_manager.dart';
import 'package:vegetable_shop/data/repository/cache_manager/data_cache_manager.dart';
import 'package:vegetable_shop/data/use_cases/order_use_case/order_use_case.dart';
import 'package:vegetable_shop/data/use_cases/product_use_case/product_use_case.dart';
import 'package:vegetable_shop/data/use_cases/user_use_case/user_use_case.dart';
import 'package:vegetable_shop/presentation/bloc/base_bloc.dart';

class CartBloc extends BaseBloc {
  final OrderUseCase _orderUseCase = OrderUseCase();
  final ProductUseCase _productUseCase = ProductUseCase();
  final UserUseCase _userUseCase = UserUseCase();
  final CacheManager _cacheManager = DataCacheManager();

  PublishSubject<List<Cart>> carts = PublishSubject<List<Cart>>();
  PublishSubject<bool> isCartEmpty = PublishSubject<bool>();

  @override
  void dispose() {
    carts.close();
    isCartEmpty.close();
  }

  Future<void> getCarts() async {
    try {
      var cartsList = await _orderUseCase.getCart();
      carts.add(cartsList);
    } catch (e) {
      print(e);
    }
  }

  Future<Product> getProductById(int id) {
    return _productUseCase.getProductById(id);
  }

  Future<TotalPrice> getTotalCartPrice() {
    return _orderUseCase.getTotalCartPrice();
  }

  Future<void> getIsCartEmpty() async {
    try {
      var order = await _orderUseCase.getCurrentOrder();
      if (order == null) {
        isCartEmpty.add(true);
      } else {
        var carts = await _orderUseCase.getCart();

        if (carts.isEmpty) {
          isCartEmpty.add(true);
        } else {
          isCartEmpty.add(false);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteCart(int id) async {
    await _orderUseCase.deleteCart(id).then((_) {
      getCarts();
      getIsCartEmpty();
      getTotalCartPrice();
    });
  }

  Future<void> confirmBuy({String date}) async {
    var totalPrice = await getTotalCartPrice();
    await _orderUseCase.updateOrder(
        totalPrice: totalPrice.totalPrice, orderDate: date);
  }

  Future<PaymentCard> getPaymentCard() {
    return _userUseCase.getPaymentCard();
  }

  Future<Customer> getUser() {
    return _cacheManager.getUser();
  }
}
