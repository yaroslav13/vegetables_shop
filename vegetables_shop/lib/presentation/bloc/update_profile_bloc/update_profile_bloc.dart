import 'package:vegetable_shop/data/models/customer.dart';
import 'package:vegetable_shop/data/repository/cache_manager/cache_manager.dart';
import 'package:vegetable_shop/data/repository/cache_manager/data_cache_manager.dart';
import 'package:vegetable_shop/data/use_cases/user_use_case/user_use_case.dart';
import 'package:vegetable_shop/presentation/bloc/base_bloc.dart';

class UpdateProfileBloc extends BaseBloc {
  final UserUseCase _userUseCase = UserUseCase();
  final CacheManager _cacheManager = DataCacheManager();

  Future<void> updateUser(Customer customer) {
    return _userUseCase.updateUser(customer)
        .then((_) => _updateCachedUser(customer));
  }

  Future<void> _updateCachedUser(Customer customer) =>
      _cacheManager.saveUser(customer);
}
