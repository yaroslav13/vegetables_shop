import 'package:rxdart/rxdart.dart';
import 'package:vegetable_shop/data/models/product/product.dart';
import 'package:vegetable_shop/data/models/product/product_enum.dart';
import 'package:vegetable_shop/data/use_cases/product_use_case/product_use_case.dart';
import 'package:vegetable_shop/presentation//bloc/base_bloc.dart';

class VegetableBloc extends BaseBloc {
  final ProductUseCase _productUseCase = ProductUseCase();

  final PublishSubject<List<Product>> searchProducts = PublishSubject<List<Product>>();
  List<Product> allVegetables = List<Product>();

  
  @override
  void dispose() {
    searchProducts.close();
    super.dispose();
  }

  Future<void> getProducts() async {
     try{
       List<Product> products = await _productUseCase.getProducts();
       _getVegetables(products);
     }catch (e) {
       print(e);
     }
  }

  void _getVegetables(List<Product> allProducts) {
    const vegetablesType = ProductType.vegetables;
    List<Product> vegetables = List<Product>();

    for(var product in allProducts){
      if(product.productType == vegetablesType){
        vegetables.add(product);
      }
    }

    allVegetables.addAll(vegetables);
    searchProducts.add(vegetables);
  }

  Future<ProductingCountry> getProductingCountry(int id) =>
      _productUseCase.getProductingCountry(id).catchError(dispatchError);
}
