import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:vegetable_shop/data/models/product/product.dart';
import 'package:vegetable_shop/data/models/product/product_enum.dart';
import 'package:vegetable_shop/presentation/bloc/bloc_provider.dart';
import 'package:vegetable_shop/presentation/bloc/home_bloc/home_bloc.dart';
import 'package:vegetable_shop/presentation/pages/product_order_page/product_order_page.dart';
import 'package:vegetable_shop/presentation/resources/app_colors.dart';
import 'package:vegetable_shop/presentation/resources/app_strings.dart';
import 'package:vegetable_shop/utilits/extentions.dart';

class GridViewProductElement extends StatelessWidget {
  final Product product;
  final String countryName;

  const GridViewProductElement({
    Key key,
    this.product,
    this.countryName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
        radius: const Radius.circular(16.0),
        strokeWidth: 1.0,
        dashPattern: [5, 4],
        borderType: BorderType.RRect,
        child: RaisedButton(
            color: Colors.white,
            elevation: 0.8,
            onPressed: () {
              _navigateToProductOrderPage(context);
            },
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.40,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 7.0),
                    child: Text(product.productName,
                        style: Theme.of(context).textTheme.subtitle1),
                  ),
                  const Divider(color: AppColors.turquoise),
                  Image.network(product.productPhoto,
                      height: 75.0, width: double.infinity),
                  const Divider(color: AppColors.turquoise),
                  _BriefDetailsRow(
                    type: BriefDetailsTypes.balance,
                    text: product.productType.getUnitType.getUnit,
                  ),
                  FutureBuilder<ProductingCountry>(
                    future: BlocProvider.of<HomeBloc>(context)
                        .getProductingCountry(product.productingCountryId),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.hasData) {
                        return _BriefDetailsRow(
                          type: BriefDetailsTypes.country,
                          text: snapshot.data.countryName,
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  ),
                  _BriefDetailsRow(
                    type: BriefDetailsTypes.price,
                    text: '${product.pricePerKg} грн',
                  ),
                  _BriefDetailsRow(
                    type: BriefDetailsTypes.packaged,
                    text: _getPackingName(),
                  ),
                ],
              ),
            )));
  }

  String _getPackingName() {
    return product.packaged
        ? AppStrings.packagedName
        : AppStrings.notPackagedName;
  }

  _navigateToProductOrderPage(BuildContext context) => Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) =>
              ProductOrderPage(unitType: product.productType.getUnitType, product: product)));
}

class _BriefDetailsRow extends StatelessWidget {
  final String text;
  final BriefDetailsTypes type;

  const _BriefDetailsRow({Key key, this.text, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (text != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(type.detailsIcon,
                height: 20.0, width: 20.0, color: AppColors.defaultIcon),
            const SizedBox(width: 10.0),
            Text(text,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 18.0)),
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}

enum BriefDetailsTypes { balance, price, country, packaged }
