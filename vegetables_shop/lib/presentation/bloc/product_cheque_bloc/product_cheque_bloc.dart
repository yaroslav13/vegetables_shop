import 'package:rxdart/rxdart.dart';
import 'package:vegetable_shop/data/models/cheque.dart';
import 'package:vegetable_shop/data/repository/cache_manager/cache_manager.dart';
import 'package:vegetable_shop/data/repository/cache_manager/data_cache_manager.dart';
import 'package:vegetable_shop/data/use_cases/cheque_use_case/cheque_use_case.dart';
import 'package:vegetable_shop/presentation/bloc/base_bloc.dart';

class ProductChequeBloc extends BaseBloc {
  final ChequeUseCase _chequeUseCase = ChequeUseCase();
  final CacheManager _cacheManager = DataCacheManager();

  BehaviorSubject<bool> dontShowAgainTip = BehaviorSubject<bool>();

  @override
  void init() async {
    super.init();
    dontShowAgainTip.add(await _cacheManager.getChequeTipStatus());
  }

  @override
  void dispose() {
    dontShowAgainTip.close();
  }

  Future<List<int>> getAllOrderId() =>
      _chequeUseCase.getAllOrderId().catchError(print);
  Future<List<Cheque>> getCheques(int orderId) =>
      _chequeUseCase.getCheques(orderId);

  Future<bool> saveChequeTipStatus() {
    return _cacheManager.saveChequeTipStatus();
  }
}
