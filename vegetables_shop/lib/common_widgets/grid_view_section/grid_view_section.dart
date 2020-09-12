import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:vegetable_shop/presentation/resources/app_colors.dart';
import 'package:vegetable_shop/utilits/extentions.dart';

class GridViewSection extends StatelessWidget {
  final String productName;
  final String calories;
  final String country;
  final String price;

  const GridViewSection(
      {Key key,
      @required this.productName,
      this.calories,
      this.country,
      this.price})
      : super(key: key);

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
            onPressed: () {},
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.40,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 7.0),
                    child: Text(productName,
                        style: Theme.of(context).textTheme.subtitle1),
                  ),
                  const Divider(color: AppColors.turquoise),
                  Image.asset('assets/cucumber.png',
                      height: 75.0, width: double.infinity),
                  const Divider(color: AppColors.turquoise),
                  _BriefDetailsRow(
                    type: BriefDetailsTypes.balance,
                    text: '200 кл',
                  ),
                  _BriefDetailsRow(
                    type: BriefDetailsTypes.country,
                    text: 'Ukraine',
                  ),
                  _BriefDetailsRow(
                    type: BriefDetailsTypes.price,
                    text: '200 грн',
                  ),
                ],
              ),
            )));
  }
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

enum BriefDetailsTypes { balance, price, country }
