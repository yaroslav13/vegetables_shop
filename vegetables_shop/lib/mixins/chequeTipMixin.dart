import 'dart:async';

import 'package:vegetable_shop/common_widgets/tip/tip.dart';
import 'package:vegetable_shop/presentation/bloc/base_screen.dart';
import 'package:vegetable_shop/presentation/bloc/product_cheque_bloc/product_cheque_bloc.dart';
import 'package:vegetable_shop/presentation/pages/product_cheque_page/product_cheque_page.dart';

mixin ChequeTipMixin<Page extends ProductChequePage,
    Bloc extends ProductChequeBloc> on BaseState<Page, Bloc> {
  StreamSubscription dontShowAgainTip;

  @override
  void initState() {
    super.initState();
    dontShowAgainTip = bloc.dontShowAgainTip.listen((dontShow) {
      if (!dontShow) showChequeTip(context);
    });
  }

  @override
  void dispose() {
    dontShowAgainTip.cancel();
    super.dispose();
  }
}
