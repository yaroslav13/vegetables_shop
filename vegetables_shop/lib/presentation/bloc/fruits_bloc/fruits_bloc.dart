import 'package:rxdart/rxdart.dart';
import 'package:vegetable_shop/data/models/product/product.dart';
import 'package:vegetable_shop/data/models/product/product_enum.dart';
import 'package:vegetable_shop/data/use_cases/product_use_case/product_use_case.dart';
import 'package:vegetable_shop/presentation/bloc/base_bloc.dart';

class FruitsBloc extends BaseBloc {
  final ProductUseCase _productUseCase = ProductUseCase();

  final PublishSubject<List<Product>> searchFruits =
      PublishSubject<List<Product>>();
  List<Product> allFruits = List<Product>();

  @override
  void dispose() {
    searchFruits.close();
    super.dispose();
  }

  Future<void> getProducts() async {
    try {
      List<Product> products = await _productUseCase.getProducts();
      _getFruits(products);
    } catch (e) {
      print(e);
    }
  }

  void _getFruits(List<Product> allProducts) {
    const fruitsType = ProductType.fruits;
    List<Product> fruits = List<Product>();

    for (var product in allProducts) {
      if (product.productType == fruitsType) {
        fruits.add(product);
      }
    }

    allFruits.addAll(fruits);
    searchFruits.add(fruits);
  }
}
