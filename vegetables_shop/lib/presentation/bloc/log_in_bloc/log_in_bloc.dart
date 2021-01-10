import 'package:vegetable_shop/data/models/customer.dart';
import 'package:vegetable_shop/data/use_cases/user_use_case/user_use_case.dart';

import '../base_bloc.dart';

class LogInBloc extends BaseBloc {
  final UserUseCase _userUseCase = UserUseCase();

  @override
  void init() {
    super.init();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<Customer> getUser(String email, String password) {
    return _userUseCase.getUser(email, password);
  }
}
