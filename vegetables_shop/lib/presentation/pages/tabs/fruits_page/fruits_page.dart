import 'package:flutter/material.dart';
import 'package:vegetable_shop/common_widgets/app_drawer/app_drawer.dart';
import 'package:vegetable_shop/common_widgets/main_app_bar/main_app_bar.dart';
import 'package:vegetable_shop/common_widgets/grid_view_section/grid_view_section.dart';
import 'package:vegetable_shop/presentation/bloc/base_screen.dart';
import 'package:vegetable_shop/presentation/bloc/fruits_bloc/fruits_bloc.dart';

class FruitsPage extends BaseScreen {
  @override
  _FruitsPageState createState() => _FruitsPageState();
}

class _FruitsPageState extends BaseState<FruitsPage, FruitsBloc> {
  @override
  PreferredSizeWidget appBar() => MainAppBar();

  @override
  Widget drawer() => AppDrawer();

  @override
  Widget body() => GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          childAspectRatio: 0.70,
          mainAxisSpacing: 12.0),
      padding: const EdgeInsets.all(12.0),
      itemCount: 10,
      itemBuilder: (BuildContext context, int i) {
        return GridViewSection(
          productName: 'Product name',
        );
      });

  @override
  FruitsBloc provideBloc() => FruitsBloc();
}
