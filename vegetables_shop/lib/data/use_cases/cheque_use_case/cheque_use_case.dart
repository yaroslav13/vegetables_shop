import 'package:vegetable_shop/data/models/cheque.dart';
import 'package:vegetable_shop/data/repository/cheque_repository/cheque_repository.dart';
import 'package:vegetable_shop/data/repository/cheque_repository/data_cheque_repository.dart';

class ChequeUseCase {
  final ChequeRepository _repository = DataChequeRepository();

  Future<List<int>> getAllOrderId() => _repository.getAllOrderId();
  Future<List<Cheque>> getCheques(int orderId) => _repository.getCheques(orderId);

}