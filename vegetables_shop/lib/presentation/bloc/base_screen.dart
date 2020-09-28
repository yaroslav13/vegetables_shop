import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vegetable_shop/common_widgets/loader_indicator/loader_indicator.dart';
import 'package:vegetable_shop/presentation/resources/app_colors.dart';
import 'base_bloc.dart';
import 'bloc_provider.dart';

abstract class BaseScreen<Bloc extends BaseBloc> extends StatefulWidget {
  BaseScreen({Key key}) : super(key: key);
}

abstract class BaseState<T extends BaseScreen, Bloc extends BaseBloc>
    extends State<T> with AutomaticKeepAliveClientMixin {
  Bloc bloc;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    bloc = provideBloc();
    bloc?.init();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider<Bloc>(
        bloc: bloc,
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: Scaffold(
            key: scaffoldKey,
            appBar: appBar(),
            drawer: drawer(),
            backgroundColor: backgroundColor(),
            primary: primary,
            drawerEdgeDragWidth: drawerEdgeDragWidth,
            bottomNavigationBar: bottomNavigationBar(),
            floatingActionButton: floatingActionButton(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            body: _buildBody(),
          ),
        ));
  }

  Widget _buildBody() {
    if (useWillPop) {
      return WillPopScope(
        onWillPop: () => Future.value(false),
        child: _mainBody(),
      );
    } else
      return _mainBody();
  }

  Widget _mainBody() {
    return Stack(children: <Widget>[
      body(),
      StreamBuilder<bool>(
        stream: bloc.loadingStream.distinct(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data) {
            return AbsorbPointer(
                child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: AppColors.surface,
                    child: Center(
                        child: showProgressIndicator
                            ? const LoadingIndicator(color: AppColors.mantis)
                            : Container())));
          } else {
            return Container();
          }
        },
      ),
    ]);
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  void showSnackBar(String message) {
    if (message != null) {
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(message),
      ));
    }
  }

  bool get primary => true;

  Bloc provideBloc();

  Widget body();

  PreferredSizeWidget appBar() => null;

  Widget drawer() => null;

  Widget bottomNavigationBar() => null;

  Widget floatingActionButton() => null;

  Widget bottomSheet() => Container();

  double get drawerEdgeDragWidth => 20.0;

  bool get showProgressIndicator => true;

  bool get useWillPop => false;

  @override
  bool get wantKeepAlive => false;

  Color backgroundColor() => null;
}
