import 'package:rxdart/rxdart.dart';
import 'package:vegetable_shop/data/models/product/top_product.dart';
import 'package:vegetable_shop/data/use_cases/top5_use_case/top5_use_case.dart';
import 'package:vegetable_shop/presentation/bloc/base_bloc.dart';

class TopFiveProductForYouBloc extends BaseBloc {
  final TopFiveUseCase _topFiveUseCase = TopFiveUseCase();
  final PublishSubject<List<TopProduct>> topFiveProducts =
      PublishSubject<List<TopProduct>>();

  @override
  void dispose() {
    topFiveProducts.close();
  }

  Future<void> getTopFiveProducts(
      {String priorityVitamin,
      String priorityUsefulSubstances,
      double calories}) {
    return _topFiveUseCase
        .getTopFiveProducts(
            priorityVitamin: priorityVitamin,
            priorityUsefulSubstances: priorityUsefulSubstances,
            calories: calories)
        .then((products) => topFiveProducts.add(products))
        .catchError(print);
  }
}
