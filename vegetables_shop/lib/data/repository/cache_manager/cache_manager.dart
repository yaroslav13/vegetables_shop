import 'package:vegetable_shop/data/models/customer.dart';

abstract class CacheManager {
  Future<bool> clear();
  Future<bool> saveUser(Customer customer);
  Future<Customer> getUser();
  Future<bool> saveAddress(Address address);
  Future<bool> savePaymentCard(PaymentCard paymentCard);
  Future<int> getUserId();
  Future<bool> saveChequeTipStatus();
  Future<bool> getChequeTipStatus();
}