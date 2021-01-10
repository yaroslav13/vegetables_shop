import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vegetable_shop/presentation/bloc/bloc_provider.dart';
import 'package:vegetable_shop/presentation/bloc/product_cheque_bloc/product_cheque_bloc.dart';
import 'package:vegetable_shop/presentation/resources/app_colors.dart';
import 'package:vegetable_shop/presentation/resources/app_images.dart';
import 'package:vegetable_shop/presentation/resources/app_strings.dart';

Future<void> showChequeTip(BuildContext context) => showModalBottomSheet(
    context: context,
    useRootNavigator: true,
    isDismissible: false,
    enableDrag: false,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(28.0),
      ),
    ),
    builder: (_) => _ChequeTip());

class _ChequeTip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const _ChequeTipHeader(),
          const _ChequeTipContent(),
          const _DontShowAgainButton(),
        ],
      ),
    );
  }
}

class _ChequeTipHeader extends StatelessWidget {
  const _ChequeTipHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsetsDirectional.only(top: 20.0),
        child: IntrinsicHeight(
          child: Stack(
            overflow: Overflow.visible,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Text(AppStrings.chequeTipTitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: AppColors.mineShaft,
                          fontSize: 18,
                        )),
              ),
              _closeButton(context),
            ],
          ),
        ));
  }

  Positioned _closeButton(BuildContext context) {
    return Positioned(
      right: 15.0,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          padding: const EdgeInsets.all(2.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.mineShaft.withOpacity(0.3),
          ),
          child: Center(
            child: const Icon(Icons.close, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class _ChequeTipContent extends StatelessWidget {
  const _ChequeTipContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Image.asset(AppImages.swipeUp, height: 50.0),
        ),
        Text(AppStrings.chequeTipContent,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: AppColors.mineShaft,
                  fontSize: 16,
                )),
      ],
    );
  }
}

class _DontShowAgainButton extends StatelessWidget {
  const _DontShowAgainButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0, bottom: 30.0),
      child: GestureDetector(
        onTap: () {
          _onTap(context);
        },
        child: Text(AppStrings.dontShowAgain,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: AppColors.coral)),
      ),
    );
  }

  void _onTap(BuildContext context) {
    BlocProvider.of<ProductChequeBloc>(context)
        .saveChequeTipStatus()
        .whenComplete(() => Navigator.pop(context));
  }
}
