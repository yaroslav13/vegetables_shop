import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vegetable_shop/common_widgets/animated_main_button/animated_main_button.dart';
import 'package:vegetable_shop/common_widgets/default_app_bar/default_app_bar.dart';
import 'package:vegetable_shop/data/models/cart.dart';
import 'package:vegetable_shop/presentation/bloc/base_screen.dart';
import 'package:vegetable_shop/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:vegetable_shop/presentation/pages/cart_page/font_cart_side.dart';
import 'package:vegetable_shop/presentation/resources/app_colors.dart';
import 'package:vegetable_shop/presentation/resources/app_images.dart';
import 'package:vegetable_shop/presentation/resources/app_strings.dart';

import 'back_cart_side.dart';

class CartPage extends BaseScreen {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends BaseState<CartPage, CartBloc>
    with SingleTickerProviderStateMixin {
  AnimationController _flipAnimationController;
  Animation<double> _flipAnimation;

  @override
  void initState() {
    super.initState();
    bloc.getIsCartEmpty();
    _flipAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 270));
    _flipAnimation =
        Tween<double>(end: 1.0, begin: 0.0).animate(_flipAnimationController)
          ..addListener(() {
            setState(() {});
          });
  }

  @override
  PreferredSizeWidget appBar() => DefaultAppBar.fromText(AppStrings.cart);

  @override
  Widget body() => SafeArea(
        child: StreamBuilder<bool>(
          stream: bloc.isCartEmpty,
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data) {
                return const _EmptyCart();
              }
              return Container(
                height: double.infinity,
                color: AppColors.mantis,
                child: Align(
                  alignment: Alignment.center,
                  child: FractionallySizedBox(
                      widthFactor: 0.9,
                      heightFactor: 0.93,
                      child: Transform(
                        alignment: FractionalOffset.center,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.002)
                          ..rotateY(pi * _flipAnimation.value),
                        child: _flipAnimation.value >= 0.5
                            ? BackSide(
                                flipController: _flipAnimationController,
                              )
                            : FontSide(
                                flipController: _flipAnimationController,
                              ),
                      )),
                ),
              );
            } else {
              return SizedBox.shrink();
            }
          },
        ),
      );

  @override
  void dispose() {
    _flipAnimationController.dispose();
    super.dispose();
  }

  @override
  CartBloc provideBloc() => CartBloc();
}

class _EmptyCart extends StatelessWidget {
  const _EmptyCart();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppImages.noResult, height: 100.0),
            const SizedBox(
              height: 15.0,
            ),
            Text(AppStrings.cartIsEmpty,
                style: Theme.of(context).textTheme.subtitle1),
          ],
        ),
      ),
    );
  }
}
