import 'package:vegetable_shop/utilits/extentions.dart';

enum ProductType{vegetables, fruits, mushrooms, spices, nuts}

extension ProductTypeExtentions on ProductType{
  UnitTypes get getUnitType {
    switch(this){
      case ProductType.vegetables:
        return UnitTypes.kg;
      case ProductType.fruits:
        return UnitTypes.kg;
      case ProductType.mushrooms:
         return UnitTypes.kg;
      case ProductType.spices:
        return UnitTypes.gram;
      case ProductType.nuts:
        return UnitTypes.kg;
      default:
        throw Exception('Undefined type of product');
    }
  }
}