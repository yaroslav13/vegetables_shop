import 'package:rxdart/rxdart.dart';
import 'package:vegetable_shop/data/models/product/product.dart';
import 'package:vegetable_shop/data/models/product/product_enum.dart';
import 'package:vegetable_shop/data/use_cases/product_use_case/product_use_case.dart';
import 'package:vegetable_shop/presentation/bloc/base_bloc.dart';

class SpicesBloc extends BaseBloc{
  final ProductUseCase _productUseCase = ProductUseCase();

  final PublishSubject<List<Product>> searchProducts = PublishSubject<List<Product>>();
  List<Product> allSpices = List<Product>();


  @override
  void dispose() {
    searchProducts.close();
    super.dispose();
  }

  Future<void> getProducts() async {
    try{
      List<Product> products = await _productUseCase.getProducts();
      _getSpices(products);
    }catch (e) {
      print(e);
    }
  }

  void _getSpices(List<Product> allProducts) {
    const spicesType = ProductType.spices;
    List<Product> spices = List<Product>();

    for(var product in allProducts){
      if(product.productType == spicesType){
        spices.add(product);
      }
    }

    allSpices.addAll(spices);
    searchProducts.add(spices);
  }
}