import 'package:vegetable_shop/data/models/cheque.dart';
import 'package:vegetable_shop/data/repository/cache_manager/cache_manager.dart';
import 'package:vegetable_shop/data/repository/cache_manager/data_cache_manager.dart';
import 'package:vegetable_shop/data/repository/cheque_repository/cheque_repository.dart';
import 'package:vegetable_shop/data/repository/sql_provider/sql_provider.dart';

const cheque = 'cheque';

class DataChequeRepository implements ChequeRepository {
  SQLProvider _provider;
  CacheManager _cacheManager;

  DataChequeRepository()
      : _provider = SQLProvider(),
        _cacheManager = DataCacheManager();

  @override
  Future<List<int>> getAllOrderId() async {
    final db = await _provider.database;
    final id = await _cacheManager.getUserId();

    var res = await db
        .rawQuery('select distinct order_id from $cheque where customer_id = ?', [id]);

    List<int> ordersId = List<int>();

    for (var id in res) {
      ordersId.add(id['order_id']);
    }

    return ordersId;
  }

  @override
  Future<List<Cheque>> getCheques(int orderId) async {
    final db = await _provider.database;
    final id = await _cacheManager.getUserId();

    var res = await db.query(cheque,
        where: 'customer_id = ? and order_id = ?', whereArgs: [id, orderId]);

    List<Cheque> cheques = List<Cheque>();

    for(var cheque in res){
      cheques.add(Cheque.fromSql(cheque));
    }

    return cheques;
  }
}
