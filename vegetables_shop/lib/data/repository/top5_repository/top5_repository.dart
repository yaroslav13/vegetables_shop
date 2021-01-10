import 'package:vegetable_shop/data/models/product/top_product.dart';

abstract class TopFiveRepository {
  Future<List<TopProduct>> getTopFiveProducts(
      {String priorityVitamin,
        String priorityUsefulSubstances,
        double calories});
}