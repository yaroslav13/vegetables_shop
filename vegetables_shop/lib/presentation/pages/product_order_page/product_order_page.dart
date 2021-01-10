import 'package:flutter/material.dart';
import 'package:vegetable_shop/common_widgets/default_app_bar/default_app_bar.dart';
import 'package:vegetable_shop/data/models/product/product.dart';
import 'package:vegetable_shop/presentation/bloc/base_screen.dart';
import 'package:vegetable_shop/presentation/bloc/product_order_bloc/product_order_bloc.dart';
import 'package:vegetable_shop/presentation/pages/product_order_page/order_body.dart';
import 'package:vegetable_shop/utilits/extentions.dart';

import 'images_corousel.dart';

class ProductOrderPage extends BaseScreen {
  final UnitTypes unitType;
  final Product product;

  ProductOrderPage({
    @required this.product,
    @required this.unitType,
  });

  @override
  _ProductOrderPageState createState() => _ProductOrderPageState();
}

class _ProductOrderPageState
    extends BaseState<ProductOrderPage, ProductOrderBloc> {
  @override
  PreferredSizeWidget appBar() => DefaultAppBar.fromText(widget.product.productName);

  @override
  Widget body() => SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ImagesCarousel(
                  height: MediaQuery.of(context).size.height * 0.35,
                  imagesUrl: [
                    widget.product.productPhoto,
                  ]),
              OrderBody(
                unitType: widget.unitType,
                product: widget.product,
              ),
            ],
          ),
        ),
      );

  @override
  ProductOrderBloc provideBloc() => ProductOrderBloc();
}
