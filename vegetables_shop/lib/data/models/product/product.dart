import 'dart:convert';

import 'package:vegetable_shop/data/models/product/product_enum.dart';
import 'package:vegetable_shop/utilits/dart_utilits.dart';

Product productFromJson(String str) {
  final jsonData = json.decode(str);
  return Product.fromSql(jsonData);
}

String productToJson(Product data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Product {
  int productId;
  String productName;
  double pricePerKg;
  double availableWeight;
  bool packaged;
  int usefulSubstancesId;
  String productInfo;
  int productingCountryId;
  String productPhoto;
  ProductType productType;

  Product(
      this.productId,
      this.productName,
      this.pricePerKg,
      this.availableWeight,
      this.packaged,
      this.usefulSubstancesId,
      this.productInfo,
      this.productingCountryId,
      this.productPhoto,
      this.productType);

  factory Product.fromSql(dynamic sql) => Product(
      sql['product_id'],
      sql['product_name'],
      sql['price_per_kg'],
      sql['available_weight'],
      enumDecodeNullable(_packagedMap, sql['packaged']),
      sql['useful_substances_id'],
      sql['product_info'],
      sql['producting_country_id'],
      sql['product_photo'],
      enumDecodeNullable(_productsTypeEnumMap, sql['product_type']));

  Map<String, dynamic> toMap() {
    String type = '';
    int isPackaged;

    switch (this.productType) {
      case ProductType.vegetables:
        type = 'vegetables';
        break;
      case ProductType.fruits:
        type = 'fruits';
        break;
      case ProductType.mushrooms:
        type = 'mushrooms';
        break;
      case ProductType.spices:
        type = 'spices';
        break;
      case ProductType.nuts:
        type = 'nuts';
        break;
    }

    switch (packaged) {
      case true:
        isPackaged = 1;
        break;
      case false:
        isPackaged = 0;
        break;
    }

    var map = <String, dynamic>{
      'product_name': productName,
      'price_per_kg': pricePerKg,
      'available_weight': availableWeight,
      'packaged': isPackaged,
      'useful_substances_id': usefulSubstancesId,
      'product_info': productInfo,
      'producting_country_id': productingCountryId,
      'product_photo': productPhoto,
      'product_type': type
    };

    if (productId != null) {
      map['product_id'] = productId;
    }
    return map;
  }
}

class UsefulSubstances {
  int usefulSubstancesId;
  double calories;
  double proteinContent;
  double carbohydrateContent;
  double fatContent;
  double vitaminContentA;
  double vitaminContentB;
  double vitaminContentC;

  UsefulSubstances(
      this.usefulSubstancesId,
      this.calories,
      this.proteinContent,
      this.carbohydrateContent,
      this.fatContent,
      this.vitaminContentA,
      this.vitaminContentB,
      this.vitaminContentC);

  factory UsefulSubstances.fromSql(dynamic sql) => UsefulSubstances(
      sql['useful_substances_id'],
      sql['calories'],
      sql['proteinContent'],
      sql['carbohydrateContent'],
      sql['fatContent'],
      sql['vitamin_content_A'],
      sql['vitamin_content_B'],
      sql['vitamin_content_C']);
}

class ProductingCountry {
  int productingCountryId;
  String countryName;

  ProductingCountry(this.productingCountryId, this.countryName);

  factory ProductingCountry.fromSql(dynamic sql) => ProductingCountry(
        sql['producting_country_id'],
        sql['country_name'],
      );
}

const Map<bool, int> _packagedMap = {true: 1, false: 0};

const Map<ProductType, String> _productsTypeEnumMap = {
  ProductType.vegetables: "vegetables",
  ProductType.fruits: "fruits",
  ProductType.mushrooms: "mushrooms",
  ProductType.spices: "spices",
  ProductType.nuts: "nuts"
};
