import 'package:vegetable_shop/data/models/cheque.dart';

abstract class ChequeRepository {
  Future<List<int>> getAllOrderId();
  Future<List<Cheque>> getCheques(int orderId);
}