import 'package:vegetable_shop/data/models/product/top_product.dart';
import 'package:vegetable_shop/data/repository/sql_provider/sql_provider.dart';
import 'package:vegetable_shop/data/repository/top5_repository/top5_repository.dart';

const int topFive = 5;

class DataTopFiveRepository implements TopFiveRepository {
  final SQLProvider _provider;

  DataTopFiveRepository() : _provider = SQLProvider();

  @override
  Future<List<TopProduct>> getTopFiveProducts(
      {String priorityVitamin,
      String priorityUsefulSubstances,
      double calories}) async {
    final db = await _provider.database;

    var res = await db.rawQuery(
        'select product.* , (CASE WHEN ? = "A" Then useful_substances.vitamin_content_A When ? = "B" Then useful_substances.vitamin_content_B When ? = "C" Then useful_substances.vitamin_content_C End) as vitamin, useful_substances.calories, (CASE WHEN ? = "fats" Then useful_substances.fat_content When ? = "carbohydrates" Then useful_substances.carbohydrate_content When ? = "proteins" Then useful_substances.protein_content End) as useful_substances_content from  product join useful_substances  ON product.useful_substances_id = useful_substances.useful_substances_id  where useful_substances.calories <= ?/5  order by useful_substances_content and vitamin  desc limit 5',
        [
          priorityVitamin,
          priorityVitamin,
          priorityVitamin,
          priorityUsefulSubstances,
          priorityUsefulSubstances,
          priorityUsefulSubstances,
          calories
        ]);

    List<TopProduct> topProducts = List<TopProduct>();

    for (var product in res) {
      topProducts.add(TopProduct.fromSql(product));
    }

    return topProducts.length == topFive ? topProducts : null;
  }
}
