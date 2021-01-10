import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vegetable_shop/data/models/product/product.dart';
import 'package:vegetable_shop/data/models/product/product_enum.dart';
import 'package:vegetable_shop/data/models/product/top_product.dart';
import 'package:vegetable_shop/presentation/pages/product_order_page/product_order_page.dart';
import 'package:vegetable_shop/presentation/resources/app_strings.dart';

class TopFiveProductTile extends StatelessWidget {
  final TopProduct product;
  final String priorityVitamin;

  const TopFiveProductTile({Key key, this.product, this.priorityVitamin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GestureDetector(
        onTap: () => _navigateToDetailsPage(context),
        child: DottedBorder(
          radius: const Radius.circular(16.0),
          strokeWidth: 1.0,
          dashPattern: [5, 4],
          borderType: BorderType.RRect,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _mainProductInfo(context),
              _priorityVitaminInfo(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mainProductInfo(BuildContext context) => Padding(
      padding: const EdgeInsets.all(6.0),
      child: Row(children: [
        Container(
          height: 60.0,
          width: 60.0,
          decoration: BoxDecoration(
              image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(product.productPhoto),
          )),
        ),
        const SizedBox(width: 10.0),
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(product.productName,
                  style: Theme.of(context).textTheme.bodyText1),
              const SizedBox(
                height: 7.0,
              ),
              Text('${product.calories} кал',
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                        fontSize: 16,
                      )),
            ])
      ]));

  Padding _priorityVitaminInfo(BuildContext context) => Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text(
            AppStrings.priorityVitaminIs(priorityVitamin, product.vitamin),
            style: Theme.of(context).textTheme.bodyText1,
            overflow: TextOverflow.clip),
      );

  _navigateToDetailsPage(BuildContext context) {
    var productModel = Product(
        product.productId,
        product.productName,
        product.pricePerKg,
        product.availableWeight,
        product.packaged,
        product.usefulSubstancesId,
        product.productInfo,
        product.productingCountryId,
        product.productPhoto,
        product.productType);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => ProductOrderPage(
                product: productModel,
                unitType: productModel.productType.getUnitType)));
  }
}
