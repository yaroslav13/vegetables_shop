import 'package:vegetable_shop/data/models/cart.dart';
import 'package:vegetable_shop/data/models/order.dart';
import 'package:vegetable_shop/data/models/totalPrice.dart';
import 'package:vegetable_shop/data/repository/cache_manager/cache_manager.dart';
import 'package:vegetable_shop/data/repository/cache_manager/data_cache_manager.dart';
import 'package:vegetable_shop/data/repository/order_repository/order_repository.dart';
import 'package:vegetable_shop/data/repository/sql_provider/sql_provider.dart';

const cart = 'cart';
const order = 'order';

class DataOrderRepository implements OrderRepository {
  static const int isProcessing = 1;
  static const int isNotProcessing = 0;

  SQLProvider _provider;
  CacheManager _cacheManager;

  DataOrderRepository()
      : _provider = SQLProvider(),
        _cacheManager = DataCacheManager();

  @override
  Future<List<Cart>> getCart() async {
    final db = await _provider.database;
    final id = await _cacheManager.getUserId();

    var res = await db.query(cart,
        where:
            'order_id = (select order_id from [order] where is_processing = ? and customer_id = ?)',
        whereArgs: [isProcessing, id]);

    List<Cart> carts = List<Cart>();

    for (var cart in res) {
      carts.add(Cart.fromSql(cart));
    }

    return carts;
  }

  @override
  Future<void> postCart(Cart cartModel) async {
    final db = await _provider.database;
    await db.insert(cart, cartModel.toMap());
  }

  @override
  Future<Order> getCurrentOrder() async {
    final db = await _provider.database;
    final id = await _cacheManager.getUserId();

    var res = await db.query(order,
        where: 'is_processing = ? and customer_id = ?',
        whereArgs: [isProcessing, id]);

    return res.isNotEmpty ? Order.fromSql(res.first) : null;
  }

  @override
  Future<int> createOrder() async {
    final db = await _provider.database;
    final id = await _cacheManager.getUserId();

    final orderModel = Order.firstCreate(id);

    return await db.insert(order, orderModel.toMap());
  }

  @override
  Future<TotalPrice> getTotalCartPrice() async {
    final db = await _provider.database;
    final id = await _cacheManager.getUserId();

    var res = await db.rawQuery(
        'select sum(cart_price) as total_price from cart where order_id = (select order_id from [order] where is_processing = ? and customer_id = ?)',
        [isProcessing, id]);

    return TotalPrice.fromSql(res.first);
  }

  @override
  Future<int> deleteCart(int productId) async {
    final db = await _provider.database;
    final id = await _cacheManager.getUserId();

    var res = await db.delete(cart,
        where:
            'product_id = ? and order_id = (select order_id from [order] where is_processing = ? and customer_id = ?)',
        whereArgs: [productId, isProcessing, id]);

    return res;
  }

  @override
  Future<void> updateOrder({String orderDate, double totalPrice}) async {
    const bool notProcessing = false;

    final db = await _provider.database;
    final currentOrder = await getCurrentOrder();

    var orderModel = Order(currentOrder.orderId, currentOrder.customerId,
        orderDate, currentOrder.payByCard, totalPrice, notProcessing);

    await db.update(order, orderModel.toMap(),
        where: 'is_processing = ? and customer_id = ?',
        whereArgs: [isProcessing, currentOrder.customerId]);
  }
}
