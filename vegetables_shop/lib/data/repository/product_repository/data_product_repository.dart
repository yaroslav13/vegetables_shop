import 'package:vegetable_shop/data/models/product/product.dart';
import 'package:vegetable_shop/data/repository/product_repository/product_repository.dart';
import 'package:vegetable_shop/data/repository/sql_provider/sql_provider.dart';

const product = 'product';
const usefulSubstances = 'useful_substances';
const productingCountry = 'producting_country';

class DataProductRepository implements ProductRepository {
  SQLProvider _provider;

  DataProductRepository() : _provider = SQLProvider();

  @override
  Future<List<Product>> getProducts() async {
    final db = await _provider.database;
    var res = await db.query(product);

    List<Product> products = List<Product>();

    for (var product in res) {
      products.add(Product.fromSql(product));
    }

    return products;
  }

  @override
  Future<UsefulSubstances> getProductUsefulSubstances(int id) async {
    final db = await _provider.database;
    var res = await db.query(usefulSubstances,
        where: 'useful_substances_id = ?', whereArgs: [id]);

    return UsefulSubstances.fromSql(res);
  }

  @override
  Future<ProductingCountry> getProductingCountry(int id) async {
    final db = await _provider.database;
    var res = await db.query(productingCountry,
        where: 'producting_country_id = ?', whereArgs: [id]);

    return ProductingCountry.fromSql(res.first);
  }

  @override
  Future<Product> getProductById(int id) async {
    final db = await _provider.database;
    var res = await db.query(product,
        where: 'product_id = ?', whereArgs: [id]);

    return Product.fromSql(res.first);
  }

}
