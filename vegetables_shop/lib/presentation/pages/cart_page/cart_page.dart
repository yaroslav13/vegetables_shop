import 'dart:math';
import 'package:flutter/material.dart';
import 'package:vegetable_shop/common_widgets/default_app_bar/default_app_bar.dart';
import 'package:vegetable_shop/presentation/bloc/base_screen.dart';
import 'package:vegetable_shop/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:vegetable_shop/presentation/pages/cart_page/font_cart_side.dart';
import 'package:vegetable_shop/presentation/resources/app_colors.dart';

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
    _flipAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 270));
    _flipAnimation =
        Tween<double>(end: 1.0, begin: 0.0).animate(_flipAnimationController)
          ..addListener(() {
            setState(() {});
          });
  }

  @override
  PreferredSizeWidget appBar() => DefaultAppBar.fromText('Корзина');

  @override
  Widget body() => SafeArea(
        child: Container(
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
