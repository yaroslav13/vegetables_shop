import 'package:sqflite/sqflite.dart';
import 'package:vegetable_shop/data/models/customer.dart';
import 'package:vegetable_shop/data/repository/cache_manager/cache_manager.dart';
import 'package:vegetable_shop/data/repository/cache_manager/data_cache_manager.dart';
import 'package:vegetable_shop/data/repository/sql_provider/sql_provider.dart';
import 'package:vegetable_shop/data/repository/user_repository/user_repository.dart';

const customer = 'customer';
const address = 'address';
const paymentCard = 'payment_card';

class DataUserRepository implements UserRepository {
  SQLProvider _provider;
  CacheManager _cacheManager;

  DataUserRepository()
      : _provider = SQLProvider(),
        _cacheManager = DataCacheManager();

  @override
  Future<Customer> getUser(String email, String password) async {
    final db = await _provider.database;
    var res = await db.query(customer,
        where: 'email = ? and password = ?', whereArgs: [email, password]);

    if (res.isNotEmpty) {
      Customer user = Customer.fromSql(res.first);

      await _cacheManager.saveUser(user);
      return user;
    }

    return null;
  }

  @override
  Future<int> postUser(Customer customerModel) async {
    final db = await _provider.database;
    return await db.insert(customer, customerModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<int> postAddress(Address addressModel) async {
    final db = await _provider.database;
    return await db.insert(address, addressModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<int> postPaymentCard(PaymentCard card) async {
    final db = await _provider.database;
    return await db.insert(paymentCard, card.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<PaymentCard> getPaymentCard() async {
    final db = await _provider.database;
    final user = await _cacheManager.getUser();

    var res = await db.query(paymentCard,
        where: 'payment_card_id = ?', whereArgs: [user.paymentCardId]);

    return PaymentCard.fromSql(res.first);
  }

  @override
  Future<void> updateUser(Customer customerModel) async {
    final db = await _provider.database;
    await db.update(customer, customerModel.toMap(),
        where: 'customer_id = ?', whereArgs: [customerModel.customerId]);
  }

  @override
  Future<Address> getAddress() async {
    final db = await _provider.database;
    final user = await _cacheManager.getUser();

    var res = await db
        .query(address, where: 'address_id = ?', whereArgs: [user.addressId]);

    return Address.fromSql(res.first);
  }

  @override
  Future<void> updateAddress(Address addressModel) async {
    final db = await _provider.database;
    final user = await _cacheManager.getUser();

    await db.update(address, addressModel.toMap(),
        where: 'address_id = ?', whereArgs: [user.addressId]);
  }

  @override
  Future<void> updatePaymentCard(PaymentCard cardModel) async {
    final db = await _provider.database;
    final user = await _cacheManager.getUser();

    await db.update(paymentCard, cardModel.toMap(),
        where: 'payment_card_id = ?', whereArgs: [user.paymentCardId]);
  }
}
