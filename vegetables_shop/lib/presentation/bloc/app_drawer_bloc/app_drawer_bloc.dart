import 'package:vegetable_shop/data/models/customer.dart';
import 'package:vegetable_shop/data/repository/cache_manager/cache_manager.dart';
import 'package:vegetable_shop/data/repository/cache_manager/data_cache_manager.dart';
import 'package:vegetable_shop/data/use_cases/user_use_case/user_use_case.dart';
import 'package:vegetable_shop/presentation/bloc/base_bloc.dart';

class AppDrawerBloc extends BaseBloc{
  final UserUseCase _userUseCase = UserUseCase();
  final CacheManager _cacheManager = DataCacheManager();

  Future<Customer> getCustomer() {
    return _cacheManager.getUser();
  }

  Future<Address> getAddress() {
    return _userUseCase.getAddress();
  }

  Future<PaymentCard> getPaymentCard() {
    return _userUseCase.getPaymentCard();
  }

  Future<void> logout() async {
    return await _cacheManager.clear()
        .catchError(print);
  }
}