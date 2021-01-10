import 'package:vegetable_shop/data/models/product/product_enum.dart';
import 'package:vegetable_shop/utilits/dart_utilits.dart';

class TopProduct {
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
  double vitamin;
  double calories;
  double usefulSubstancesContent;

  TopProduct(
      this.productId,
      this.productName,
      this.pricePerKg,
      this.availableWeight,
      this.packaged,
      this.usefulSubstancesId,
      this.productInfo,
      this.productingCountryId,
      this.productPhoto,
      this.productType,
      this.vitamin,
      this.calories,
      this.usefulSubstancesContent);

  factory TopProduct.fromSql(dynamic sql)=> TopProduct(
    sql['product_id'],
    sql['product_name'],
    sql['price_per_kg'],
    sql['available_weight'],
    enumDecodeNullable(_packagedMap, sql['packaged']),
    sql['useful_substances_id'],
    sql['product_info'],
    sql['producting_country_id'],
    sql['product_photo'],
    enumDecodeNullable(_productsTypeEnumMap, sql['product_type']),
    sql['vitamin'],
    sql['calories'],
    sql['useful_substances_content']
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
