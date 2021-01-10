import 'package:vegetable_shop/data/models/customer.dart';
import 'package:vegetable_shop/data/use_cases/user_use_case/user_use_case.dart';
import 'package:vegetable_shop/presentation/bloc/base_bloc.dart';

class UpdatePaymentCardBloc extends BaseBloc{
  final UserUseCase _userUseCase = UserUseCase();

  Future<void> updatePaymentCard(PaymentCard card){
    return _userUseCase.updatePaymentCard(card);
  }

}