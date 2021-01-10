import 'dart:convert';

import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vegetable_shop/data/models/customer.dart';
import 'package:vegetable_shop/data/repository/cache_manager/cache_manager.dart';

class DataCacheManager implements CacheManager{
  static const String USER_KEY = 'USER_KEY';
  static const String ADDRESS_KEY = 'ADDRESS_KEY';
  static const String PAYMENT_CARD_KEY = 'PAYMENT_CARD_KEY';
  static const String CHEQUE_TIP_KEY = 'CHEQUE_TIP_KEY';

  final Future<SharedPreferences> shrp;
  final RxSharedPreferences rxShrp;

  DataCacheManager()
      : shrp = SharedPreferences.getInstance(),
        rxShrp = RxSharedPreferences(SharedPreferences.getInstance());

  @override
  Future<Customer> getUser() async {
    SharedPreferences sp = await shrp;
    if (sp.containsKey(USER_KEY)) {
      try {
        return Customer.fromSql(json.decode(sp.get(USER_KEY)));
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<int> getUserId() async {
    SharedPreferences sp = await shrp;
    if (sp.containsKey(USER_KEY)) {
      try {
        return Customer.fromSql(json.decode(sp.get(USER_KEY))).customerId;
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<bool> saveUser(Customer customer) =>
      rxShrp.setString(USER_KEY, json.encode(customer.toMap()));

  @override
  Future<bool> saveAddress(Address address) =>
      rxShrp.setString(ADDRESS_KEY, json.encode(address.toMap()));

  @override
  Future<bool> savePaymentCard(PaymentCard paymentCard) =>
      rxShrp.setString(PAYMENT_CARD_KEY, json.encode(paymentCard.toMap()));

  @override
  Future<bool> getChequeTipStatus() async {
    SharedPreferences sp = await shrp;
    if (sp.containsKey(CHEQUE_TIP_KEY)) {
      try {
        return sp.getBool(CHEQUE_TIP_KEY);
      } catch (e) {
        return null;
      }
    }
    return false;
  }
  
  @override
  Future<bool> saveChequeTipStatus() {
    return rxShrp.setBool(CHEQUE_TIP_KEY, true);
  }

  @override
  Future<bool> clear() async {
    SharedPreferences sp = await shrp;
    return sp.clear();
  }
}