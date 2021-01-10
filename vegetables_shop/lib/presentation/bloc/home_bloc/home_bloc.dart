import 'package:vegetable_shop/data/models/product/product.dart';
import 'package:vegetable_shop/data/use_cases/product_use_case/product_use_case.dart';

import '../base_bloc.dart';

class HomeBloc extends BaseBloc {
  final ProductUseCase _productUseCase = ProductUseCase();

  Future<ProductingCountry> getProductingCountry(int id) =>
      _productUseCase.getProductingCountry(id).catchError(print);
}
