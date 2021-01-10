import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vegetable_shop/common_widgets/alerts/main_alert.dart';
import 'package:vegetable_shop/common_widgets/animated_main_button/animated_main_button.dart';
import 'package:vegetable_shop/common_widgets/user_placeholder/user_placeholder.dart';
import 'package:vegetable_shop/data/models/customer.dart';
import 'package:vegetable_shop/data/models/totalPrice.dart';
import 'package:vegetable_shop/presentation/bloc/bloc_provider.dart';
import 'package:vegetable_shop/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:vegetable_shop/presentation/pages/update_payment_card_page/update_payment_card_page.dart';
import 'package:vegetable_shop/presentation/resources/app_colors.dart';
import 'package:vegetable_shop/presentation/resources/app_images.dart';
import 'package:vegetable_shop/presentation/resources/app_strings.dart';
import 'package:vegetable_shop/utilits/date_converter.dart';

import 'card_view.dart';

class BackSide extends StatefulWidget {
  final AnimationController flipController;

  const BackSide({Key key, this.flipController}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BackSideState();
}

class _BackSideState extends State<BackSide> {
  @override
  Widget build(BuildContext context) {
    return Transform(
        alignment: FractionalOffset.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.002)
          ..rotateY(pi),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              const Radius.circular(16.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              children: [
                const CardView(),
                const _ProfileInformation(),
                _ButtonManager.fromIconData(Icons.arrow_back_ios,
                    text: AppStrings.backToCartList, onTap: _backToCartList),
                FutureBuilder<PaymentCard>(
                    future: BlocProvider.of<CartBloc>(context).getPaymentCard(),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.hasData) {
                        return _ButtonManager.fromSvgImageData(
                          AppImages.iconBilling,
                          text: AppStrings.changePaymentCart,
                          onTap: () {
                            _navigateToUpdatePaymentCardPage(snapshot.data);
                          },
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    }),
                const Spacer(),
                AnimatedMainButton.fromText(AppStrings.pay,
                    height: 54.0,
                    width: MediaQuery.of(context).size.width * 0.8,
                    onTap: _confirmBuy),
              ],
            ),
          ),
        ));
  }

  Future<void> _confirmBuy() async {
    String date = convertDate(DateTime.now());
    await BlocProvider.of<CartBloc>(context).confirmBuy(date: date).then((_) {
      showMainAlert(context,
              imagePath: AppImages.iconChecked,
              body: AppStrings.orderSuccessCompleted,
              textColor: AppColors.mantis)
          .whenComplete(() => Navigator.pop(context));
    });
  }

  void _backToCartList() {
    widget.flipController.reverse();
  }

  _navigateToUpdatePaymentCardPage(PaymentCard card) => Navigator.push(
      context, MaterialPageRoute(builder: (_) => UpdatePaymentCardPage(card)));
}

class _ProfileInformation extends StatelessWidget {
  const _ProfileInformation();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
      child: Column(
        children: [
          Divider(color: AppColors.mantis.withOpacity(0.5)),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 20.0),
                child: FutureBuilder<Customer>(
                  future: BlocProvider.of<CartBloc>(context).getUser(),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.hasData) {
                      return UserPlaceholder(
                        height: 30.0,
                        weight: 30.0,
                        imagePath: snapshot.data.photoUrl,
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder<Customer>(
                    future: BlocProvider.of<CartBloc>(context).getUser(),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.hasData) {
                        var customerName = snapshot.data.customerSurname +
                            snapshot.data.customerName;
                        return Text(customerName,
                            style: Theme.of(context).textTheme.bodyText1);
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  ),
                  const SizedBox(height: 5.0),
                  FutureBuilder<TotalPrice>(
                    future:
                        BlocProvider.of<CartBloc>(context).getTotalCartPrice(),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                            AppStrings.totalPrice(snapshot.data.totalPrice),
                            style: Theme.of(context).textTheme.bodyText2);
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
          Divider(color: AppColors.mantis.withOpacity(0.5)),
        ],
      ),
    );
  }
}

class _ButtonManager extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;
  final String text;

  const _ButtonManager({Key key, this.onTap, this.child, this.text})
      : super(key: key);

  _ButtonManager.fromIconData(IconData data, {this.onTap, this.text})
      : child = Icon(
          data,
          color: AppColors.mineShaft,
          size: 25.0,
        );
  _ButtonManager.fromSvgImageData(String imagePath, {this.onTap, this.text})
      : child = SvgPicture.asset(imagePath,
            height: 25.0, width: 25.0, color: AppColors.mineShaft);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: GestureDetector(
        onTap: () {
          if (onTap != null) {
            onTap();
          }
        },
        child: Column(
          children: [
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  child,
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Text(text,
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                            fontSize: 14, fontWeight: FontWeight.w400),
                        overflow: TextOverflow.clip),
                  ),
                ],
              ),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
