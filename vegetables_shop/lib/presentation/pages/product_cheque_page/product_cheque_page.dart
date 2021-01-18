import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:vegetable_shop/common_widgets/default_app_bar/default_app_bar.dart';
import 'package:vegetable_shop/data/models/cheque.dart';
import 'package:vegetable_shop/mixins/chequeTipMixin.dart';
import 'package:vegetable_shop/presentation/bloc/base_screen.dart';
import 'package:vegetable_shop/presentation/bloc/product_cheque_bloc/product_cheque_bloc.dart';
import 'package:vegetable_shop/presentation/resources/app_colors.dart';
import 'package:vegetable_shop/presentation/resources/app_images.dart';
import 'package:vegetable_shop/presentation/resources/app_strings.dart';
import 'package:vegetable_shop/utilits/date_converter.dart';

class ProductChequePage extends BaseScreen {
  @override
  _ProductChequePageState createState() => _ProductChequePageState();
}

class _ProductChequePageState
    extends BaseState<ProductChequePage, ProductChequeBloc>
    with ChequeTipMixin {
  @override
  PreferredSizeWidget appBar() =>
      DefaultAppBar.fromText(AppStrings.chequeTitle);

  @override
  Widget body() => SafeArea(
        child: FutureBuilder<List<int>>(
          future: bloc.getAllOrderId(),
          builder: (BuildContext context, snapshot1) {
            if (snapshot1.hasData) {
              if (snapshot1.data.isEmpty) {
                return const _ChequesEmpty();
              }
              return PageView.builder(
                  itemCount: snapshot1.data.length,
                  scrollDirection: Axis.vertical,
                  reverse: true,
                  itemBuilder: (BuildContext context, int i) {
                    return SingleChildScrollView(
                      child: ClipPath(
                        clipper: MovieTicketBothSidesClipper(),
                        child: Container(
                          color: AppColors.mineShaft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24.0),
                            child: FutureBuilder<List<Cheque>>(
                              future: bloc.getCheques(snapshot1.data[i]),
                              builder: (BuildContext context, snapshot2) {
                                if (snapshot2.hasData) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      ListView.builder(
                                          itemCount: snapshot2.data.length,
                                          shrinkWrap: true,
                                          physics: const ScrollPhysics(),
                                          itemBuilder:
                                              (BuildContext context, int i) {
                                            return _ChequeTile(
                                              cheque: snapshot2.data[i],
                                            );
                                          }),
                                      _ChequeTotalSum(
                                        cheque: snapshot2.data.first,
                                      ),
                                    ],
                                  );
                                } else {
                                  return SizedBox.shrink();
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            } else {
              return SizedBox.shrink();
            }
          },
        ),
      );

  @override
  ProductChequeBloc provideBloc() => ProductChequeBloc();
}

class _ChequeTile extends StatelessWidget {
  final Cheque cheque;

  const _ChequeTile({Key key, this.cheque}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cheque.productName,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          .copyWith(color: AppColors.surface)),
                  Text('${cheque.desiredWeight} г',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: AppColors.surface))
                ],
              ),
              Text('${cheque.cartPrice} грн',
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: AppColors.surface,
                      ))
            ],
          ),
          const Divider(color: AppColors.surface),
        ],
      ),
    );
  }
}

class _ChequeTotalSum extends StatelessWidget {
  final Cheque cheque;

  const _ChequeTotalSum({Key key, this.cheque}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0, right: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(AppStrings.chequeTotalPrice(cheque.totalPrice),
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(color: AppColors.coral)),
          Text(
              AppStrings.chequeDate(
                  convertFromIso8601StringToDate(cheque.orderDate)),
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: AppColors.surface)),
        ],
      ),
    );
  }
}

class _ChequesEmpty extends StatelessWidget {
  const _ChequesEmpty();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppImages.emptyCart, height: 100.0),
            const SizedBox(
              height: 15.0,
            ),
            Text(AppStrings.emptyCheque,
                style: Theme.of(context).textTheme.subtitle1),
          ],
        ),
      ),
    );
  }
}
