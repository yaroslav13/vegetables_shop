import 'package:flutter/material.dart';
import 'package:vegetable_shop/common_widgets/default_app_bar/default_app_bar.dart';
import 'package:vegetable_shop/presentation/bloc/base_screen.dart';
import 'package:vegetable_shop/presentation/bloc/product_order_bloc/product_order_bloc.dart';
import 'package:vegetable_shop/presentation/pages/product_order_page/order_body.dart';
import 'package:vegetable_shop/presentation/resources/app_strings.dart';
import 'package:vegetable_shop/utilits/extentions.dart';

import 'images_corousel.dart';

class ProductOrderPage extends BaseScreen {
  final UnitTypes unitType;
  final int price;
  final String productName;

  ProductOrderPage(
      {@required this.productName, @required this.unitType, this.price});

  @override
  _ProductOrderPageState createState() => _ProductOrderPageState();
}

class _ProductOrderPageState
    extends BaseState<ProductOrderPage, ProductOrderBloc> {
  @override
  PreferredSizeWidget appBar() => DefaultAppBar.fromText(widget.productName);

  @override
  Widget body() => SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ImagesCarousel(
                  height: MediaQuery.of(context).size.height * 0.35,
                  imagesUrl: [
                    'http://via.placeholder.com/350x150',
                    'http://via.placeholder.com/350x150'
                  ]),
              OrderBody(
                unitType: widget.unitType,
                price: widget.price,
              ),
            ],
          ),
        ),
      );

  @override
  ProductOrderBloc provideBloc() => ProductOrderBloc();
}
