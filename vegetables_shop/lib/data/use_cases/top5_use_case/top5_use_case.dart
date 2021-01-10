import 'package:vegetable_shop/data/models/product/top_product.dart';
import 'package:vegetable_shop/data/repository/top5_repository/data_top5_repository.dart';
import 'package:vegetable_shop/data/repository/top5_repository/top5_repository.dart';

class TopFiveUseCase {
  final TopFiveRepository _repository = DataTopFiveRepository();

  Future<List<TopProduct>> getTopFiveProducts(
          {String priorityVitamin,
          String priorityUsefulSubstances,
          double calories}) =>
      _repository.getTopFiveProducts(
          priorityVitamin: priorityVitamin,
          priorityUsefulSubstances: priorityUsefulSubstances,
          calories: calories);
}
