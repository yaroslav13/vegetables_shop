import 'package:vegetable_shop/data/models/product/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();
  Future<UsefulSubstances> getProductUsefulSubstances(int id);
  Future<ProductingCountry> getProductingCountry(int id);
  Future<Product> getProductById(int id);
}