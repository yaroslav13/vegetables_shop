import 'package:vegetable_shop/data/models/product/product.dart';
import 'package:vegetable_shop/data/repository/product_repository/data_product_repository.dart';
import 'package:vegetable_shop/data/repository/product_repository/product_repository.dart';

class ProductUseCase {
  final ProductRepository _repository = DataProductRepository();

  Future<UsefulSubstances> getProductUsefulSubstances(int id) => _repository.getProductUsefulSubstances(id);

  Future<ProductingCountry> getProductingCountry(int id) => _repository.getProductingCountry(id);

  Future<List<Product>> getProducts() => _repository.getProducts();

  Future<Product> getProductById(int id) => _repository.getProductById(id);
}