import 'package:vegetable_shop/data/models/customer.dart';

abstract class UserRepository {
  Future<Customer> getUser(String email, String password);
  Future<int> postUser(Customer customerModel);
  Future<int> postAddress(Address addressModel);
  Future<int> postPaymentCard(PaymentCard card);
  Future<PaymentCard> getPaymentCard();
  Future<void> updateUser(Customer customerModel);
  Future<Address> getAddress();
  Future<void> updateAddress(Address addressModel);
  Future<void> updatePaymentCard(PaymentCard cardModel);
}