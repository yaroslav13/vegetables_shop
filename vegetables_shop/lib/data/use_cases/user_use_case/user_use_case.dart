import 'package:vegetable_shop/data/models/customer.dart';
import 'package:vegetable_shop/data/repository/user_repository/data_user_repository.dart';
import 'package:vegetable_shop/data/repository/user_repository/user_repository.dart';

class UserUseCase {
  final UserRepository _repository = DataUserRepository();

  Future<Customer> getUser(String email, String password) => _repository.getUser(email, password);

  Future<PaymentCard> getPaymentCard() => _repository.getPaymentCard();

  Future<void> updateUser(Customer customer) => _repository.updateUser(customer);

  Future<Address> getAddress() => _repository.getAddress();

  Future<void> updateAddress(Address address) => _repository.updateAddress(address);

  Future<void> updatePaymentCard(PaymentCard card) => _repository.updatePaymentCard(card);
  
}