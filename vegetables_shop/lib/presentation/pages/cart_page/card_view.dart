import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vegetable_shop/presentation/resources/app_colors.dart';
import 'package:vegetable_shop/presentation/resources/app_images.dart';

enum PaymentCardTypes { mastercard, visa }

class CardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 175,
          width: MediaQuery.of(context).size.width * 0.85,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.paymentCardBackground),
              fit: BoxFit.cover,
            ),
            border: Border.all(
              color: AppColors.mineShaft,
            ),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: _CardDigits(),
        ),
        Positioned(
          top: 20.0,
          right: 20.0,
          child: SvgPicture.asset(
            AppImages.iconMasterCard,
            height: 40,
            width: 26,
          ),
        ),
      ],
    );
  }
}

class _CardDigits extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(bottom: 20, start: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _CardNumber(cardNumber: '4234' //paymentCard.last4,
              ),
          Text(
            '22/07', //_getExpiryDate(paymentCard.expiryMonth, paymentCard.expiryYear),
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
          ),
          Text(
            'Yaroslav Halivets', //paymentCard.name,
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
          ),
        ],
      ),
    );
  }

  String _getExpiryDate(int expiryMonth, int expiryYear) {
    return expiryMonth.toString() + '/' + expiryYear.toString().substring(2, 4);
  }
}

class _CardNumberPlaceholder extends StatelessWidget {
  const _CardNumberPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(
          width: 5,
        ),
      ],
    );
  }
}

class _CardNumber extends StatelessWidget {
  final String cardNumber;

  const _CardNumber({Key key, this.cardNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Row(
        children: <Widget>[
          ListView.builder(
              itemCount: 15,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int i) {
                if (i == 4 || i == 9 || i == 14) {
                  return SizedBox(
                    width: 12,
                  );
                }
                return const _CardNumberPlaceholder();
              }),
          Text(
            cardNumber,
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
          ),
        ],
      ),
    );
  }
}
