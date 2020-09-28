import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vegetable_shop/common_widgets/app_drawer/app_drawer.dart';
import 'package:vegetable_shop/common_widgets/main_app_bar/main_app_bar.dart';
import 'package:vegetable_shop/common_widgets/grid_view_section/grid_view_section.dart';
import 'package:vegetable_shop/presentation/bloc/base_screen.dart';
import 'package:vegetable_shop/presentation/bloc/mushrooms_bloc/mushrooms_bloc.dart';

import '../vegetables_page/vegetables_page.dart';

class MushroomsPage extends BaseScreen {
  @override
  _MushroomsPageState createState() => _MushroomsPageState();
}

class _MushroomsPageState extends BaseState<MushroomsPage, MushroomsBloc> {
  final TextEditingController _searchController = TextEditingController();

  @override
  PreferredSizeWidget appBar() => MainAppBar(
    searchController: _searchController,
  );

  @override
  Widget drawer() => AppDrawer();

  @override
  Widget body() => GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          childAspectRatio: childAspectRatio,
          mainAxisSpacing: 12.0),
      padding: const EdgeInsets.all(12.0),
      itemCount: 10,
      itemBuilder: (BuildContext context, int i) {
        return GridViewProductElement(
          productName: 'Product name',
          price: 200,
          country: 'Ukraine',
        );
      });

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  MushroomsBloc provideBloc() => MushroomsBloc();
}
